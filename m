Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DCA205636
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbgFWPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 11:41:59 -0400
Received: from sonic307-2.consmr.mail.bf2.yahoo.com ([74.6.134.41]:39834 "EHLO
        sonic307-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732942AbgFWPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592926918; bh=Uv9Il0GvVfNf8ySja/n2kkVJo04KZ3nX+ejOBNQOQ/8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gLsv7Nvqz8ZI/vmtt+5QfKC9S67NxI2VG+rsC5u30lMg8pThiB4ttg01ePCif4BGQIYryr/eC8cRgf1CfAAWaVXkmlO6ouvnGWlcw6lj2e3gExoUA9B4gq56M57vVX7oHMQpLVMhiOS329dCdodZ4QRIZmM2JluRSdNZKtWgZpXGFBmjRDuSTEi9o0JLWAers2/3I2n0t7uxjpoLrADY5svsNzn/uyNsTZ1StokDCYda5n8+ZQVJ1rs/tVT7xVJYiavRdR9GH9Y7Iao0khTguzCSzwZ7G07gXZX15u5vuj2mw1oo4JKSHHcXEWzZ+3EnXmuGVA0Fc4CiXKym8TTTiw==
X-YMail-OSG: 2.cqplcVM1nCAUc9U6wWy3rFRq_BiUYQlAj5ldmdVBxZi.kK_bVst2l3_2kf3xf
 eF3gb6RGOpCBTMjjVSSA8MzkyEBJC_wkWmWSwpExzo._59ytwvsfUEMz4vrTPA20y.DyrvpXMeIy
 GOzrKnoHrggeDchTCoL9lbzQNNUnB7PKOfeeJTxDTK98eXNzNldfQt3_M36tBBjbVDwvURZFbcyu
 OAOdlZMynoAIEEhHZ3KBDi5a0bbLVwaz3oLkuIOO27x3_x9s1JF8FmxL7gM1EZ3x1aZk2XZRCnZS
 yjrLoaKjRWpmUoqMNh4yXJENcYKvnLAz_.2tZyihTTh6786FJCsTJ1kV.TU1DDAX1gw7wGYbXY6E
 a8B7NsgRQHU2upAMGXapv2XgRD9Xc7Ya7Wsu5xgN.5DkPbsruw0CNGZua3FEDir5JZJY4lEDwHeF
 AvHYqcJSh5jbx9Gj0zUgOA6OBmMW_aAlo5L8UL73woAn2xs9yRZndt1SSmJDQSab_9D_1DjCgfC0
 GZwX97lolzNJaN2P_EdxwHxK1FwpZ7U4SPRtU4tGm1PWfMl3dBtmD4K1kQmgeKPj16UZU.vp.h3B
 jL3CqfDkh73SPPiVqHd2oKu7tvL5xtSn8og9oZckQEasytn4yCsk0tjxCw6Y2lyxGoW8vQppv_M5
 axQ04YylW3E6xUHEfp9qOQG1mqIKl9jSnqNXo9uOQJkRa5A6_I7IHz7QNiSX__lL8OtzYux1OCk9
 pp5gsE199uu04KmtXQcQ_omyM1Tva7RB7cHDEOw.ymFMT1GGg1WZ6_jU5656wsJjK1c4EhKfljlW
 1pC6c2aO1G8sKAJGYs.W_hC.N7xmmNYLvJfwtjKiTwkTTz9mI0c_2STCINq9QMHzS3V.DqFnwv1h
 c8bbRlI_tJV1HIjew7I69RbFLC8o_Far0Kk6fgKpFSkVkaJ18AWk3OGZfOZYOextLeXqdXudUlt4
 ki5o6qgefFnMm4wIznw62CXDDB6zsT7WsGJeQly8sAoV20Uj50oHPHmR2WCy__aVrFbQb4LDolMO
 eoUHiRNJmPywO3hDkYavAHIsWyKDLRxnDMJ2QPJYTmTjG0Ux6eP85cVCbdVGcVQKYVvB4Me3ZFN6
 JfoWscssLqGDvkvqcrJPJcduHOB3WbIxM1xRCcp2meXnvZXa2n2cSPXYSo5Ay2JYjwZ4PDM6hZRZ
 19QtHd4.2Q5JmI6Ix6CB9Lm9BIDy2kUmFnF9wEwGZ45OBSJCs2DtfazGrK4T0L.dPTVQWH1IwLkk
 YUDM8_Unj0br5vyCwnVsSclKwQ0Q6dkx6DPrTZz86dCn4OIA3LF1V8NS_B5O2O6hpkeyyY3DjTjJ
 jBHT4UQT1eng-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Tue, 23 Jun 2020 15:41:58 +0000
Date:   Tue, 23 Jun 2020 15:41:58 +0000 (UTC)
From:   Barr Kummar Faso <barrkummarfaso@gmail.com>
Reply-To: wu.paymentofic@fastservice.com
Message-ID: <974620190.1748971.1592926918023@mail.yahoo.com>
Subject: YOUR GIFT WESTERN UNION PAYMENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <974620190.1748971.1592926918023.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ATTN;BENEFICIARY:





You are welcome to Western UNION office Burkina Faso.



Am Barr Kummar Faso by name, The new director of Western Union Foreign Oper=
ation.


I resumed work today and your daily transfer file was submitted as pending =
payment in our Western union Bank and after my verification, I called the f=
ormal Accountant Officer in-charge of your payment to find out the reason w=
hy they are delaying your daily transfer and he explained that you was unab=
le to activate your daily installment account fully.


However, I don't know your financial capability at this moment and it was t=
he reason why I decided to help in this matter just to make it easy for you=
 to start receiving your daily transfer because I know that when you receiv=
e the total sum $900.000.00 usd that you will definitely compensate me.



I don't want you to lose this fund at this stage after all your efforts. Mo=
st wise people prefer to use this medium western union money transfer now a=
s the best and reliable means of transfer,Kindly take control of yourself a=
nd leave everything to God because I know that from now on, you will be the=
 one to say that our lord is good, so I will advice you to send me your dir=
ect phone number your address,country,Pass port because I will text you the=
 MTCN through SMS and attach other information and send to you through your=
 email box, Sender name Sender=E2=80=99s address with including all documen=
ts involve in the transaction.


For this moment I will be very glad for your quick response by sending sum =
of $25.00 so that I will quickly do the needful and finalize everything wit=
hin 1:43pm our local time here, I am giving you every assurance that as soo=
n as I receive the $25.00 that I will activate your daily installment accou=
nt and proceed with your first transfer of $7,000.00 before 1:43pm our loca=
l time because I will close once its 6:30pm.


Contact person Barr Faso Kummar
contact Email: wu.paymentofic@fastservice.com



Be aware that all verification's and arrangement involve in this transfer h=
as being made in your favour. So I need your maximum co-operation to ensure=
 that strictest confidence is maintained to avoid any further delay.


Send the $25.00 through Western Union Money Transfer to below following inf=
ormation and get back to me with copy of the Western Union slip OK?


Receiver's Name...
Country.... Burkina Faso
Text Question..........Good
Answer.............News
Amount .......$25 USD
MTCN............


I felt pains after going through your payment file and found the reason why=
 you have not start receiving your fund from this department and ready to d=
o my utmost to make sure you receive it all OK?


Be rest assured that I will activate your daily installment account and pos=
t your first $7,000 USD for you to pick-up today as soon as we receive the =
fee from you.


Please do not hesitate to contact us again should you require additional in=
formation or call +226 74 43 41 61 for further urgent attention, as we are =
here to serve you the best.


Regard's
Barrister Kummar Faso
New Director Western Union Foreign Operation
Our:Code of conduct:1000%
