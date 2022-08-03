describe('add to cart', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("User can add item to cart", () => {
    cy.get("button").contains("Add").click({force: true});
    cy.contains('.nav-link', 'My Cart (1)').should("be.visible");
  });
});