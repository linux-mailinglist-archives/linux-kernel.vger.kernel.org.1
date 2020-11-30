Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629482C8ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgK3RX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:23:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48833 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387405AbgK3RXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:23:55 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CABB5C0053;
        Mon, 30 Nov 2020 12:22:49 -0500 (EST)
Received: from imap10 ([10.202.2.60])
  by compute2.internal (MEProxy); Mon, 30 Nov 2020 12:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=JKCb/
        Ay1HfLxw6EsereQd5gfYSCMCnMxx1Pr2KSqtNA=; b=AF/D0VNLgCIl/sONSJ1Aq
        PE+EtxVyD+JmZRk+MAOL0yfpe6/mKZie3JjGZYpphV17FNayhYbVkq1gZKKfKnhl
        Qw//hEf6sKnd0au0b0m1YaeW4UD2cafFEoSgYYcy3yFj4s3T+u8Q/B+ZZyRiHBWN
        VakgvvQe0gmy6aMKaKGLWm0FMbd0608YwETk0EZw0sE+0iDu19v38MvWozjhldT2
        eTU9gnR2SQXEnO9En1d+d8uM78H5L7HkALXFZMBANP7Gi3tO+omMGZ1XFvq32bIu
        pYXNQswqztS24VwNvdXkFhXGELY2u72M/WrfwbCFC80VU9jZBTFLFygcAwY/Tn57
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=JKCb/Ay1HfLxw6EsereQd5gfYSCMCnMxx1Pr2KSqt
        NA=; b=I8JzHHN25HytNS6GjBrKEj3WD8HPUpvvj+3ZZT/c8N8sG55JhzS5RAwZP
        9LNbr6PzLReRXOgyxyWxHXMKGLcUips+y7w/UgogY5/iKaRfrIXvGQx/qnZyXYCz
        meHvf3/ZCglYc03bA0MCRFR6mIVcS5Dwr5dHaJ42A0icn9Q1odS+WtV1AyCCTGFr
        5z8cJ2hleLuU7R63eS7cN09ynWUGItV9Bl34WiRgaade5hBCs/648ayosT+tpBh4
        FE29VlK0qal9NjtmpegavmBr5x9rPyGoF4V5JR07KHKfCUi68lzGvTJAO3uyUrZU
        OpCgzZINIvtnRwbpMSVg05xMbJvQQ==
X-ME-Sender: <xms:aCrFX1OzVUywExwd1rtfWVKJ-U_VCiUkkxQu2lT3RW44mOUd5fTQ_g>
    <xme:aCrFX38IFBJm-DzrUSlIBMSZYf7zPZ7DfdsUA4okzfP5hTTeDA7D0JOAuEnXan2Oz
    y9HTjN5tiJ7rCGNRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeitddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpefnrghu
    rhgvnhhtihhupgfpihgtohhlrgcuoehlnhhitgholhgrseguvghnugdrrhhoqeenucggtf
    frrghtthgvrhhnpeeigfejueegtdetgefftdduieehiedvtdetgfdtjeevudeghedvtdeu
    uedvuddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:aCrFX0QQnqAyhz-6-HFrCFlFOEkfeInT6tVoOlm6KGPqxEAvXFENIg>
    <xmx:aCrFXxtxfaGxt-e2rQYAsrTvowzZqXKi9p7FVgjWhoHq5-KjWjdZgg>
    <xmx:aCrFX9cuL2EyO2nMzbeBHO6gvLAJE5-bPspBFNFmoO0uRAaCC6ffOg>
    <xmx:aSrFX07MWnIQPfYF-WWc5JS28ZFSIVz2FP9RR-i1SNtaTvpt2oRQWg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4C20A200DB; Mon, 30 Nov 2020 12:22:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
In-Reply-To: <87lfeiiy10.fsf@nanos.tec.linutronix.de>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
 <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
 <87lfeiiy10.fsf@nanos.tec.linutronix.de>
Date:   Mon, 30 Nov 2020 19:22:12 +0200
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



On Mon, Nov 30, 2020, at 18:56, Thomas Gleixner wrote:
> Laurentiu,
>=20
> On Fri, Nov 27 2020 at 10:03, Lauren=C8=9Biu Nicola wrote:
> > On Fri, Nov 27, 2020, at 02:12, Thomas Gleixner wrote:
> >> On Thu, Nov 26 2020 at 09:47, Lauren=C8=9Biu Nicola wrote:
> >> > These messages are described as warnings in the MSI code.
> >>=20
> >> Where and what has MSI to do with these messages?
> >
> > There's a comment referring to it as a warning, but an error seemed =
a more appropriate severity:
> >
> >      * If the vector is unused, then it is marked so it won't
> >      * trigger the 'No irq handler for vector' warning in
> >      * common_interrupt().
>=20
> That's a description for the logic in the MSI code which is required t=
o
> _NOT_ trigger the 'No irq handler' message. If that message appears th=
en
> something _is_ badly wrong. Either the kernel screwed up or something =
in
> the BIOS/firmware/hardware is bonkers.

Agreed, just pointing out that the MSI code refers to it as a warning (a=
s opposed to a critical error).

>=20
> >> > Spotted because they break quiet boot on a Ryzen 5000 CPU.
> >>=20
> >> They don't break the boot.
> >>=20
> >> The machine boots fine, but having interrupts raised on a vector wh=
ich
> >> is unused is really bad.
> >
> > That's right, sorry. It still boots, but it's no longer "quiet",
> > that's what I meant.
>=20
> Right, but surpressing that is not a solution.

I'm just downgrading it from "emergency" to "error". It will still be di=
splayed for most users snd anyone looking in dmesg. But I'm unlikely to =
convince my motherboard manufacturer to fix this in the BIOS, and the er=
rors are basically unactionable and uninformative (unlike say "can't set=
 up page mappings" or "your CPU might be on fire" which would really imp=
ly a crash soon).

The messages themselves are only a cosmetic issue -- they replace the BI=
OS logo that would otherwise stay up until the display manager started.

But if you think this should really be an "emerg" message, I'm not going=
 to insist anymore. I'm sure you have more important patches to review :=
-).

Thanks,
Lauren=C8=9Biu

