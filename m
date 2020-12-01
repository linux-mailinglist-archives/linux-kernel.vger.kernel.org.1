Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF692CA02A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgLAKnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:43:05 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33399 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgLAKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:43:05 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id D93055C0049;
        Tue,  1 Dec 2020 05:41:58 -0500 (EST)
Received: from imap10 ([10.202.2.60])
  by compute2.internal (MEProxy); Tue, 01 Dec 2020 05:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=83lq7
        H2AudqPqV6U1v4+OB1Vg+87j8hfUK7DD+90RqU=; b=bYFGNav0BYbfcBB9RwavM
        0L6NKBtTvn31Zjbonpo4CEpKcyuyAOpFuDqiqbgWqi64yzpftT4iArjXB/Q2tVur
        y262p4mvXCW6WdaAyHV5XI14gwkp4wEFSLEa/D55484INg+/HELF5tLuTZwWqPFA
        hYMPLGq2rqHbEC+A7+ANe2VSMYuFBaMhrT1hJV/v/9fMPbKJc+wAHxtX2a1Yq6xj
        1CkqyfAVJ4T8p32P11cHg1VXX+BLoQUOO/OyAeHUBAuh/IWFqAI865WBL+32VZsb
        cpVVAzbdRCM1R8ezmufeax/WkiNsaPiinTj1Xgw5BGGts8N2iYzA9QgpAkj+Irms
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=83lq7H2AudqPqV6U1v4+OB1Vg+87j8hfUK7DD+90R
        qU=; b=K4uNWvuIauVo+nPieQrssiNL2cm3CTUZTKJgb1G+EmQNVHIzfKayYaO3k
        JeVcinYDnedDsLnvqsXLQ5XKljrCvtvrZndG42k2rEIj0KoSO5RdBzT8AeMJw507
        qPRopmDFLqGccLiCYdFtWoY412UUqPC5gVEuul5jrQ9AerRnJlcgxHsKtdfxlV70
        HKMZuab0iwpb6ffWjOn/BxVJ7kxZikA3H15E2c60o+TykXOhBGAVejkCnmxxZ5iy
        fLLrbjC5U7jhWHKrZAtr85fMAQdQe6D8i1cUhLCQwJKLNWGx6+DRIopZrLnVfKsz
        BSZrlOaeedG0fwzv/9MgFQaR7GsOA==
X-ME-Sender: <xms:9h3GX_zAGqKGUg2BMSstA4immRfzcpgBvJz3tL1t0ZFOTCOm3cZZWg>
    <xme:9h3GX3SvDMfu9--C01CDz74_z2M52S24KD0Bi3qTWndZGi9FNT_GUCD8X9ckLtvml
    uBhHJxtGzHN9fZymQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpefnrghu
    rhgvnhhtihhupgfpihgtohhlrgcuoehlnhhitgholhgrseguvghnugdrrhhoqeenucggtf
    frrghtthgvrhhnpeeigfejueegtdetgefftdduieehiedvtdetgfdtjeevudeghedvtdeu
    uedvuddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:9h3GX5VEWXTQ02dr-sphTckj4q_GBxNsQqDuJp0Zlk0t8G0kxe-fgg>
    <xmx:9h3GX5h933G6mxIKYd1QDUqT_NiW865pRUA3zmaeQXrK-UkkKkxIJw>
    <xmx:9h3GXxDOYhtG9O1o2F9KXtK1Md6MPZWsXnA7jYPTp65edIvLs4mSvQ>
    <xmx:9h3GX8-faT36SUGorawueLJp3QTnuYWGc-5WLiNlxcgzDoBkJMhBvA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22CA5201BD; Tue,  1 Dec 2020 05:41:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <e825d155-a5bf-4a41-a43b-7506b401f408@www.fastmail.com>
In-Reply-To: <87o8jdhkuo.fsf@nanos.tec.linutronix.de>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
 <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
 <87lfeiiy10.fsf@nanos.tec.linutronix.de>
 <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
 <87tut6h10u.fsf@nanos.tec.linutronix.de>
 <69841ea6-5998-46ca-8e49-3e9ee65fc8b1@www.fastmail.com>
 <87o8jdhkuo.fsf@nanos.tec.linutronix.de>
Date:   Tue, 01 Dec 2020 12:41:37 +0200
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020, at 12:38, Thomas Gleixner wrote:
> On Tue, Dec 01 2020 at 10:18, Lauren=C8=9Biu Nicola wrote:
> > On Tue, Dec 1, 2020, at 01:34, Thomas Gleixner wrote:
> >> Just for completeness sake. Can you provide the line in /proc/inter=
rupts
> >> for irq 7 on that machine?
> >
> >
> >   55:          0          0          0          0          0        =
  0          0          0          0          0          0          0   =
       0          0          0          0          0          0         =
 0          0          0          0          0          0          0    =
      0          0          0          0          0          0          =
0  IR-PCI-MSI 2625543-edge      xhci_hcd
> >
>=20
> IRQ 55 !=3D IRQ 7. I really meant IRQ 7.

Sorry, I thought they were numbered differently. I guess this 7?

   7:          0          0          0          0          0          0 =
         0          0          0          0          0          0       =
   0          0          0          0          0          0          0  =
        0          0          0          0          0          0        =
  0          0          0          0          0          0          0  I=
R-IO-APIC    7-fasteoi   pinctrl_amd

Lauren=C8=9Biu
