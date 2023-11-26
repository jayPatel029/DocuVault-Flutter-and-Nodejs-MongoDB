const chai = require('chai');
const chaiHttp = require('chai-http');
const path = require('path');
const app = require(path.resolve(__dirname, '../server'));
const expect = chai.expect;

chai.use(chaiHttp);

describe('API Tests', () => {
  it('should return "Hello NODE API" at root endpoint', (done) => {
    chai.request(app)
      .get('/')
      .end((err, res) => {
        expect(res).to.have.status(200);
        expect(res.text).to.equal('Hello NODE API');
        done();
      });
  });

  // Add more test cases for other endpoints
});
