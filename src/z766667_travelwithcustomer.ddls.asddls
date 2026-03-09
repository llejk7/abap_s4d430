@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel with Customer'
@Metadata.ignorePropagatedAnnotations: false
define view entity Z766667_TravelWithCustomer
  as select from Z766667_Travel   as t
    inner join   Z766667_Customer as c on  t.CustomerId  = c.CustomerId
                                       and c.CountryCode = 'DE'

{
  key t.TravelId,
      c.FirstName,
      c.LastName,
      c.Title,
      c.Street,
      c.PostalCode,
      c.City,
      c.CountryCode,
      t.AgencyId,
      t.CustomerId,
      t.BeginDate,
      t.EndDate,
      t.BookingFee,
      t.TotalPrice,
      t.CurrencyCode,
      t.Description,
      t.Status
}
where
  c.CountryCode = 'DE'
