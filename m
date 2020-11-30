Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B842C92C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbgK3XfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:35:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbgK3XfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:35:23 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606779281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWqrd7D5KtHqCCDcNt0m/1cG6lF+gTcc+y6LmaQsPCs=;
        b=Q8eS/aywmVHlVBwJ9CSF95kC2S+nvgXhRKulapBPDkZZrkvJime3JM+lT9XlKeTWDQjA7o
        lTIgounmEbPlRArtLHND9DmYVneO3P72XYr+hxC907ZtPR7VC/KTnEosgyD9YykIqegz7P
        vvs/A+yUbkqsquF4KtTlkLgrd6iuZEcjCNFch+08KwwKGN5/vldDgWwRowbnJ6CzRt0iUR
        JW5q1J5sI7zQ8CAym6UZ6VNPatGbCgnF365+hGukU8cNL17NCovap0oU9EEi1cAbSgEeYS
        wJU7vxyNxch5qeuwK+ACGtcrVCRAiB9kqiz9fN/IevfRhmMBi4QPYBt5enIAfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606779281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWqrd7D5KtHqCCDcNt0m/1cG6lF+gTcc+y6LmaQsPCs=;
        b=knVZEamVvMEGLGFFzdQ4PlG3kA9f3hvR0z1vcoYZyPFK8/0KRTDWk51OdIvKECD6f6dwxL
        vjUfc6uYhDWomsDg==
To:     =?utf-8?Q?Lauren=C8=9Biu?= Nicola <lnicola@dend.ro>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
In-Reply-To: <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
References: <20201126074734.12664-1-lnicola@dend.ro> <875z5rk68z.fsf@nanos.tec.linutronix.de> <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com> <87lfeiiy10.fsf@nanos.tec.linutronix.de> <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
Date:   Tue, 01 Dec 2020 00:34:41 +0100
Message-ID: <87tut6h10u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30 2020 at 19:22, Lauren=C8=9Biu Nicola wrote:
> On Mon, Nov 30, 2020, at 18:56, Thomas Gleixner wrote:
>> > That's right, sorry. It still boots, but it's no longer "quiet",
>> > that's what I meant.
>>=20
>> Right, but surpressing that is not a solution.
>
> I'm just downgrading it from "emergency" to "error". It will still be
> displayed for most users snd anyone looking in dmesg. But I'm unlikely
> to convince my motherboard manufacturer to fix this in the BIOS, and
> the errors are basically unactionable and uninformative (unlike say
> "can't set up page mappings" or "your CPU might be on fire" which
> would really imply a crash soon).

The point is that for some cases this can result in a non working
machine which just hangs and if it's below the usual loglevel cutoff,
then it's not visible, which is more annoying than a non-quiet boot if
you're affected.

We are looking into a way to mitigate that AMD wreckage, but so far we
don't even know where exactly this comes from. The reason why we are
pretty sure that it is a BIOS/Firmware issue is that some people
reported it to be gone after a BIOS update and quite some machines do
not have this issue at all.

Just for completeness sake. Can you provide the line in /proc/interrupts
for irq 7 on that machine?

Thanks,

        tglx
