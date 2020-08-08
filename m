Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2823F6F5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgHHIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 04:32:59 -0400
Received: from sonic308-56.consmr.mail.ne1.yahoo.com ([66.163.187.31]:38631
        "EHLO sonic308-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgHHIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 04:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596875577; bh=S1W4BoC1UowPkQsmd408117q2XXXzO+LBxHrbtZPS7c=; h=Date:From:Reply-To:Subject:References:From:Subject; b=g84FDb4hlB4jhoBgL/TI4SBCZLWEd1iLdAZkLD+hx8bmxSMREBJNaORedZ0hCjEhrqy1R2bX3zb/jTbz3q1s8xtj5X3mD/qe61ga4ylwbspt7qtOb1r36hM2dDhRYic5+IpXprirxA+aI3NpFcVKr7dfZ2uIY81nM0Fp+wnS+5IW2ptmxrPzho/ysDd6b0BMzRwP08WYCkAuseNEzdAEr0tNJN4wAzvwB4KPpLMEZ6W4IXgRq8kaCqWt0C16Eib6Cgny/BIkr1ZJF1xISmu/og6LeRVAKXxZbnGsCJX45LWvYwz9Z+oTPPBLwB6mdk+1QQgSWhFAfx4U7h4pYF/QvQ==
X-YMail-OSG: XIcNclEVM1knKk2IJR7aHCWdkXo0GvaRCv51_U2yavTGNhf5Ni5YXSwPJMSV8Y0
 zvwPzIdASrwTFq7b2fPK8PDylIWI3xY4n9eJ.pHObG4Lk4IYFnviQfX8d0WQ2gaaL0C8WFOJA7Lg
 Q2W7KnxcVh1fwVVOE0AECBG..7ZPN97L2nmMU7lRSm3_J7YLCKdLipYwyb7emDs.T5LhgCDBdQZj
 aOAK6lvsGamBnd7vDi1SM9inBq0JJR9TmpshyBD9xEMqgXRq.V7wKE5jG1jaSRBdDM3J7Ls1dF_h
 BuWBuTw26YADBmi1EkLEbRs1BvEm8CLZgB3o2bwOAEhs9XVFr9qEVJJNkEGWHH8uW81iWVoSvnrH
 aJhYjiLrhmYtiloT6A1D0keeF_j8ks9fbg0uRYsleuofEjwURz_3zZxohzEW9xdeAcYrynSqIaue
 9S8Hzni.I0AD.ckDs99v52tgF5KWxQTk.9Hd_gQWG3v0czotC0RTX1NqG_rfrsjomVluuyqgZMdb
 pbL2Ob.5SHQJWyanQdh9WQvz4W4EcQx4WpGu.VhCFVHwLPiXTTwtzptDX15cUdprZUYeEc98vzB9
 rQ_KmHWNn9o8.8NX2RsTcP3ySJrRJHe5DIJpQORtnyjvV7SHWBjcbvhf1.apZ87yFpHGQpJ47qUs
 ryjBJgKtP3rADy2ht8Yy2TqchCuzsLlhd_s.KBlZ3cC8n6nCwUssK0dv2AS85Kts40mDMpSIO6zB
 .YjlaxtoNb6SAkrscABP2yfqYGTJRo1_knPOrBvxNrQbTAWRMolcgC1uBoDuTgc2X5ak.4vWSfJf
 TsVMO2x6hNabSlhik7wQFBMznPedPCW4MEeCLTaRjq5yjSy6.k28Wb8gHQ_glk69536yg_6v6XoJ
 e60rFcEQ8.SASxkxGf9gQvb0UPpdRTgYKmdgoSzJoVY7b12fLplh4oNyhyGdCb44Gw8cN5.OJFm_
 IxS8w_2KOcYADNNbanvEE_zZZq2C4pNqpqrbrGW5Rfo3VIzBTS19aEI5gLPjPX57vcYlx.kvLdpc
 FaGUKrtft0x.k5wEbgJxKKRDquLaqc8QBWytr5M_T2jufPKluNJopNbbKY22c9P9.UfVwt06uqkN
 ljTKECoE.79EFsT0j5tHW5sNav_CKxMl7M51GZRmUtiY0tnx3vWcA45iyK.rgViYnERo7E1.3HDn
 WjwHK_BOQxulmsDnoWO7nmt8TT.J7cgRb3YXbA0QM7ImxYQHIEtrhEK2o5DpT0Y7FsZrN_QQLKoY
 sKPQigB85Gk8wVqG2mTaoU5mVfJJY6p4VNQYBeP04y2GPdxb6g0FSmpfE_evO1sDJpDbg4qMsJYz
 mNb5zVfP7hb2LByrg1dEFngasH7TKevDkDFCG5oCmE0fjMll.n0XTBxgnzq5m
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sat, 8 Aug 2020 08:32:57 +0000
Date:   Sat, 8 Aug 2020 08:32:56 +0000 (UTC)
From:   Ibrahim <chijosco1990@gmail.com>
Reply-To: ibrahimidewu4@gmail.com
Message-ID: <1916358791.1779272.1596875576214@mail.yahoo.com>
Subject: I NEED YOUR URGENT RESPONSE PLEASE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1916358791.1779272.1596875576214.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear Friend,

My name is Mr.ibrahim idewu. I have decided to seek a confidential co-operation  with you in the execution of the deal described here-under for our both  mutual benefit and I hope you will keep it a top secret because of the nature  of the transaction, During the course of our bank year auditing, I discovered  an unclaimed/abandoned fund, sum total of {US$19.3 Million United State  Dollars} in the bank account that belongs to a Saudi Arabia businessman Who unfortunately lost his life and entire family in a Motor Accident.

Now our bank has been waiting for any of the relatives to come-up for the claim but nobody has done that. I personally has been unsuccessful in locating any of the relatives, now, I sincerely seek your consent to present you as the next of kin / Will Beneficiary to the deceased so that the proceeds of this account valued at {US$19.3 Million United State Dollars} can be paid to you, which we will share in these percentages ratio, 60% to me and 40% to you. All I request is your utmost sincere co-operation; trust and maximum confidentiality to achieve this project successfully. I have carefully mapped out the moralities for execution of this transaction under a legitimate arrangement to protect you from any breach of the law both in your country and here in Burkina Faso when the fund is being transferred to your bank account.

I will have to provide all the relevant document that will be requested to indicate that you are the rightful beneficiary of this legacy and our bank will release the fund to you without any further delay, upon your consideration and acceptance of this offer, please send me the following information as stated below so we can proceed and get this fund transferred to your designated bank account immediately.

-Your Full Name:
-Your Contact Address:
-Your direct Mobile telephone Number:
-Your Date of Birth:
-Your occupation:

I await your swift response and re-assurance.

Best regards,
Mr.ibrahim idewu.

