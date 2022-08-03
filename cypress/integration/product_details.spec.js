describe('product details', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("User can navigate to the product detail page", () => {
    cy.get(".products article").first().click()
    cy.get(".product-detail").should("be.visible");
  });
});