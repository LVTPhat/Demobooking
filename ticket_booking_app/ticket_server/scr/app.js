import express from 'express';
import morgan from 'morgan';
import { connectDB } from './config/db';
import MovieRouter from './Router/movie_router';
import BannerRouter from './Router/banner_router';
import DateRouter from './Router/date_router';
import SeatRouter from './Router/seat_router';
import TimeRouter from './Router/time_router';
import SeatOrderRouter from './Router/seat_order_router';
import UserRouter from './Router/user_router';
const app = express();

connectDB('mongodb://localhost:27017/ticketmovie');

app.use(express.static('scr/assets'));

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/movies', MovieRouter);
app.use('/banners', BannerRouter);
app.use('/dates', DateRouter);
app.use('/seats', SeatRouter);
app.use('/times', TimeRouter);
app.use('/seatorders', SeatOrderRouter);
app.use('/users', UserRouter)
export const viteNodeApp = app;
