Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775222626A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGTOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:46:03 -0400
Received: from sonic303-2.consmr.mail.bf2.yahoo.com ([74.6.131.41]:46875 "EHLO
        sonic303-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGTOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595256361; bh=Sq0m1vvm2SZTihycyLIp46MmEaT+M4u+5ZuM67ujUHw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=DADLqsmF7B0m6ozQ3t8Ed9y+F6AfmAp7SJMBjxlGcsqi4TyBxhvs68cg0QUTHyDjkfkVOChQSxnQYLradGzyxSqsmTqHWZAbiQSGKVqC/22tQ4Qs+rfhwqLvA0sJ4iOuDpBfCbCH3QuJ05jGylJ2/EQQlw33XiUooG7FImXccHqj1Fdf9gN+mxNwr5XT2qn1HfLRe7SpAgVqfc1honT1J5sRUyIafldpTbz65nWwuXNK5P1lEXnDvf/ayzpfU6/5aY7L2PfK7wcU99ukcfcdBVZHo+SU9qRdMNPToIgOtoGK/2I4wRzpaCM/wSdwrvMDBemImurJ4Z8tyjHCtOgx8A==
X-YMail-OSG: 2CC_FtkVM1mntexO0COSA.XaGhyxR31rN808SbXHiO.4S1Voub_wae2maDUdyxC
 pyTXBnnXuQpBwVzVRpc3ZcdeNwzfRLN7Wr8X4rx3MCPO9dL7WyzPTKViXDyus4AKhAvLWDxVc5eb
 t_F0oyoGhwiBnR3bdJKDqWcqlo7stvF2PvsM.W9mQxH7eVMNqFbZiU7cwNUhNtkND4SqubmoZeuA
 7qN6rF82rfvTq8MDpTD15htqF1yCRITYAJZ0tgGyBciRz3paTN6IFq68Z3G8rJ.nRaNR3jBsIkoY
 .GXAonORJwhVfOsi4oDHisxIejXmGBQeKyVt6MBdHbzfZjYmK1DM36H1s0R09EWjcDq_tBabbJ7Z
 4efMTWFTIzqpy2YC0dA.MX2nZ2jIMVcq89DkSxtnQEwpGpHF3NPSp00mjQioyrnlwdtC7pzMu6B7
 elyBIspsTh1C.IUcjQdpIbQJrLF0YcexwK2gEtr.vwzcprQH9b8ISVJb0Gkehw_pVvEmg1yGJx30
 AxQVZvuukUHp9B8CY9tz2yXrVey90DtRmJ62aa9qZ4bBbid8iy3cfSD26.fAxytPGSZDVW6julNf
 abBl0alLRc8zs8wgQ0kdqZWEWYxI42jdcUBOgjVprZgOyQDmuwrrj58BSUN6JdqMqDGuRwcyScC7
 ZFFaXhtO4NX9jdaGrgypPzXHMRVgVAWv_mKwM9AIDP2ovEpVLuwTUfBO7wwviaB_mi5a55IWTAyy
 kDoka4je1dvzFir1RKs4.nXk6xZmEsR.qOid6nxXyqttI1eps1ITyG7BElkwpW_5FsjeaGaAjnbZ
 x60jaIpa.e5iB55PdbrE9tvKuM7QWmz_QDrz3YfOv3Q5MTa1mBohdd0YZnUQoWM9R2uOFQPQaXFV
 XcvQU0s1bk8nm4rzZR0nGoCqBdwvV2g1c0s9eHSf4a5qAMD1jC4NZdrDS5QexgVBr7w0rG8FJQId
 YwH2QrId6tyd2c2wmMPvbUcaXANEjUFzDE4mCB3fQZyLpiiGhPq03ndH3LLqAcD..jDILZY2gUYO
 ZLE_e7hh7zI7rFzrdx86BjADOQM3Lq6wceaclgpos9eJfJLovZ6lqSYnNJBVbRQswa1xDheOVG1g
 M.YcGDkDEfcoWcwM2iiqOfo6h2xzWuba5r1eiDJM5ZmQJ85c05n52E5xJF10cRfNWbpElftn83BE
 4gKnianywcuowcptgPasO9LsGQ7VyuRxwEftLnOuCdYQT29EHDwzJAR2PLrq5WxegKBqiefX.vF0
 3QeFm7lG995g9kh7lftCvOKdIej7euOqLqdFgIGoU.jXSqpqSojC2ro2.v4zLK7rSiG0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Mon, 20 Jul 2020 14:46:01 +0000
Date:   Mon, 20 Jul 2020 14:46:00 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <annahbruun6@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <851366762.3022576.1595256360284@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <851366762.3022576.1595256360284.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Rome the c=
apital city of Italy in Southern Europe. The money was from the sale of his=
 company and death benefits payment and entitlements of my deceased husband=
 by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
