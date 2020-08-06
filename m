Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C646523DBF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHFQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 12:38:42 -0400
Received: from sonic303-2.consmr.mail.bf2.yahoo.com ([74.6.131.41]:41920 "EHLO
        sonic303-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729015AbgHFQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596731766; bh=Sq0m1vvm2SZTihycyLIp46MmEaT+M4u+5ZuM67ujUHw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XDKQPZHrbbUC73v3sLnFxOYCgpEIOLz7Gr4DgNDYFK6Jld7I0hNKQaFW1bgPynLEK9VfnU7xlPLbs4l1+nqQS6wbijK9pTz8/w8a5nqoZHwd+6Z78Q4qxPIDOWQocNhX3cNyYqxJbM54LVFTT7WcEKcLRVDV5l/Jbr+fTIbHsxZcGCe5xmDwKbkCNSDb9zoCO/2+dpaTaZz2RHZQN5gXg8zGpTd+5/95uAmBBD4XSuz/RxbVrJ81d0+QeoqJ9JFkxJQwwHNQnUoSuPh1QN3Xtu1wxh4EmtG59OqEsAmPt4KLDv43Dofxcj3Q+KF0r8frwyf4tHW+06Vc23dnOKkwhA==
X-YMail-OSG: _aUucakVM1lP.hRmB57UA0ZMO9yFOz6ju1cxj_7h1DshilUcD0Yndx9gSibU10I
 NEH0pYbket2Ny0CzJ.0rx7u4VTDGe3fPEODmvvIULv0WfhSKizdj42eBQ5IJEIpJeHFrLllc6AIs
 mT.Y3eoak7eTKENWmS_6YHC3yot1y1z7nXpvB4JpyfROVZDqSxloflRiFfJuYBj9ZX1YSmp3jiow
 1hC2JArmU6UNfw6a1Cdiud5CPVLNvdNmZMWWRx0xka2CUvlPb7x53eI96IHUs1rC.XfAQD4hGUyk
 XErHyBLnGcgVxtf53TbI9xyHhr36gRBnIEsgF6ik_IQxij43jk9BELLSqu.l1FOqCL3ehGsOZtWZ
 HwAQdjOA7zmP2LjFRvXjWfchpa_JSlL3W2w3whrE5BDu1LdNt6N1p9FeYcF7EPYC3CB0yMaWkmz0
 4pYLjsOWTwhowssvbsoGAkM3uHT0tj_Ro6qcIfz9oG.GdG0v4_PHMyChhTPzD.p6Ybc8A16Ceq3C
 Vpe.qvveApX22eEM.9.0.xvl.TTL6xeJf9Yz_2pTBg2yPxz_2vBLcnHodsJXl6yHLmHOj1S_JPSX
 INfG8G3DgCUYENc0daOXVHrVeGY_jzYiVwbq17z9psYwp4dvfQBpZDyQuQseFs4d6SHD0TrR9IQ3
 tQB_oOLx46yao1rqXgnNlLK_n_VZjfUpOXv7hsvx7wYmuDOOdKPs0VGoCybCrcYp.y8pH7GWB8Kn
 fI8TJcVhUkdOH_18KN_Tn2hlXlFdGbUXq9WwSKkL7SMNKfmj8qpgZHR88iOwdifkJ7vM1NHusr8k
 2fkZgWisb9W0_sctcHhq9uE6dHhaP.SUfe5RTVNjkypAZPTopT5kRIvUJxX1FxQEfFzljKmuR7c8
 .oaPayQVpnckS5SIkZe0oxGn5BKLYtLtxVyz4f6PlozNU.WXq.GtBa_nhJ8dsEQCtvEpMoGqnV.x
 cPhmsU_dafjvPwLQS4CbaEM_mHSoaFSNGQGJCUD0chQtuMDYHn0YacxEi8P8vePygafHAdcTd5Uq
 EwUWbgHHWXJoXEvJC.o8ERUUQKVa1aijy2Mn9ZrF0EuVq834EZllAfr_0K1h2bU9oDOVEtYoOwjS
 E7WCP9rwvb8wmxBGFmJf1q6ncxg5QxOqPBNp5hO4Or4n7KeCkRxHrqNLrIVFsPyTMCKHEYHa5Pdu
 rIK4kIS0oUvRPsc9TL0vTf9ECjgTkHahe.SXrG5jv0X7.QhYE0bxmBU5Wb8peLTjOO9a_2knP8lR
 24XTCX4IXtRorPeTyjrIXytEnGB1DF14b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Aug 2020 16:36:06 +0000
Date:   Thu, 6 Aug 2020 15:47:14 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <annahbruun6@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <1731309241.628416.1596728834962@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1731309241.628416.1596728834962.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
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
