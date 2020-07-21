Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC2227F08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgGULgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 07:36:49 -0400
Received: from sonic312-23.consmr.mail.ne1.yahoo.com ([66.163.191.204]:36273
        "EHLO sonic312-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgGULgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595331408; bh=noZqzc0DO7ubYu76k6w0ZDMYGSjIHNz057Kts8cuH1w=; h=Date:From:Reply-To:Subject:References:From:Subject; b=QYYk0lvbFsyuQCqh1obBMMFEt0Im1jQIH2hGvowMPBFItRzHRY7nwzxMQlubCYsDwqhh+BH6FmamWtxgSDq8JVe1DU8kh6oXC4ve7QX0GG1zwIkG9PBwNwtGWBU4ls//9o8w7/uee9RhRNNfclckXjDa2S4o5JcGOB5qW62ccmTSmxYv16kBPRmhxmQ5sK8TKUIU+iJNeAvKuG9MJeQ8Fovvcis99CyFyEjq961yoX7Sxkcs4+cRbXnsnw9mrMGRU6HS+cdzPJ0dcq/jQyXXKNDYit0Hwy80QshGugxhqTB7m17JaFHqYHjaPkCLCZXQzs+kK+UoJDE//NHVFmXSkg==
X-YMail-OSG: 5fxo4_cVM1nnmUMxa.I9EU6MFNlE55439P3ZvWi22G3hph1.U53AUqFaZEGD0kj
 dMpgL2ptu56StoQnyhITeH.wFvAKG1sHqvE1Rp2K5XFSRQIjeQt18ZAxHxpBMtn7IFWvXYf.4Byb
 CE2l_w9FdqpVmDTT1zI.Ft4qMpglKuPajaS8hNiVWYkga2UXuAYR8cZ7GmAjCYTnn0va_P0EBdVE
 UPV0zvA1yww2ZrUlvu2_uBLBZE0GkfMiU4oXBsE1Hwc6wkkAHX.RK3YK2zeHM8cbIdIOK9h7b1ww
 p7IYAs5UPI4ardLjZTeLhXrS.yTYSmDjJ6pCDGEAgE4zNGQeNIsH5BYO6YvPJUxVqoM80F_bh9Dw
 3qVFokGM62AbGt4c3.zLsQ.iK2HLS8RTqvx9fYMKx0xIo6qVeqswnybmU_9Fks0V3dB86t.MB4cm
 wjVbbXoIEvaTNB6SqvaXLsuSb1aHn7ZlNYwSg09nm2wD15OyC5gP2hYvOvAE8Hjz.2.yGzIGTeFL
 zgyRj5kwGHFI8jxNOqQXlwaqcWydLN4dwfuXNG5jtRm7.3EApB1JwR3sq3njPCkhpb51bTq2ZgI1
 c6KXJOlsIZTVHnDSBPEOMLbLs1R19..zlYxviczClpO2yaHCqHtmE6wb3fI0XGyV2INdHHqsZ23M
 CX7ny9SdQc2YsJclNfhpVZK8YXbKHTy1X0HgzWFhrz_XWEBl_9ObH1Fdo3Kdy07rC6WrWNMDhhX3
 76ljfBJYRFRVRSSUcFrKaSyZTCKJ_kEAShr2zbka1U_uR3_MWxJ5s0Ej9BRx.pZMtZBvlrBGhL0O
 UwYRjD0jdgzDP4PgHU6P0w0C9abQLc_1S82GYzk09WcO2fwV9OMnBk9CeINSpJ7Uzv4Rl3B75v6p
 IBkt1BjD5W4cHfAHKr3u_VXR9ES6Ck8nG5jb3uZucmXAtYy8fu9BCMF9HQ0exXwSnq2Xhdlr1.q.
 69uCSiReLEO8iaPb4KwsPM9Lat9Z9MawSdzJCvP6Px1nz1WGisbK5J9CeG9nhOOwG7jxpLb9uqsu
 yT_ySjkTjZGciIS8JhaEvfoMLjyeMJd8dxf.ItWyPNn9fuzPIzpHRGgAM..pEIN3SGkn36AUKvv4
 AOxo0_8mcmjadNzPjG4.JgKF6phC4d0cZt.I3EpdONIRP8phB4PS0JITBLzCj1oY2haC35ws01iP
 ZPtqM.Rci2IeGiwr0fQzwSab7tZgKf7i6zZeAklzqFUl9BKOuBGs06xV2tNudrePnlJJub4D4TYf
 Fny4AHJVDlk3CuuIZkDJPjYrl8Qfl26bC4Q1NlH.iCfCl.8A_ghbi2ONnjd5fRwvhsEwXQiUGVJb
 E
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Jul 2020 11:36:48 +0000
Date:   Tue, 21 Jul 2020 11:36:44 +0000 (UTC)
From:   Philippe Don <phisiaka01@gmail.com>
Reply-To: phisiaka1@gmail.com
Message-ID: <63492591.4811734.1595331404972@mail.yahoo.com>
Subject: I am Dr. Philippe Don,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <63492591.4811734.1595331404972.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 10.0; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attention: Friend,

How are you, I am Dr. Philippe Don Siaka, a medical doctor working with Gab=
riel Toure Hospital Bamako Mali, please don't be upset by the way i am send=
ing this message to you without knowing you before, i  only trying to rende=
r help that is needed from me by someone who is no more with us in this wor=
ld,

A woman who had an accident with her car was brought to our Hospital some w=
eeks ago and i was her doctor for some hours before she died, well may her =
soul rest in peace Amen, her names are Ms. Young-shin Kim, From South Korea=
 Nationality,

Now why i need you is because of her last words to me before she dies, she =
told me about a deposit she made with Islamic Development Bank ISDB in Turk=
ey, The sum of(=E2=82=AC5,500,000)Five Million Five Hundred Thousand Euros,=
 according to her she deposited the money without any next of kin because s=
he don't have any child or relatives,

according to her she was an orphan, All this was a top secret from her and =
she asked me to look for someone from Asia Nationality if possible or anywh=
ere out of Africa continent who will contact the Bank in Turkey so that the=
 fund can be transfer to the person for charity purposes, she gave me some =
vital information about the bank and the money which i will give to you whe=
n i get your update. her words about the fund according to her she wants th=
e money to be used for charity purposes to help some less privileged in our=
 society 70% of the money will be for the charity work and 30% will be for =
the person who will do the work. I am waiting for your update on this matte=
r.

Thanks & Best Regards,
Dr. Philippe Don Siaka,    =09
