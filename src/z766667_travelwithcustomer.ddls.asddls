@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel with Customer'

@Metadata.ignorePropagatedAnnotations: false

define view entity Z766667_TravelWithCustomer
  as select from Z766667_Travel   as t

    inner join   Z766667_Customer as c on t.CustomerId = c.CustomerId

{
  key t.TravelId,

      c.FirstName,
      c.LastName,
      c.Title,
      c.Street,
      c.PostalCode,
      c.City,
      t.AgencyId,
      t.CustomerId,
      t.BeginDate,
      t.EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.BookingFee,
                          source_currency    => t.CurrencyCode,
                          target_Currency    => cast('EUR' as /dmo/currency_code),
                          exchange_rate_date => $session.system_date,
                          error_handling     => 'KEEP_UNCONVERTED')                as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.TotalPrice,
                          source_currency    => t.CurrencyCode,
                          target_Currency    => cast('EUR' as /dmo/currency_code),
                          exchange_rate_date => $session.system_date,
                          error_handling     => 'KEEP_UNCONVERTED')                as TotalPrice,

      t.Description,
      cast('EUR' as /dmo/currency_code)                                            as CurrencyCode,
      t.Status,

      case t.Status when 'N' then 'Normal'
                    when 'P' then 'Pending'
                    when 'B' then 'Boarding'
                    else 'Error'
      end                                                                          as StatusText,

      dats_days_between(t.BeginDate, t.EndDate)                                    as Duaration,
      concat_with_space(concat_with_space(c.Title, c.FirstName, 1), c.LastName, 1) as CustomerName
}

where c.CountryCode = 'DE'
