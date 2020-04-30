Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAA1BF342
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgD3IpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 04:45:12 -0400
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:35035 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgD3IpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588236310; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SjyTjmy784z9ZAtvGMy615ilwpSGZMc0/fGYPcuMidP+S4Xqb2OaqhmJ/Rwclqcd+hu5CCLZdDjhQacDWZtMChJacrtK2JBTwzGwQP4xNO6nv1kw8nfBGmrSTY5Uc3djCBPoRthWwF6510r096oL1k/8AUYNH6IOoYc3Vb4Pe6OLx++zvKjjw6hjYjVia2I0kLq9fZF02EZ6vFEW86rj5pcDqQhNpp5ebMtYfrq4FreJ33NAk7b6U9YdjQnjIMsoom4DR1jozT0PYaj2kw2kDDwKwSfNMYGFqvQ8bKUDKFACsEvme0Xujb+o03IfvuMmFQ5DpE5v4lSd5LIc9c7E7w==
X-YMail-OSG: NzIyNIsVM1mNHENKDzaSvAuux7iIGyCGbirabeMJfscjWGzt_pY8HDA53zSUV0W
 E_JA87a0dxWH8xIrpS5efd8OBot4MzrgX07Bre5FzAQoOysO8qmhAW5PN7PRmodhUnRhsneXpP17
 Rm4KSiwFvcmg.ItDkAl.RxHQ.Ui_5liEwISHwGa_zbawWA4.ZygbSJYg9EiZsI9tWdrCTGZFOboZ
 tn53uA9uzaQ0ItU8SjnkGMm.o9f6rcnpk5bnQ1WUU67cMXAjbjK1AFNFxiDi6xuor3bBRT9WwipO
 hkbgwM0ZWrUXYv1Du4JgiivY66Ek7id96FGo7nFZusgseF9j.Z6JPppm1e80rXSDkrItugndLz.7
 JV6m9nnld1pCRd1EomsmtKcGBQom8mBcBoNXxrogMXti7ajyvoaYdzU04dQQ_nB2IrtTGU4VayL5
 EMUE4RQDk7tmbL.DteNiw3SUH4pTVeqd99TO2s..oYASRwEPJfd9H5ZUrICaigs9dbav8rKd3KbB
 hAjHhQfkdFh6sTShkFT7xKuZrC2vvF7CK9IdsWwmBBvO4MC4FQR2DKBzk959xl7JzzKtZC_NXSpv
 6cXKemeNBOgjdavYFst3BOfp5UuDxihJgb6KM6QIBDSHNshish6M3w2yw_cpuHD7.d6EUTaonS3W
 nG4LP1oV6M3Pin5FLt3fUa9jhIS5IFFILRY78KxZ_MWhO.w4agDo9za2LciLohEwbtjEMrbBYXS.
 LtWX3bzmikXmRr9DIbYBuACkJRw9U4EN19xU2nsg3hv5XkEX001C.g9kIzw5Ns.oIb462GB7TmZB
 i8hRsR9ovEnMXJIPLW7.ZAOtnk_d8WiPrnZ3UwASUetfTHCcfNkjGKECUTFkzxfZowKJ8zi67sVD
 KFhw.gEWbqEoi1SYccUOEjNWLTDIT7AZnZ43NEKV9ocvwhDFV7K1HtBj.SpXQoWmXjEp6w3dubX0
 NcNM8BWepTjKNrdL7rpY0CTs_Zk1QJbBZgiIIN_K2KaXgPNmoZGBJmFBHWO5QDh833oaR3i6lEEz
 9leYzBDl1KAin8WbHn13iyu8goystFWJbjpTACYLb49WV078JPXrJNUzDUU3B3y8QpHtKRTxwBuD
 ddK7GRPdGpPtDCIHk04QQ2g.nfHxj0z_aoTyESjCKwUk8XWVKxn85LXvBJeGJ1FsplOwmZ3pYMbv
 JdcJfUgcfsVYhuJ3rMcWzwWyjJHU6AzKoqeoIV4Y6kEcp0L4z4qTQoW1Z1EFoxriq9EhFKnYB2Qj
 BIacn6dKHzWr1SLJN29WOoXeXhy49J_9CbHbZNwdvzEAQLyloNpOL9UdBoDCr_DKvjNu2DssqRVF
 JaQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Thu, 30 Apr 2020 08:45:10 +0000
Date:   Thu, 30 Apr 2020 08:45:07 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: bmrsminaa232@gmail.com
Message-ID: <1723542059.1805105.1588236307546@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1723542059.1805105.1588236307546.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36
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
