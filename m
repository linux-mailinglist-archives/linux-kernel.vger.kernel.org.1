Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202B11EC42A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFBVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 17:08:43 -0400
Received: from sonic304-10.consmr.mail.bf2.yahoo.com ([74.6.128.33]:44501 "EHLO
        sonic304-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgFBVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591132121; bh=vitJJjwvu0PcAMgLab5fQiPD+rea+P4uqnQlFUOXIkw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MM94TZEqoScRYpA6G6UqoGMXW795Yw0dWb13saIE9EHcur3eawBNDgPomu77TGJKh8Mb2r+ZAXIKM22AJf/o2zThn82H+Cki81qALqBKZ2MrU6aqd5OwVAk72hlBE601vqluIyvbbcHWwOLpNJTAuI7Pl9t5l454IYJDMrk0h+gG4KNMFkEuoXjjwzYwH+TZcrp5Pr2lJyXS7A2D6COYOiIWOE6jxtQBT7GSsnxamOs5f3nJkfjzPuPK28Bf202Q8o/GkP7si50fRMo1ILqOG0yyG6kPxOTfh+Lirg0H0HqxDC5UtpS412unGftguF7C7wi27xnto0EnHwu05d+EYw==
X-YMail-OSG: puWOXxYVM1lF.hUfCCFZvJs6zxYpruxzEhdE7TgVB.uCxukdR0SPYkEz43dg0YS
 6xczf3xx.wO3qrSmRH2_UAAO5ceA1AwI5m7byWg6_5LYOOSOdkyzg5YTvW.awQxw0F_2l5NTvZ2Q
 ubGfcqZmM1Vx3LHgGIOoez5svKVI4o0KEHTmn5TCphdhCnn5Uwc0m2qqZdgZXuyyuHDsrdcgm5XN
 rRoPjKAOBVjDoJql8OEeKK3hCSCX.OEjzjuFfMWyD9S6RKepiGizCUgRa7Qxm189G9GKcyrMmijW
 rdwy0nET1D9HJxCmWABLeo4UcNQU2XP3VN88v9GClhYqKLgfzso59ypvdgKd4Aj0mYncR7ASMYsO
 WaUL00cqHgVom8Kmj6bN8GUaNp0XeaLu_8sEeyfMbE5lo_pKc0oqeWt532jjkSRou2OrBDLFA7hL
 DVZ.GE0ZnHct2KOnrxDFjgwpVu2ISttlEK2rM5ToxTacGn0_PECg0BfZmper.5tUpktsYNpEFjDO
 LyXXwbIdbXCAeMI2rIJOxMaj1iFcoqcS6ysK36_PW4qROTbMLmqcEDOJ7qJ90fqyryjKEC2Nu0ha
 fzxJmxUnyuUtKjjQGnia.SO5N0Uobi_DzxWgJhz1d3ruVNppV7mM8x6gJKQuBYyFuPNB6MfNncYc
 hMaKAWUF7NYcQUrhRHduUEcwMbiqlPVJT9mW519uw9hsJ1q1pb3JjryX2TNaEv9mg1Eu_Wia.RHY
 uCLj.TJbBdtBZtk.Mt01.B7aMwbZMIKVP39xj39gy7Dd2mST1yDorKGY.hQ9RlK4aPwiam7e0bXH
 4UtgPeBxxTFFMoKBtlzxt1NqfC45hiGUl9NTzNaVGjb2WXjj_f8R_n0tEcbZCzIc8reA4TbC49pP
 5PveyeTJUYiXNdwL4uC3etdcx8U5DmWoxV4qHgAK6ERhLyUvwIy87XWczdep41pRQUOdfHy4AVJV
 ueH1mV2EtJCx0en1oX9zz3DNg8iIvmOHaYsfROxAn7ynPJgKReQIT58DQeRXE0zTFYSiU_pMPXxv
 4yJC8mw2uJbVjNHa87eIdEHVwOAJasCvSX3M0B_dK8l1s1gXPgIdsmwMp0KSxsMAvmiKCCfm9TZ5
 lY47R4yUJOeLQ37LcPWRKpc.eIa_vXT55h8.9XaSBHrhHAGKhDy5P2b7YfRR4b.B_nBMNvWFhy15
 4K4r_1Vg6iufSQrhd_ZgUCwDLCubNUV3Tv_s6H7Josx6xXqHbYnWOuts7VVNQxv.78UzIGwSbo2K
 VG8FNhiE9Z7qst6Pq0GWwInsa0fvUsZnLxN._nTpBCLcSAGCFP9jzm96HiDTsC2H0r7ZpnCdAMcD
 2L68TPlPL6fh1nQ6wRJHZCqwYpZXX7BTiP_GJODNe6Bz300gzyYNCR_XlzMbXkMsoBUkAEI2buT7
 Jnm8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 2 Jun 2020 21:08:41 +0000
Date:   Tue, 2 Jun 2020 21:08:40 +0000 (UTC)
From:   Datuk Mohaiyani Binti Shamsudi <abdullahalthani62@gmail.com>
Reply-To: abdullahalthani62@gmail.com
Message-ID: <1300027835.1180991.1591132120645@mail.yahoo.com>
Subject: WITH DUE RESPECT YOUR ATTENTION IS VERY VERY NEEDED URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1300027835.1180991.1591132120645.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir/ Madam,

=20

Please forgive me if my proposal comes to you as an embarrassment as I had =
no previous correspondence with you before now.

=20

I=E2=80=99m  Mrs. Nora Abd Manaf, I'm the Chief Human Capital Officer & adu=
lating committee members Malayan Banking BHD (MAYBANK).   During our last b=
anking Audits we discovered an abandoned account belongs to one of our Fore=
ign Deceased Customer, Late Mr. Wang Jian, The Co-founder and Co-chairman o=
f HNA Group, a Chinese conglomerate with significant real estate ownerships=
 across the U.S., died in an accident while on a business trip in France on=
 Tuesday.

=20

Please go through this link: https://observer.com/2018/07/wang-jian-hna-fou=
nder-dies-tragic-fall/

=20

 I am writing to request your assistance in transferring the sum of $15.000=
.000.00 (Fifteen Million United States Dollars) into your account as the La=
te Mr. Wang Jian Foreign Business Partner, which I am planning to use the f=
und to invest for public benefit as follows;

=20

 (1. Establish An Orphanage Home To Help The Orphanages Children.

    2. Build A Hospital To Help The Poor.

    3. Build A Nursing Home For Elderly And Widows People Need Care & Meal =
Support.



Meanwhile, before I contacted you I have done personal investigation in loc=
ating any of Late Mr. Wang Jian relatives who knows about the account, but =
I came out unsuccessful. I will also like to bring to your notice that I ha=
ve made every necessary arrangement with my colleagues in transferring the =
funds into your account without any problem.

=20

However, I took this decision to use this fund in supporting the Orphanages=
 Children, Widows, Less Privileged and Elderly People Need Care & Meal Supp=
ort, because i don't want this fund to be transfer into our Government Trea=
sury Account as unclaimed fund as the law of my country abiding.

=20

More details information will be forwarded to you to breakdown explaining h=
ow the fund will be transferring to you little by little as i have arranged=
 with the Foreign Remittance Director.

=20

Waiting for your urgent reply,

Best Regards

Nora Abd Manaf .
