const configYargs = require("webpack-cli/bin/config/config-yargs")

describe('homepage', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});