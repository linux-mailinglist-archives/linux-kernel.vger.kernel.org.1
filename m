Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C778026FE27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgIRNVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:21:06 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:34957 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgIRNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600435264; bh=k1yl2EIxSlw7hhqSSNsyo3JWxJqHL9iqJXZc99K49Wc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gwqnm5qnXiWGXElz74SKP1/8xhiGHXVd56YcggwpvDJybuSEFQnVHm6e26cqfP/6/ny+WCv10/rnPO4mEGEVBPWLwsSXYIjwW1T6/qxmajk0dGHYdT4486vbv9EQ3w5rLwQQ4gARa3zCZ9dVxgiQHoDl3h6obr8FPV1/duVU6Tjgla2n7Mq5gqR+N8J6raHbRFE3RLjtu0X3z9gjrYu3iAh/+3GAp3qrGUVz0DPa+JAk7bYn5UfDiFnZYrhUmHZXeePDR2iOLc8FoAG/tNPMYXJvZcMjgusnMPZNb1GQn6YDB24hvuGGTcaaDRwad8BqQSbu/xtZ509AX2rexkWiUg==
X-YMail-OSG: iobhTKIVM1nMMoSKB9wNgBgXcgIXaRRla5uVimfYOT_O4gNOzF8TDd6k6lUfjYp
 SRGMxozHSdSx1.Di5Zj02pGfy7wjVoItDEdNDf.dzdLy932aOXFsenG5DfBN81bto2gxHYnlenB3
 N_5QRQ8FZtuUUzYxtuu0SNtDK88ewsnnJozvdBBu3.7WIkULzlSavVU1yDU_VeaVPaNWGhBLc4OC
 l8ck4pzQTUg7rdQIq452YeaTSU3LDYlGn632qQaNQp6VELnoJ38UsR16eJfFdGTheOfBYypdZCV4
 noIiVpImLShS8azO8ue1IXam0y_AUbgm0tI4WcuwD5VUhXAwTC_zIcCXnqXVF6GB4F._JchvQiM7
 VFJTLu8QJBR0.hpXxudUsGWQObArMFnfkzrUiIchtGdeGUhAZOTVCZ8S_2JdlWqQhpWGEM5p9AqB
 CKKn6PldbjHdUX9scgM9m.p55of4.vwYT8nJMVieY6b0bKQ1TYAPL9jc.NTB9bpuP8gTUxbZeguB
 9NQL_KRrl7USXyydd_iL1OuOlUMz0gqGdGjHdG7F_KPS3KdDjwIGY_aIUt3fasSKDhClpkV72SkX
 iFdhjWgQvi8ToXnnOnbAByNkGEaw.hgWa0k4LatOM_BmeVyQ6qIvyKvVL4_jILRcezIDX2_babg2
 h83yImmQqSTuUx8EOgLoJ5QRt64qvXQ.3O5QkteUxkZXMM0pvkeNjsKGJJN.bTrWnNrqbFuMy1i3
 1wwULeShqmzefJm8y2hpSZEQDB9VXwUhTIQEJBXCM8wASe9CpwsmRj0wHZxGHHKbIylrWG9KQVPN
 RnKXLLQG10Wt2.VWWBabwBLGCWjypgv2yOuJaE48fsN6qN817tUN2hldxJyLabi81LiJsUvjU7yE
 rnYkVbuW6ITToX7.4xqGHwbafkKiTH5UQbkYrNeos7KLgEjBUV8l8vlfR1rbmT2dT2bLD2Iq6m9c
 96dD.lazTT4XZRm1PUwi_7z.vhwvRx7ZlBXb4Z98Gqv_ZPb5Z4XY2rYo5q6MVzxTecXz31MFkaFH
 NPx_E9DJM9pWooRUQ9uRj_d8MVoEbEv.zuRDRqXUz9jgY42WRg8evR0z5k55HZLnS.muXp90BiEN
 Pxj6HvHBcQVEMj.2AMe9dtaFAOVfYWyXPUtAc1h6X4OjMvtwAtzqrdIIAqhsmCfTGuu_3R9B8S5p
 EZO6W3KuhffPDsCBor4FF9SCZIiJUiY05Md.JXl8Bz0rvHbHY4Hbd275.ienL0cbh9KkYb_dw3F2
 xIUOe9aGwkLjR9HFxsEazpJYZIYoI0aBm1FFFLukghsXeECiyGrepPpqBg51kf2HWr8c_AuysZu8
 yiNT4AyPbn36ixpwk_Zfb72iDFVrTtNuZmv0xBa2Q_cbaTIMbOn50JJAhOlALQPmL.d8H2DYzO0_
 YGvhkE8pRtxaVwO_rFgCgF7fLBZbS01ZiXXNUup_TOL7amLIWvy5OOV2wPCYW45dB0HrrlB86QFl
 YFy_BixTI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Fri, 18 Sep 2020 13:21:04 +0000
Date:   Fri, 18 Sep 2020 13:21:02 +0000 (UTC)
From:   "Dr. Aisha Gaddafi" <aishagaddaf0dr@gmail.com>
Reply-To: aishagaddafi2dr@gmail.com
Message-ID: <1257779947.3550321.1600435262546@mail.yahoo.com>
Subject: I WANT TO INVEST IN YOUR COUNTRY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1257779947.3550321.1600435262546.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I WANT TO INVEST IN YOUR COUNTRY

Dear Friend (Assalamu Alaikum),

Please after reading this mail try and make sure you reply and contact me with this my private email address: {aaisihagaddafi@gmail.com}

I came across your e-mail contact prior a private search while in need of your assistance. My name is Aisha Al-Qaddafi a single Mother and a Widow with three Children. I am the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status, however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent to enable me provide you more information about the investment funds.

Please after reading this mail try and make sure you reply and contact me with this my private email address: {aaisihagaddafi@gmail.com}

so that I will see your mail and reply you without delaying, please note once again that it is necessary that you reply me through this my private email address: { aaisihagaddafi@gmail.com } if you really want me to see your respond and interest concerning this transaction


Best Regards
Mrs Aisha Al-Qaddafi
