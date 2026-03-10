@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Customer KPIs'

@Metadata.ignorePropagatedAnnotations: true

define view entity Z766667_CustomerKpis
  as select from Z766667_TravelWithCustomer as t

{
  key t.CustomerId,

      t.CustomerName,
      t.Street,
      t.PostalCode,
      t.City,
      t.CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum(t.TotalPrice + t.BookingFee)  as TotalRevenue,
      @EndUserText.label: 'AvarageDuration'
      @EndUserText.quickInfo: 'Avarage Duration'
      avg(t.Duration as abap.dec(16,0)) as AvarageDuration,
      @EndUserText.label: 'NumberOfDifferentAgencys'
      @EndUserText.quickInfo: 'NumberOfDifferentAgencys'
      count(distinct t.AgencyId)        as NumberOfDifferentAgencys
}

group by t.CustomerId,
         t.CustomerName,
         t.Street,
         t.PostalCode,
         t.City,
         t.CurrencyCode

having sum(t.TotalPrice + t.BookingFee) >= 5000
