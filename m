Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53102437D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 11:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHMJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 05:40:25 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:46451 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgHMJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597311623; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=EFKwxRSQX32g+H2lMRRMihuC0lO2s4dTK0vqxKDrUB+r26NxuY+zaAkRo7IzVP70SsOcAfCZRQxHGrIxAFA/xJVV20kOa8h5K+QjhzjGmKnulyJVovZapG91HQeQetayhpBdVNo5HreDNvHOFV5qhxAHhx7anLCmAR8cpUcG+/hWyNcBe9Gn+v74/T1JLzRIJehEkmkeQAV5OA00U2ySjf6nvcJFFiY2bCPIBgGBWslZTUXFBRcSZaHqNYT6CSYmnSIzPL+jRz68iqkQE6rFwdl+VbK74aOu28tE83WBikp+ORgIY1xUep2vqLjOq3POtH/582ECAr4lEA3HqX4ncg==
X-YMail-OSG: XotM3AkVM1m1ElWgdc9yLaVgq0lhszQd83TG9UEMjbq4K3J5FXKO1Y51emd_ayP
 gF1yHoPg5qUAcDtIN0A7WEA_BR.tcsFKcL3993d5sru7JjTwsaZpc8oIMdNQh6wMbFJorg0qCqjq
 3GLhmlS5vRTzAblFlYaEOCk_rUtIT7QdFljuzq1jRmNELh5UjjvC0bsfxCkRn95zl6Dzf8jVWGZ1
 Dzu_A7p07oANXNr3_m.OL30v8qhfgE6Nh5WGSa.yE8YCJKX0EUyJXlIW7TG5pul1C9eenfY_tl5S
 hJweAgX0XOJPfwj2mulMRr7ChusF.Yik3LPltXV.Td_pYmeTG0gJ4JaGu0hfVn83F_XRYKGStpK7
 booaY5_xkttO3taZtruoTkSgmwL9caL2ZVlorbuNa00kk_wbXyEsL.HGtjKe.x4osMBr51oqXVdA
 5m_yagRG0VwX3CUGTiINXPOx8ijbpF0eGKj8K._Mj_EW9R1QasuipO.H0mpU9YuAdFbiBEpcN9_k
 fA8M7V7QkEz3Cot4Y67MJYKy8PRZgqeMP7_wv7quVG5sKBrfkN9pcyn94glniLXzLbgGasm9J4wl
 rBAixY4pdYSEWi47UZ3chp3gmgQVJKwnovmxEgb_gRiK7kKjolUYZCwyisXVhCivcO3PSwWoNZey
 lIBLKwglszmLvPGLtT5CmKE74XrcbDZqeH3GjtoB3C8DpEv3xtgOrurf19MJrNT_vW5Ymi.8FOOh
 L7kGwsT7pexazWKXutkOrz1SVke_roeffAvU.XLur.8HYDYhWXHakz7HTy_E4aXRSrLr0pRRl4zU
 TsHIJHU_ZxZLgaulxZwFclgLXk8e6D5jYEiW96flLypj3v7b5v8NQvfFlLphRBqKCZxjOWX7brxW
 p4XjFMzESPz_Y93QdV3Szy39J.UXd.n5qQRb4nx._DyVML1G5fSu6r8W0z9eBpC6PoOciFhZufWV
 FAE.i5PCLYOykxAX54DFQj5WWROslo0NOHmMAiptuDucKLRG5ec6P1SdC.DKlBbGJ2MkPZhymNr1
 AgRvCKO0YqOWaaqPYlTOobyKr.KwKLO4i0rkFVFRHBe.Iu6dWMetjFBw6DGyEf1u5VCvD4RhKSzJ
 ZISTVIysNmVczJWSTVxg_3Xi.Zlc9sy1JtSwtkPeqkf3yl76Y1qmIuH.jNXLGlw0Tb_dBdBC2Ju4
 lvrsO5FaSVoPRyYsKcKC45qC8VzGwylsjxdIucurHIGGpQTt0psPGwPwYOslvaLftkHub2w5DeJZ
 0Wujr2GBDTOU7rM.JBOm9rLLzbS8N4tjShQr8PnIy8GqT456FYSVljR5J5iaE.u8c2M7AeCzqnry
 WUu7GQsPSOY8t3gwspJ2xHvxavEKoV89G7xrUKhxGZI63.p4amnaS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 13 Aug 2020 09:40:23 +0000
Date:   Thu, 13 Aug 2020 09:40:19 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrsminaaaliyahbrunel1@gmail.com
Message-ID: <865643431.1001377.1597311619872@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <865643431.1001377.1597311619872.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

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
