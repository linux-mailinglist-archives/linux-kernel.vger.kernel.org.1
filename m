Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EE225E184
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIDSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 14:36:43 -0400
Received: from sonic305-2.consmr.mail.bf2.yahoo.com ([74.6.133.41]:43324 "EHLO
        sonic305-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgIDSgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599244580; bh=e/CL6i8OdXlzIOqf/LHibwd/Yd81a6YYqZVzE+mq23g=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ai+WRyuGJmKyNBWxWqxQz8KBKKSv6cvPf/7tva6xZ8MFCuIO0Ym9jttuK45hBuOV1Ca7fNGX+TpzdVgwl3iWAAFfe+c13XBB6w22KjDUHjZZKeOxqo0Q/YxZ6C8BaBucSGpnX8EB2gXCxgEJKvQnMOUFikPIpTlKTzvbPXLdvhPbr301NaW5oTsCiTl4JSyU3Rj7eLysd/bIu555tY8xa8eWdZgwbHIQqgtglXgAdZAyGPEfgOgPczO5xxfz2tCiHGCEr0ec4SWx+yVtu53LftWvLz1Is3ITt9Vl1EcC9DCXXGad53vFdhd3m9Sfmnu6HhKxvyqkgcDlVI2CDK3kEw==
X-YMail-OSG: .OR5YzoVM1kn8RQsbRpok2GAvq.WX.xo6pHa0WW8F6UE8.oYWqvGFuLAH_zJQpq
 EVMYlF4Sr5Luwy0Rt7xTfdeeeWf5W9hnWFh.vfPrNKYCjLB8SxV5K6CoWMnPJSrUGm4MnxI3zaxr
 cqBLQgyPSZZ.QKOIpz1vzeLcyLfh0176L50BhkCI7vicyjmcuHADhT4ARhhaSNGbCmDoPPBTAjvX
 AiimsYG.fOrXqBUJAL7OIv.SgyJRUmh9zhzQ2WHuBYh_kHCdEoN1EfGZ5tzbjgb3vk2WcILmVIvP
 lNofpj27YkbqXsh56KTjJFIyXB_BQZyLV7QRxbBfJnYWfgJnsG11_b2BRjPrS7f3tctOUqJ2PPlD
 3ZSOnJLDArbJ65Q_L.ai.YOzQu1BDjKXRE5VkxiZk_uCzUpMxT4cfKqPwuyhDTRDheVHtHLoDvzn
 cQAJtbqpedx_FYIjP1ewbpDKwd36jihWmrtFtA4HNhfEAroiznTeFlYdNXOUbLJYqQLInELf8G.E
 fwyLRg7e4_uDROeVuOtzrQ3Z3HPji3H1hJmXt9t7sonmKbBpIikHWh79HnAFgX2lLJysMSbjYM4M
 SG9BGtnGpcZ4p5bX1gDz1sWr7cuLNEQ3v4EjZmyO25nUZlARkQs_u.NVjKwex2bVWKn.CvVVvwoZ
 eZyCwLPsM1GDduJ5ATUkFmlLxhUeafjT2vnf7b.1QF.2_cBderYovtxQE.snYC58PYo5Ccdup4mk
 M.ycfKZq8UI9NkQPFZAUEone9d8z2ZGPYVNfSa7aWptq0hWJFdY.HLSwcP9hHusLCP_2kzq_svle
 R9ToeQeKOoe0JXErhQ9dZi5JN3aSFevnOrX_NQaoi_ezp2EGwHG6u9xaocvXtLVjVa2M1VtjqjWY
 y1154vku9Ix1_cia5lY432EJlO8AKOKDBeArzfVCQ808xztl1GCxKL_BhQ.DxI2aSKQI.JpIysYL
 qoh9hrX.tjQmr8BsWOh3snr7lwyCH9xs3POjT2e.SOWYKc2gR7tTIBDuqkgp4wmXXXGCkkcXIhjX
 DbBNBXz6syfq8aJFskIdD2ehB3TRLR8._uojbADHtvtaE0f06RoblcotLpagd70_glLOAR1OvEpe
 y_XF3n6nPS7S82hDK190K.PIihjf0ih0PiEuJNhy4oZjAK3NFZTBqLaEX0U6hcVq...2LOCxMdBJ
 G_iYxflFHHS6ztWd1c_xiAepHtQyU71aaoiBIvC.kCUAmtp39Dn8R1SD_EyumiU1G0lw76DW9Y_8
 H2qic9Rxqv92nLSMpnHJFTuXSn1mEIXQRJHVKqmQfHcjkXO8sT2.8e.ImGvXQKwq91M2d0xeqlEg
 4ZlVXPn0XAgkpEiU7f10aIT1YGM.RCrJSoVZHEYyHrYiiQyQaHo7XZoTd3kWLXQAuHM6BSuVZ73O
 eBWfj9sk8Cmi_iohBKN1zyr3VDr_pHO3ii2_uXiGxKYM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 4 Sep 2020 18:36:20 +0000
Date:   Fri, 4 Sep 2020 18:36:15 +0000 (UTC)
From:   Ms Theresa Heidi <james29234@gmail.com>
Reply-To: mstheresaaheidi@yahoo.com
Message-ID: <1470760630.2459339.1599244575086@mail.yahoo.com>
Subject: =?UTF-8?B?6ri06riJIOuPhOybgOydtCDtlYTsmpTtlanri4jri6Q=?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1470760630.2459339.1599244575086.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Beloved One,=20

CHARITY DONATION Please read carefully, I know it is true that this letter =
may come to you as a surprise. nevertheless,i humbly ask you to give me you=
r attention and hear me, i am writing this mail to you with heavy sorrow in=
 my heart,i have chose to reach you through Internet because it still remai=
ns the fastest medium of communication, after going through your profile in=
 search of an honest person.

My name is Mrs Theresa Heidi i am native France currently hospitalized in a=
 private hospital here in Israel as a result of lungs cancer I am 62 years =
old and I was diagnosed of lungs cancer for about 4 years ago, immediately =
after the death of my husband, who has left me everything he worked for. I'=
m with my laptop in a hospital here in where I have been undergoing treatme=
nt for cancer of the lungs

Now that is clear that I=E2=80=99m approaching the last-days of my life and=
 i don't even need the money again for any thing and because my doctor told=
 me that i would not last for the period of one year due to Lungs cancer pr=
oblem.I have some funds inherited from my late husband, the sum of $15 Mill=
ion United State Dollars ( US$15,000,000,00 ),

This money is still with the foreign bank and the management just wrote me =
as the true owner to come forward to receive the money for keeping it so lo=
ng or rather issue a letter of authorization to somebody to receive it on m=
y behalf since I can't come over because of my illness or they may get it c=
onfiscated.

I decided to contact you if you may be willing and interested to handle the=
se trust funds in good faith before anything happens to me.This is not a st=
olen money and there are no dangers involved,is 100% risk free with full le=
gal proof.

I want you to help me withdraw this money from the foreign bank then use th=
e funds for Charity works/assistance to less privileged people in the socie=
ty.It is my last wish to see that this money is invested to any organizatio=
n of your choice.

I want you to take 45% of the total money for your personal use while 55% o=
f the money will go to charity. I will appreciate your utmost confidentiali=
ty and trust in this matter to accomplish my heart desire, as I don't want =
anything that will jeopardize my last wish.

Yours Beloved Sister.
Mrs Theresa Heidi
