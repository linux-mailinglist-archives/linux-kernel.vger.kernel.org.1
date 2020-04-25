Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627711B8830
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDYRia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 13:38:30 -0400
Received: from sonic317-32.consmr.mail.ne1.yahoo.com ([66.163.184.43]:45172
        "EHLO sonic317-32.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgDYRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587836308; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=AcIKjM51uem3FifnZ2IrZD7QjYpGg33yzECmLj4nrACHbp0/NcCgYki0baEnEcDxEEHHwDdddEopbcmBE2PpoBKrjOZNOFcOsF8ZOrmPHc16rHhbGwkwZUu24+QLXGDjo5c6zl3YTIdGZLhSSPixQm1rGAz2bWF77FqD+i+efj9y6TxgvOi2uzvSLzZm/RPYzHNP0HmLFxp11fuJffAMBE3IfkLNGKpS4JBBja49ItM9AnJNqkJ2pBvwnPzWZ3aaBiHtRrRGWUOeXgrsPhXoZy1K1aMSulkNdf690y2hpb1plHXAYQ9Knove0NC9Z2bLiHIs1HVY0wUFsF67uwi2Mw==
X-YMail-OSG: JrdqiEYVM1ltjWkn326FlkLpxKmP8RjvzgrgAaGeFKEUGSwQpgeXp5JMyAMKjgC
 VUwWkaI9a_13R.dsdv6.ksQe8hiVLRsmB5Q3Zj2esNtkF_qA4Kw2o1Qab330Q4paLEhMjD0k0hRL
 J_ZDAmX2zlsVNEUGtM6QXEQfs93LHB3cJi06UvWBe1h1v42hEM0J3NBn4WWU8fn3lKy_2Ipf7QwM
 w0dvOXdnh17Mz6IeNJLk4y03U0mPxvuh.8wqqjANeF6WwuVR4eRKP4ZYzV8P9h6yO7UJlvixcs98
 FdHLiNEZhPihGiIUgA_33jF6FACGXfZm_eMrj6l_.YV8Ayobmi0EKcS0mbUpfLGxXmROTU2yNapq
 WmMaUed_IK_QRzFvnvso36DUfGpwJDf.opFU7knVxh34JO7.bJdtvq5j9TaHI6B8Oqg4Fvwo2dbI
 4akg22GwzWcToJkI0oGHP4nCf07_aQfhZ9.VTbjJff.mAU8HgsTcP4bZZnnAe7lGITzosCp_SWeW
 7DEEo65Imy9BukSgBUDpsCF_T.cquoyfZxXuGyGu7_IUEObMsXJmcxMrzz8wo9KRyJsWoCmgzHps
 CgvSIX6CNmeaB3S_dRfbiBKkBDBSsR61gkKmZ65Jtlirx4kWEFPq0MRMWnBZ3ai7VI7uKI3BR0zH
 jzg6cWHzL9eQ1.7CpEvuS.02ayXWyFIufkv__3r37Cioe3E3wpBHNPJsw9AqZ9pFgPaiJhfl3KwB
 sn.Ucuv9A_oVu7ePOxrCwZJ9iQXs_LVlkmQhsquCuPeP8R0oLLAgyiHzsv2HnxZ1M8pZ0oswQOCO
 BKFMpn55oB7VnSQgNF2f1ykwcPlhOzJpbRUg95.wK1g4UdbrMMDzRtvDhvFDetjMCSNPwflhitet
 2z4IWkC4FfCi62eiLmrC4KIcduzYy7D6j4IqRUPLkNPOSWW.KfPLXk7lKh49d1mlBk3Qnja2rrnG
 HBOtetk2P6E55DXAm4AtnjwCPhEW_VisUD7npYeKk3xDjvWOJT_9mfzUwuwSWkK6fj6Q6cEEc1MC
 RE14CqPPdWKd6g4SDL8R6IKqEAtz9DKpEIQoDLSN0qGYloSKYwHh2GIVyDGbmZ29lGurd.VlZyyN
 kSRpudHKL_fQImlgpOLraT5cctBZFaFQt.ckV4hvMtTowyr5EEpq70amtXe3mLdBR_KoYDqrFY4a
 35CK_M3eePHY6_pL_HjH7OkyidOQsC2rMv2I7m1A2DEW4XWMSk.YZTdjxHjmhYSYvsUgd5sThdU5
 KvRjxyw2Qrmo6N9wJRUbfJp.GoU9HeqjIk5OlI9q3hs9mVbcdc5i8zzz3zqpCFPC4g5QBuFjwiu2
 p
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 25 Apr 2020 17:38:28 +0000
Date:   Sat, 25 Apr 2020 17:38:23 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrs.minaabrunel30@gmail.com
Message-ID: <1952123476.205764.1587836303898@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1952123476.205764.1587836303898.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
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
