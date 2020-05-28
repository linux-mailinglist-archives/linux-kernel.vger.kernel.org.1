Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135781E6D76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436510AbgE1VRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 17:17:37 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com ([77.238.176.163]:39429
        "EHLO sonic311-31.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407473AbgE1VR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590700647; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=aXyPaelrmBbLyGWUhXk7EnwDWjAeDLnpE1Tb2xyyuo8FHl20Vv5MLBQj4w5KDSkvf9B/ZFP6L0E9YYJCM27B0HM9plIaC6MDdLkEQzh+DbuLR0BWkEXT3hgGLs4iW3moRqpMKfQSF4vuIobqkDQ6MY9eXXoohpzEVLvNX7i5/mPkiEp2EuYypRRl/gBhNSJZb1zxN3jZ3KSssRZJ7ij/1VhQZk7BAGmD26araljEljalmvI2b+yEDhSgPKuAU4ZvC1PsX9GaihyLkoLAR3mPXWwHNU2z276CBp85ZVnXUoDivsBk1xgy5/hMuR/iE7vwqc8Yt+EcXuc20oYQ80T3UA==
X-YMail-OSG: 7PD6zToVM1lSXaxxsncp8ZkhSEh015L_5vRwY0SYlpuqgBmtwt8M9.Vo3af3Aj6
 BjU2tsAtQ5_CMlrhE8hyqWbORN7WVTa8csAmYcLhv_8YNIaKx.R_VJZqXhBBU5T0sboEri1V6qio
 T10wPUUkRAWziSvUwPIzmJ0yrYB.Iq0kBml7xVnzdzSnOT64gyO7x7Jb.sIWMZ1e6Kj1D4mBV4lM
 _Xj8mspv4KYMPCL_tKCvbRXTLHX8FJ68xbuvmBC3dpLZuPslSjUiNdwjP93XbCLxrJlf3mGju592
 8IQ_6mSKCT4X8DsTVZD9wKUdVDzLQ3SgNoWW9DztSV9HsCX9YSNladUsf_2gzFanEX9m1_HOyuC_
 zhFL028zQj1UnHfKpNZUYEh8s7jqGgyt9lvwQScDxNyRArdvtBsAfXz.pKX9lZzftAkoc5vPKzLA
 GuE99juk.F9IsVsAQLQR_ioBTKBsKUwlMOFQbrsql1g7dz_kppeMJSlAeN5j3gipQVWKxnffV5o9
 EVFCu5SpWZKfKPVKqD90ou8PjrhykOzGGuagw7SE4CjTQP4ZqjVZb5CqwQ1yrfx5Ap1NFQ0Pm91m
 vquWD.M0X8hNIGZK1goFD6VA5jgi.V3OS4TAQ77cX3ff6EPfV7EifB9vyhmZhzWof4myvOFSCje_
 SJqlcfk17Nc4BWwEhsr2FjHJxr7.CflJukMTrdp4UYOLc2pniWiSfTIW_bBrfq.dfJfMnRA7gFYg
 Ctw45qLtcbsIY96fVmZB7oyAq1PfVSTC1M13e3erK5.mQudaEI9G8ZMM2gR02Kp.SVdlN6.eLF7D
 JOT.jrgUJyaqOYhUq9MA.oIT4x8LuFk4q28cMsW8iGg9zpd53tTQcwiCovmZxV0giyy7KbRvKXlU
 wk4kexJGrIDjZco71i4g7I87IGsOpcd31IkOB5AuAWBBntfzlPz61.WiAR4.tLi9mF.YRidn5PoK
 1t6VDhxkZCTHeoQL5ExO9Ga5j3S5mqo6hSM4Oo6OtKqIlU2NWj5gGbDzWqp6vRl.E0E3FtqfK6iv
 0jzEgLg9yaHCekXn0qu51NP5y3m0zB8yybF_Ar1aDEbaRZrN0GRmRBk33Dv07t949T4RR7AsZ8Kn
 tZl6q0m..HhO2ANrY7ku8mqOsHP6anzBVvj69WbqqZqpX6hQ21GQ6_4LUBoZdoh5KCnC0R9x4NTH
 UfWlfsTodhjkvIpOnxbvDmO7qSSENIqQ_3Rdj6kT4xqp_1mVXkVzsU.5kA2HlmWuB3q_zbcZxN8e
 m511fSFFFNmOMflGueP4nh3y6DvmTn6xen2guLOCOCij2SgUEAklw5lV.OqB1zGVIzFF8uAJ0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Thu, 28 May 2020 21:17:27 +0000
Date:   Thu, 28 May 2020 21:17:27 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: bmrsminaa232@gmail.com
Message-ID: <1267777637.2241117.1590700647104@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1267777637.2241117.1590700647104.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15959 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
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
