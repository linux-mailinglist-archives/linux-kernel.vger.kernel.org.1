Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE1226CF12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIPWq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:46:57 -0400
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:40561
        "EHLO sonic309-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgIPWq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 18:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600296414; bh=K9OzRX4qXPelZ1iZX+pF472C4G22/QpiwRqFyotzZg8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=UO+3Wi4xXMt+Acut+pRD1mIzXbjfPca1PzMY/cl0qGCjsmwbrK9nga8ZBaBQKYDQ1rj6XTOgTjZm9Uddhm6u+ImjiJ/ph8vKdRl0cvELuJ2aH0D/JabrMyhzWKrpKlRnBKbs3dlPzaD8E/GsamjsHeGCaw2qQk3Vs6hiJBaQUeR+5Z/rcNPRl1pSAkS6Cn57EIaUPa2iQN3kj4+aKaPz38jpu0kMRUeIHtC7uGFhfNzsSuVcNrHomYwAPbSCJbfdXiVq0ujz8fI1MsGG4RHoo9Pj4DF7XGy9tMf0xMDrnfi6MDSMslOZVXwYYtavhcBT8UwWE8UXiO0OCrRgoJZ1XQ==
X-YMail-OSG: LNUorHEVM1lvyMT_qGkGBdfqRdOdQ1oV55mtKKZ48kVZ.4XEuYQxDsMYwFWyUzO
 TTo9dSBUMlfTFj3_G6xUtsv3V6WZUbYQYgJmn2Ijhq.F5FHy1lSL0A0a9_Ph8ka.ABP161d0R9j.
 k722m7T5_DjpNedv2Ucl.sklv1jpbJjJbWhBKS.IbcUcs5HAQQnq79KqNkRZNYxnP9nqWoWAvVlF
 8fNLKSuNpZVmsPpnO1Wrpd7hxivyVBWXF27phzqLgrn_Lh7tclpg5KXCcL8FaZUXj5wK7YNcML3G
 u34y4EItpkZQTRvbYKp8_lXgpkNFu83OG75w6yaSJPb6s3jna4DMjiJc14ZPKnZg1bskN_YSZEFd
 s7RLNRP3DgbQsMo_OjQS6f7.ey0RbgW_HJp33UmqZ_e7yKGXMaerzhP81W1vaNKsFpcrxxUESY.D
 uCayeENLsSQ_6.MwM6WLnX5eI3xXx1tSfoQY9_KROE2HY5jBno5v8l9lFLynyXrQpIjS4FvG8sNx
 XzLeUCxeqTIa6FScUOboBjVtLUU67Q2j7u4Lhz0IANB6aKletezyjanz90JePbeQrEi3iOyonedh
 RnWrHZeISursTaE6UsbibDH1L5bUv.JirhaKS30hw7.LNhwLYPrsRz7kT2xL9sUWeu9p1mf6L6z6
 2YgP7_IXuSQwSKeaBYfe8DI6kel_1F6qlvm7pKQ_ZhdcTA4UIbau4fNE4uNGTIFVMukSCulAQqks
 YdDMVkPHxF6u4PZOvHXf2QcSoeLzGHGKLGf8liRmL4ofveVzEVECrPXaUhBjfJIf60AeC6.EbMRQ
 T8yTHjm4Z2KHM.yjPwPZE6HAEMfwqeBidT2cFC_N3PVUN_pDvLI.eM256vJ3TTxCHnhL3bw0TX98
 EIGaMTLB7JmhGM0QA3UeGicBdnOorHPDMgQGM2fwfmeomhTpRCwKgguWdl7FUE7JXJSG2hu53Qdr
 MqJzZ3dmQYbUC3_FuTEj5aD2gK3mwXpvjTbz5NM690lMaC0mj0ZXD3Eudyv4OE30CKuB9PBbM_U0
 N9DwAki0Zb5ou505V508x7_LBLHfkXXKKfTM0QOkfjKanbNwpL23LZok1xbPIu2vB.n.TXtkLdAP
 lbmCbZsGIN2bAS8ppWrzkZsnsP_Ho9mRVYjWRKA.9FTJ2I57Blqd3cHEEoky3IB4BuiGILD0Q176
 WH.k7hyxYBNUs3kERKgtfg20w1KltkkM3i3FBkKugNxOpAUYByW5cx3g7ekZzqquwc9g_cOZXZK9
 HfIhK4J2tuYKWgwZQ3GrMD1mv9ct6Xcxnz_J9rA8WcwZYG0AeAh2mH.VQCuu_5rEWGU135lPXEBq
 EdFOfXgbcU6H2YFxX06DNpUl6jg.QFMFnQwZ6a0wYAfNgiTGT8atPyNEh.KNY6VAEShriJirMvL9
 FctUgoSxfK4ooc.rdzjwWBgPHIAAgeE.Hq9YxnAkzgGmeBXZ.WfLjwMidq44m
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 16 Sep 2020 22:46:54 +0000
Date:   Wed, 16 Sep 2020 22:46:53 +0000 (UTC)
From:   WordRemit Transfer <wordremit@usa.com>
Reply-To: worldremitt@fastservice.com
Message-ID: <789165590.2984208.1600296413448@mail.yahoo.com>
Subject: URGENT PAYMENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <789165590.2984208.1600296413448.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Attn: Beneficiary,

This to your notice that International Monetary Fund (IMF) have mobilized all compensate fund Scam and fraud victims awarded in past due to complains of Beneficiaries concern banks defraud beneficiaries through Western Union/MoneyGram/ATM Visa Card and etc,

You are advice to cancel all the transactions you're dealing with banks in name of receiving your fund through Bank wire Transfer/Western Union/MoneyGram/ATM Visa Card and etc, because the World Bank Group in conjunction with International Monetary Fund (IMF) have commissions our service WorldRemit Money Transfer a bill to compensate every Scam victims each with (USD$1.200.000.00). You will be receiving $5,000 dollars in the morning and afternoon till your total compensation fund complete USD$1.200.000.00 Million.

Before you start receiving your Daily payment from us, you're required to pay your mobilized fee $245 dollars and fill out the form below.

Your Receivers Name:_____________________________
Your Home Address:___________________________________
Your Zip Code:___________________________
Your City:____________________________
Your Country:____________________________
Your Direct Telephone Number:__________________________


this only our requirement; Immediately we receive your details and your mobilized fee $245 dollars. You will start receiving your daily payment from us within 24 hours the requirement complet without further delay.

We are waiting to be at your service

Mr. Mousa Dawood
WorldRemit Money Transfer
Branch Office Ouagadougou
Burkina Faso.
