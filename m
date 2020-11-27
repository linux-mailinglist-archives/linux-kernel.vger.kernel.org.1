Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0072C60B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbgK0IEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:04:14 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56075 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgK0IEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:04:13 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B5FC5C03E0;
        Fri, 27 Nov 2020 03:04:12 -0500 (EST)
Received: from imap10 ([10.202.2.60])
  by compute2.internal (MEProxy); Fri, 27 Nov 2020 03:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=wEAsi
        aXOmsqZMNHYu69wrrLEe6FYIcAIgszXIHF3axQ=; b=GI4uweY3cXOaaYBkgPWFO
        KuLg0NsyM8RJLtOMljTErOp6sGIb0k5k2ZgvYFUIXHl/XjN1wIXAAN/v1TQvEMxb
        xChaUs0vQY2yxlnCpIXOTfQ/2hhT7g54svMRo+3QoKUiI7Ht8Fd68VJ8ka+M4b2c
        mfFOx9dSEWpBDUhTi7z0kpDEe/AmG1716wiZ5zc1kKXUXlATngpLPxR8RNAo9XGO
        31sl4hlMWnNkmPxt7M6Un3JQ67JyPnAbqcdcHczpElJIqE3zbAZuNl0p20t2dB5Z
        EGMLopVUrDFXBizpSNyzN/6DS2GEkM0xSfTZC5jgYK0tEmq9UX+ozUdtIMqeNbEp
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=wEAsiaXOmsqZMNHYu69wrrLEe6FYIcAIgszXIHF3a
        xQ=; b=c9FggQhdEHRSZ4P1nHr9Ph+NN003DiDcfCN7o3sh+9smtok9KRvvk7Np+
        Sj9XMIdb5KpPkXT5esM6XfyzM5D6Ee5m7vcK3+kF7IjF9MPNLM5w7hVL1/kE9kQH
        KDFC+cWQn38XB4bO+gAMy8nEg2rzZ+vOtvNrPYL3vIJCM/QCB67s1GSG2eg4Kq62
        nEI+qC4p9/0GhxdVK6yikK46PDsUgP+V8BijBGg1xGSxk7bHrsanJI0v1rsaDSlw
        ycc4by+EycE140hrRia3TuCjxugI9CS0/CTQQNUvnw611eitpbM+4oLBZHoT4Lbl
        6Y8UxBd07dKZd8FKzIRZEJlZwPdwQ==
X-ME-Sender: <xms:-7LAX4Gd31dpor__ZQrNPUPY1e2T3OQZxG2bah4FDRGN3DRVLvLWMg>
    <xme:-7LAXxUSmqoV95JGS8w8rim7ONIs9tdIuA17p78ftylevkQUCculgxRnI7L-lXDf3
    f3cLcEQFsNYWriItQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgfgse
    htqhertderreejnecuhfhrohhmpefnrghurhgvnhhtihhupgfpihgtohhlrgcuoehlnhhi
    tgholhgrseguvghnugdrrhhoqeenucggtffrrghtthgvrhhnpeeigfejueegtdetgefftd
    duieehiedvtdetgfdtjeevudeghedvtdeuuedvuddukeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:-7LAXyLplOh7pBcxEBwStboJqsx1sF4jGBiisfUaLuWEbZmG3-gYqQ>
    <xmx:-7LAX6E7F31oGUmMMWxf75V2B5Q9B57rtv24bsGQKtFjsq7BJkpUrA>
    <xmx:-7LAX-XNJvXR0XCmPWDtoGzTJe9pXdeS1ucrDjsabwhIh4k_yC8Atg>
    <xmx:_LLAX9QRK1lV3lw5EEXGypWRGYET6IArNCtBJLYiDjv1qgFeaBhrsA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49EAA201D9; Fri, 27 Nov 2020 03:04:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
In-Reply-To: <875z5rk68z.fsf@nanos.tec.linutronix.de>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
Date:   Fri, 27 Nov 2020 10:03:50 +0200
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 27, 2020, at 02:12, Thomas Gleixner wrote:
> On Thu, Nov 26 2020 at 09:47, Lauren=C8=9Biu Nicola wrote:
> > These messages are described as warnings in the MSI code.
>=20
> Where and what has MSI to do with these messages?

There's a comment referring to it as a warning, but an error seemed a mo=
re appropriate severity:

     * If the vector is unused, then it is marked so it won't
     * trigger the 'No irq handler for vector' warning in
     * common_interrupt().

> > Spotted because they break quiet boot on a Ryzen 5000 CPU.
>=20
> They don't break the boot.
>=20
> The machine boots fine, but having interrupts raised on a vector which=

> is unused is really bad.

That's right, sorry. It still boots, but it's no longer "quiet", that's =
what I meant.

> Can you please provide the actual message from dmesg?

Sure:

[    0.316902] __common_interrupt: 1.55 No irq handler for vector
[    0.316902] __common_interrupt: 2.55 No irq handler for vector
[    0.316902] __common_interrupt: 3.55 No irq handler for vector
[    0.316902] __common_interrupt: 4.55 No irq handler for vector
[    0.316902] __common_interrupt: 5.55 No irq handler for vector
[    0.316902] __common_interrupt: 6.55 No irq handler for vector
[    0.316902] __common_interrupt: 7.55 No irq handler for vector
[    0.316902] __common_interrupt: 8.55 No irq handler for vector
[    0.316902] __common_interrupt: 9.55 No irq handler for vector
[    0.316902] __common_interrupt: 10.55 No irq handler for vector

These only show up during boot (and not e.g. when a disabling and enabli=
ng again a CPU).

Lauren=C8=9Biu
