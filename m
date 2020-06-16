Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E591FBB97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgFPQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 12:23:03 -0400
Received: from sonic310-14.consmr.mail.bf2.yahoo.com ([74.6.135.124]:42991
        "EHLO sonic310-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbgFPQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592324580; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Mp54p/+PgOP1t03GZ3iJkcKEVJYwEyx9FbacFXz3HCi1+0REQQS+BurG8G+JSb0U/jcm9rDPBoYe5tshAmgGn5oNYwJUxVtrUQF7NYQAg9AAklIr/sdCfpuCAO0O8k4+v9AUwqnJeTzlChzbIVQs3/G9uUcS1J3d6vo5HflCttXjmeb0yuSE0QawSFGZK8hNWIxv+IFYW/PNYK/3p/vf6fTS9sY2b++tgu4TobYg3bouyUl6wfKh1+Pd4sNfKqekuOYYvM3fpV5sh7oCcfKKjz2TuRB3/Sp1XFkyum77NBNgmmGkg7mj64grPhIinRZLRzEEm+vEaK+KvTgwi72AUg==
X-YMail-OSG: zY8ZzbkVM1klaMbH86VfK2DepupsJ66kN9UVGyDglyAhpxJ6vTfV.th351efCFw
 EOQ1uJ7IVWjWDZpcM5PuyEEpsKtsph3G14mbWcRKSdziBOs3F5z5JUa2pQYHD8XL2EYTT58X_UtW
 J9bFYvrLUnxkoH.4iScbVnCtW0PBuxOhC3sbUsvIBlyR5X0hKhWHcRm_qrUvqfdwQ7.BMP7SCKuS
 Ef6K.Zq1Z28vVQpAledvsNHNVTvBAQ0RI8jibGrXJij8h.ZCOD.rsYI8SE7lImoUMfZ_.4t4SvLQ
 XkrbnRDvpNIImpfKgeA.o2J6D2KCcvfm186U.wlfor65v7TYMRk22aOhON1xqdgkRYfn3Qdik.Bo
 GCmMrtcsnvBJaIniIkDnnYRpuLWiw2RRUbUaitLXr86cwf.auX_Jsr0yQifkHSIKFPmoO0nMoYv.
 P_eopmTBJgUWyZv_f3rdKrtPDeCGAeJDfWkHSilagqhc.Qu4GaPdXQO.dpWeb_xXjdyMDV6n8FZC
 UWBtqPG1i.n9Xunqk8YKWHpJv48dEamkY7An08xidy8lrQefvA2hyaYzaQuQOi77hp6dfct3LIKO
 vum8CB3ugNbQXsE5XogTSl0OTLINEDWHa4SdsZ1kO34JE0Lu2cXfC6EhmXxkKBmkYY.fM2oZzIU5
 JSxQe.Z4LDT5LDN3qxP.vhMgq.fhRcTPpdTsIwhSWIQpxP8Bq4pk.ttAINenEFYxXbacdvNN4GLk
 brqZRycQCW_VWM8tWK1u2UuH.Mw.5i67w07hx24ogu_m6Nxlym_5Kkx85M26uDr0LiEfrSWaOZd9
 MR.cztkE12bagy9vcLdXpGJUnlxYfjzxulBuARXvRZzKCXQ4_kK9I6osFSEfpjoiMUz9FKMabHWM
 Y64o79z4dHJmodb7AUsIs_faydQEhRH8wh1to0L_Fk_ZdHCGh1Q6rl94cQcfvIufhYE4lfuP4pSg
 UwMp3vC2x0J2slBvimRnrbM8TWZ9q.5hA3kH8QaZF9tUY1HXwzkz3fT.POZTnjp9chwSyRPCWY6w
 dSsfJtrwRj4BjEWxObohcONN_BnplBB4mg8W9OSaXNMRxlBR3rIv6DpN9OrrwmqWnJFspW1KqBlh
 qG2mxs5AjKGUWQMZOZbhXZpYPH8VKTCK4WrFm6r9lNGDTpc9TlqzPZ4rBTu9tyaXEZ9c6SE3LZHj
 dayTbIo.G3fJ5ZNOL4jU.bcAfAQR9PJAihUmo0HY8hyZeP9241HoQDFFHNbaiPNpr_6OyaySI_IK
 vP2_8m1uHZYy9fgicfl5qsTLHQhqLb5aF3PGD2CyCUIYIqePVHlUJAJRPK3xGK4nVDkuRhUDfRD4
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 16 Jun 2020 16:23:00 +0000
Date:   Tue, 16 Jun 2020 16:22:57 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <brunelminaa@gmail.com>
Reply-To: mrsminaabrunel63@gmail.com
Message-ID: <1625071902.1193206.1592324577113@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1625071902.1193206.1592324577113.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
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
