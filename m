Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE31C4010
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgEDQhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 12:37:53 -0400
Received: from sonic306-2.consmr.mail.bf2.yahoo.com ([74.6.132.41]:41990 "EHLO
        sonic306-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729459AbgEDQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1588610271; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NrbIaY9un0cN0BPUu1yxMAne/8fJdCgSMKVMyF0hNvV+gZdjCJycrSALftzZdlzGNlKQeNBqOYc87Tg3w0MMaXG7a+FNdwRm22aplhJoH2MX9Y+NHp+mFsDCZNaSR5KiLj2VlhJSUQwumBVZSwfXOLeo5rMe0ARf1g/PKU/WU1ai8RBHZTUlhsPhZWNFCJNloQs3/QMO0jhOgGRhqZJsDTN87PoVvtzKkO2nZYb8M3xb0xvvxs0y7wt5lnqrVZdK0SMnRoT67Vz+OV7VtzI0fGEPlT3vuqkqf+RO4vfBxdYZfjHKILet5zWX6N2eIN9zNZMl6u40NasAABSJFwqUSA==
X-YMail-OSG: wTKrySIVM1mGoWz9pAp7GDJIrgNRdvuveOXJNrZcMJBzTfS8OglhrwoO1Ao.lk7
 q2tne.V1ApsdcdmznOG9a4R1NLR20S7kPgtj4zMlO9aV3DSNJyk8amFnBSWn2E03XwyzF4Yx0XGL
 C4OBp4c4EVHHZa1l1oTZTvnRYiatNXBTbQs6yYRShrOpeccbzkxj.h7H_JMNiB6buJ6TTtUT.feP
 of5uhr4z7LK.7jITsWGvCFUpAk511stmNBtJzz.8MeQT9tj7X09oKsSIbCR6wSewZ.DekIBbXR9q
 u.Hx1d6poGwohvzNVjoiC7iiYFtnPo08cDUfu4SyD0VZjQ5hQ7jTcaILjRqeoo0xnO5loYy_6X1w
 HZb6cU1BJdcX8tS9b.CriACkgUHLX0SJoMQsvWsuAY9lpeBjRv3i8SErU7cw9z2Azd.hH6PJgrbm
 QlO6vEBxYCmVM6AOTxuwHM9Z0z44qYaxPKp8Ii.2xy4yx4Nc8KJuhQKo4DVjqS6P9sIoq76ZGUgy
 VZNY6oA.KtZqhEaFy6EqmIZPQBp8FfXBFFenu89S3x0djY_Id8H451rlpkQ_DtxEiQpSDxo54GtB
 00BXPwelY30CcE5adbYvUNUKDbkntgx0dga1_8jWUERDjxp5ffmRmbrBEGXabrEpk6y5CmtLv388
 t2PoRqGFURG1SjlOzjjC9S9ylclTq0siL3ieR1SzFFf7h8ZYfcTMeEq04z.WwS2jCmZncmWtLfEA
 NLHbrfZCg.KW1UeLiXFxipHUDkpmkisTGKul8QiDxv_gGAOipSjT0JluU.cJNtzwcvVkjBhQXaMm
 lxMbwuQqqFn16pytWp06heVsBbToWrbADnESTMIP9dxy81JWqQ9jbVM2cOfdzilRcbgyzzxXLj2Q
 Se6v94s61szxsZ87xjOrL2vTbAcFQOOaJQ8t96L0AoKDcb8.PVmFFPk5vhDt09DdkfTMtz_envpj
 IhAgR_CHir1McuXlxO9Fgq8di6Mptp_arqZ4CsrHpMy6Yi1enAKE.BB_cFmwR8OOtGbskUm0JJXi
 s1P.Uu_oIP5D9P8S1OhSJqHneK9RPtTSC_0.7y6gD0Z0ownmV6MbzZ02gnijpnwlavFrOrAPHR84
 GMLWbYzmzYXxpQdM8lxrp55ihL8PZQaAXMt0gXbvT84JosN1N7edWbRnklEjV_UhUApDIGhTbEir
 gO7nT0y_gktoC2PXMejww2e4BEjHTBo7hjH7WjaDTYfVqfm91uHFFCZgK2EfE6iyYKLah9f0SAxd
 CM.NzviLySv5U7SSFil1UKZxt12Z0AbjzQZXDnx6IDbvXOwuwGHNyOzUI6tRCa1VP4Rk1zLVZww-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 4 May 2020 16:37:51 +0000
Date:   Mon, 4 May 2020 16:37:47 +0000 (UTC)
From:   "Mrs.A.Mina" <brunel.m@aol.com>
Reply-To: brunelmrsminaa@gmail.com
Message-ID: <2044753010.676646.1588610267052@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2044753010.676646.1588610267052.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
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
