Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601721F6A71
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgFKO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 10:57:56 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com ([77.238.176.98]:33842
        "EHLO sonic301-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbgFKO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591887472; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=G/fpNdWUM0KBG0JUJu0cYuSKUKpB41zMCD4Hejc3hxFiisS8YYV5kVVFLn68nDIUkb8jZfUDw/9jXUQQPnhOjYQ2qSug67MLOmAB3gU+ni0rQzg92dR2R2k7ST+PsUrhBjf8VIGiMz+5E0LtdrbiwbtrP2tQ1M1Sk7LT1MAOw3AGQ/xeNU/kkr0aXnisv8jquqdo+Jjs2iQGn+uKM4ZK5ZY0e3ojH8Z+A6akulwpXMLeLaDZvkLjo+xB7aBZxOYkmXWh6QuakqUTEsclaSjx6xee2gD/0bCbTzNLYzryu4onhOdzYkJozje16iK661YuDCexpxoLPCQXeO6Szz5cMA==
X-YMail-OSG: Y2TX5qAVM1kKuSDSTp.oMXVtqG8wS1.BQ9ZLl7G6tvLTDjhXqLZZuJk5wMCba4w
 vOuEslzhYHmUY2yCjJUTC.EJpybFywIods8fK02KsHd9jLnSL8_6YSK7LIDmSfl1EJe1hDlm4KGw
 ARV5O4QliS9z8P7zo.GE5iYGm0F2BpaVgONHxj080XwbdHhw6BP.jBtmxA.KLcDk4D1GtFn8U0xj
 N.4i8J75GkN7Xs.i1g1WsWGkm2m6sX7QoWdcSUFCyAgLIifJ81TU1X.4dXuO42Q2jmbtFGFphfAh
 VQ0ZUMQyiInEOojxMAki13DwcxSpfK4g6qYQx_QIzoH3_cURciUWOGK.F6Dn0R2_W1j0r0Ydkpbk
 jarVunOAoXSwuJszGj4orl4m9_ByxmJ2RGN1R37l6yBfinhiR_yFnLwMYSI.FfboXTJ5TIVrEsJS
 FbSM1p3FzTFAjk7jQrHV.ssUwYPfOWGl0KfqZv.kDPkGbueRe7mOFIPDWjddBxbMTORdxZ1eVx57
 nP.qZpPSFHSYwao3ESov40bhKwtSZe7c281MUO_aPMTV4EKZkXRmkGM7yMi8WEDJ3t42TjF1Mn.f
 FrnmG90h3zKKvjcd2nADj4TE7O8sFPMMrjJDdKDKosUm.EL0OGhcDfzHNojRz2RYiZ5cb5Gjymux
 _33mndqWV7ENiOBokYtpBtf.5lB9q1UxPtLNWdX_y_oUFQG7IMqZ7YTGUTW5gXXOuAa7FIrDWU_o
 kB4k47kjPrh2_7tgleTCz_1RlhyQnkboBrjIGiJWYaAZANZLT0hVfc4sF.gLLWRx5TnladGoYBCi
 Jd2oMBUUeeVM105zhSLqCiJ.Oqnh4FPQEGClstiqkWAdQ6X4scTK2eUPg3qYpBjTImIMgP5ckBHb
 uyX3fmGCtbGyZ3jsOcFdnhrCXiu11_fRPUTlmu_bhrxLQeG4G_K.onu3SmIRfQ50olt_aRC9rxMh
 gbQ1UnA00.48BiEGo79usJlQaHTic2Hx3tkW3uDK0Gr3mhRQ7McLvIJS9vABNhRVsd52cUrn423V
 xG6wJ2Y1U.sWh2MjctOs.b.tjl38CgXqzb9rm25.QYWmBW7_2ep7i8gjk3UNXHxd7q0HsPsUYfNx
 DyNYbMllPJPW7HHyoLxcXn5oMUEPx.fj_58Wko7tDQ.7VrPSOgPQaY8RgeJoU5bGc5MtT23JXlt_
 E_1DB1oXXRKHtiRNJlSgCLgeEs.FXDywMc1upe7X_6JzSXJ.GUgWStV3tEJxF00qR8Z4AzubeS69
 8eDkYPjbHPNffvBVxo3LGfEZXyUOWUPMeKsSnFNXnE651vnaJrYKrC9SMUvyOcxS8f6IYLqjSmA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 11 Jun 2020 14:57:52 +0000
Date:   Thu, 11 Jun 2020 14:57:49 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <719366095.3010298.1591887469771@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <719366095.3010298.1591887469771.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
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
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

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
