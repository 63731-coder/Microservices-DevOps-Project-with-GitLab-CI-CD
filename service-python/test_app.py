import unittest
from app import app  # Assure-toi que ton fichier s'appelle app.py

class FlaskAppTestCase(unittest.TestCase):

    def setUp(self):
        # Crée un client de test
        self.app = app.test_client()
        self.app.testing = True

    def test_message_endpoint(self):
        # Envoie une requête GET à /api/message
        response = self.app.get('/api/message')
        
        # Vérifie que le statut HTTP est 200
        self.assertEqual(response.status_code, 200)
        
        # Vérifie que la réponse JSON est correcte
        expected_data = {"message": "Hello from Flask!"}
        self.assertEqual(response.get_json(), expected_data)

if __name__ == '__main__':
    unittest.main()

