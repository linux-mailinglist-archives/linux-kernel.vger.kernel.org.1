Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCC278554
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgIYKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:45:19 -0400
Received: from sonic312-23.consmr.mail.ne1.yahoo.com ([66.163.191.204]:34515
        "EHLO sonic312-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgIYKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601030718; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OI3DJZbh+SbdmUN+088TS5cpe9QTOhDUGE+E++bD3GEgPDLVnlrbn0obzuOoQeNoJvoCW9jNEUud5cKncwM4k4v0DQBhCfnbyWbsTdyKcPvdTP5K1BbnSfGTziiWVIu9NxcrNc6OarqbBC4RxLD+8nJ8L78eSZ+nKtGJqN2sT2YIbMorWuqduAU+THYpuveqWM0ZBQMqqYsqnaAIumFOBGB06/if0ZUaCrUK5XRmoY81brWknWXlPf1nLwfbRxXGcy+q1ORN7JYJgI/cfFNJer2ry7OcVm1CKTj6zIcv/Cc1KVAAJhiycRTgp3znDFoal80WwABSjemS+3tuQ9JuwQ==
X-YMail-OSG: xNIKs4UVM1mW.gylMKMgGq4s4j12CP5a41xpnZibU6LwcFRNJp1Dc4Oy2GGCN55
 dNbpxjLwU_oVnm8SQaEJxiFy1x1Ap3LXIOuxEXQ54OuRXxUPaiGmFhxA22SI2OtlhtdavPtpTueS
 pgx4woA39VaO9Co7znCm6nLN3FLre2igsRn8ABJJ.DuIxkxJ2tDbSaxrLXLbygFrUKu8zkVQ992D
 3Gb1pYZzQKZh44bhttQaliYxjh6jsz46mek0hkVuPL44gyk_b8wvNyfuFOr4sFDSCnhmacUOaYzZ
 HMqbMgB.WeEqmltxDjZoatOdmEITFH2DhpaOxQsKWgPgJFTqmBGXbtcU7F8Fq0T_.U5TeI22DKJb
 72CcbhQrvN8yxo96_MQudn4RFgp6PLs7oHoLNeH97FI7ojdO4wNJJVrQTzYIM8hkseN5pdMCU3i8
 vIPjOW_w69rqrCkTtbjbL7q5KU1cFFoRfj6OSBp06E.IadV9XOmkM8TGaMd.vZRP7gI8VF_lKxKs
 kHVQruW9jey3dwqKOEIjJgGgmCc2R.Uh4x64z2yItTUQqVmB9VnF7XB.lDx8kmQnKGytwrC1gti.
 59oBSA09JIVr0N2i9OxkxjdgLxYzsZThalsYCYIkpVC0QdktAxMnrQbjpuBFalYN8KmfG6hE8L.V
 02erJYlZJoj2nz8wVg6k7l38t9ayBG_e4JX7XTXhcuPwPjy6Gh.IBe1muB8UGbojjg3Gc3TkU49l
 EdEHHihFLeb_FYM8cv_QYWJpA7J53XC88G4xT9GlJmpyeU2IUOm8uBP8vpqGQFeQLvLllLHMVLck
 .TPXa7etAHJ3PG_C0PmCMqb.1pA4SexRqmHulL5CQsdbyRt2xhFAVUy_dMdC97WbOnEBIl6Rwnpk
 awzbLsWsqLq5OEREHeRwOQgKUfXS0UUrzyerpIz0KnltIZBKC9DPpr2ssFsbYHk5ec75Up3xEbVl
 Jv9idEwV_wobN_.0Ea6Wg1Cggm7wx3Avd8Mxqarnwbbd1VYu6Y.0y60aAS9CdvqjzOhZ_ONAt5TJ
 tOU9eAa7.8HeVouFk1Bp6bcF1mHqstz8MjCSiWj_HuZfv2.JXKEYf4nJBaiOfIyeFWjF2QR7bZe3
 kFAQ3t8tmPMGjH.LpMQ7fPg_PKHXMRMHKEOUjAt3pQhx9NG0.L5PfhyRa__Tr4w6J8MTY7yKzxbF
 oPiguxUht1jbZEbpmLV7HHD2e6H4_pKun2ThUaL1K1NPRpS51TJThvUdowf0cgirI9wVcb8JbodM
 lGDNRJyYCAD6sGLCjPIeJzXdCtErUmAglh78Hg4i4CHoUPDi.8ypy2TY6z6frbg6eJrMEcrhgvcT
 4uguQcCFcq6AmI.xiLwDGzEiByn9Awb_2elIG0zhs0mqNWmiDbCdPwqJd34tf9PVGpQppqMMyfJf
 0Jx9A77gL5ZW0LnK5u85q0z.a4ZUg1_wUgJxLHDALtLkAcdwDEhQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Sep 2020 10:45:18 +0000
Date:   Fri, 25 Sep 2020 10:45:17 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1666527215.663964.1601030717484@mail.yahoo.com>
Subject: YOUR HELP FOR THIS TRANSFER.(Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1666527215.663964.1601030717484.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
