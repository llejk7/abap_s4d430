@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel with Customer'

@Metadata.ignorePropagatedAnnotations: false

define view entity Z766667_TravelWithCustomer
  as select from Z766667_Travel                   as t

    inner join   Z766667_Customer                 as c
      on t.CustomerId = c.CustomerId

    inner join   DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                   p_domain_name : '/DMO/STATUS') as d
      on d.value_low = t.Status and d.language = $session.system_language

{
  key t.TravelId,

      t.AgencyId,
      t.BeginDate,
      t.EndDate,

      @EndUserText.label: 'Duration'
      @EndUserText.quickInfo: 'Duration of the travel'
      dats_days_between(t.BeginDate, t.EndDate) + 1                                as Duration,

      @EndUserText.label: 'Booking Fee'
      @EndUserText.quickInfo: 'Booking Fee'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.BookingFee,
                          source_currency    => t.CurrencyCode,
                          target_currency    => cast('EUR' as /dmo/currency_code),
                          exchange_rate_date => $session.system_date,
                          error_handling     => 'KEEP_UNCONVERTED')                as BookingFee,

      @EndUserText.label: 'Total Price'
      @EndUserText.quickInfo: 'Total Price'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.TotalPrice,
                          source_currency    => t.CurrencyCode,
                          target_currency    => cast('EUR' as /dmo/currency_code),
                          exchange_rate_date => $session.system_date,
                          error_handling     => 'KEEP_UNCONVERTED')                as TotalPrice,

      @EndUserText.label: 'Currency Code'
      @EndUserText.quickInfo: 'Currency Code'
      cast('EUR' as /dmo/currency_code)                                            as CurrencyCode,

      t.Description,
      t.Status,

      @EndUserText.label: 'Status Text'
      @EndUserText.quickInfo: 'Status Text'
      d.text                                                                       as StatusText,

      c.CustomerId,

      @EndUserText.label: 'Customer Name'
      @EndUserText.quickInfo: 'Customer Name'
      concat_with_space(concat_with_space(c.Title, c.FirstName, 1), c.LastName, 1) as CustomerName,

      // c.FirstName,
      // c.LastName,
      // c.Title,
      c.Street,
      c.PostalCode,
      c.City
}

where c.CountryCode = 'DE'
