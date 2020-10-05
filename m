Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D5328383E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgJEOpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:45:31 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:34690 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgJEOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601909123; bh=OCp2NQ1DG8WDrE2HT9ykXjnTFISlxhUILAf78oJl1As=; h=Date:From:Reply-To:Subject:References:From:Subject; b=HMlEWL/ut8sO4M8f6LaIFZCfqTRunIH2wPH4zzQtN8csFiNki9UVhcjIe1xs158Qjug1wvTQbHBkmi7sRNiNAfZWJ35iMgapqyp4MS6MYRqGl6jY43P5hqpXpbc2xFcAXOET94P7oIzdZTFZzZ7GrjL+2J/1K5nrfkwP5HS8WDxCIeKKHvq19ebsgpvTJSxAgMH6a4AIXKZey1hkQF4CD3Ebz5VZJUcyMu5IRBNXHspp/DAh8hHrqw18DgIX57G3GBlUXRySgwe6RvxBtuvIRnesgybj4bo9OUW0XzTe/a0liEjXE1PG1yWO8r5XhqanWjIsRJEVSh6G+8rE42khkg==
X-YMail-OSG: dDaOVTQVM1l8_u4snJ_dc4KU7NTt8qHO689hz6yfkPrV.BLkpi3mZ1jvNO7bnV_
 1x2vE5q0LshbIkHj17.S.Sfam8bz4yjS9OH19UniJeik3Udh95b8dM7eJF4dSZUmVQiF3Jx.l9f2
 BqB2c54EAq35l5IpALn.28PPysgt7FnBpKYb4trT4uP8_q.qI2hvRWvaPHY0zcvd.qK8sumBxqmy
 _tJ6JIUHsYh3u6GUd8qWlhctJByxs5PMH5mAi2lvI.d3GCp.0PKj1vSpJwh20P5dPTTiwgdxb8iK
 v3amw20fMLQZd1bA_.7rvwflCxF2nDugaQPomA2YWhgKyYW8JKCvUgAIyijQAV.AbtiPnXC78c10
 xR_R5VryMv2pVpDE2MCAZMVcoh2uzAgmoFT_2olZDSE9yZ2CIvt2Ixk5ujf76Lv3afnwYb02T6SZ
 FEDqiUXwfGSMH8zQYapKyaISgYeKO7eQA5I_yiZ6gvR.LaNvxFqAQdRbiTyvpaWk_QahROiVMUPo
 bR9rEyOplrHOXq1jfRn3y2kBqJvUMjFwOSZiJn_LlucVLxBh0F0JJF80AjnzOULm736ZoUeBt0YB
 7h...hWhIHVmjFkeRzn3UnBoNwYTUWNykG52kKjO5UU6c10VQwa6jtkKWrfYntf77MizQpkfSb.e
 Q0KxQM_M2ZaIgD6TiTsCDo6PArRFZQLieYhQ0gv21smp32OZmE_dzIrhGN6DwkRb5BWgocyEZkHp
 g6cWzFo1qWNzW25S7AhoJyGUrDQcWjnEkncB56SQjTWWBtU7FMqvYtI2zYbeb6bYTqW5U09a1MTw
 bAl6l3QfbvBPZxKJUiVvGkujNHV5C8pGn8PPITxkjPr.un3T3hRN9AO4W1uwaxnDp0Mqk_9AdNl7
 _lZlgs8U.ltHSU9cZPpDj1YYTkJddy9U9v6QtuZPo2MU3WNCFvEWkK7e81_pNEMqYCU7j7bix189
 vY3n6U3G5et6mWwmO0tO2KKTWqIRO7uNFuD8cgANuSoysnU6TNsshVFrP6Rd3q0T9a22rpqk0UO_
 yHHJVmrL4NhhuW_58GZ21Qs9mGNZeLc1YgGW0VppqBYMECGI0Q_.dg_uhILyTua27cuikAk8AgFZ
 2UmXtQv3UmYJpKOSF2yvkGUFcmqm.KrMz5LvqPSalUzpbLLcWRRbFVh1OE6GfIpYtroFi8L43Itz
 QN.n65BUPZ4EF.YfM1_aBFhE9OKj0v122hJql85DkRgsCQ5_vXE3.zaaVIiRur1eIQ9S11KUmRtx
 Dtv7F4ACnhnjgll9wmwlrE5hZBWfCbQ6Lw_rvhV8rMz4ZIXEyM8sz3JzTpS_BcmzhIhnTePaYhEk
 .7Z0ggpess2jeRYFMp9yl0NhmiIkgjqI7ZRHuHa7VSJPYtv3FK6THB6ogBOrTEO1S59Ted5eGiZB
 3ypMAaFPPsFP_tPQQVgB7jjZ1ekezRryAvxgXiItafHkS0ymCSQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Mon, 5 Oct 2020 14:45:23 +0000
Date:   Mon, 5 Oct 2020 14:45:18 +0000 (UTC)
From:   Mrs Elodie Antoine <mrselodieantoine@gmail.com>
Reply-To: elodieantoin568744@yahoo.com
Message-ID: <288198347.1895231.1601909118137@mail.yahoo.com>
Subject: Greetings from Mrs Elodie Antoine,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <288198347.1895231.1601909118137.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings from Mrs Elodie Antoine,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine
