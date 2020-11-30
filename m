Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC80E2C8A13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgK3Q5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:57:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgK3Q5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:57:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606755387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPLMY8agdPfpg8tZym34BdpnYPVQfhVPtqJvt8smWi4=;
        b=kCtHnESqlhl0tTSC6WvNZrPuOuiYGcWJosF9W30/gRlYX4iBlPcR8oLmcFUZqmICVhzIl3
        Ut7CtJGbalD6kC/wNEQ66ImrzCGqc47f7Emq9Ezt9KvpTMZmlvwhG16IKWwZDN01vh5e3h
        jR/Ic4i9h3vvlZe4NLf//4zKIYFdPzP8+cQvtciGu6iHvH7dtsDz20JCn+TFrwKGHKpYJj
        8D+ROzUCxxIsdWI0E1qvPLpS0PstOb+lc9I9IdMtkoZvS9PqAt1TnUqiHua5dm8RyAyHh7
        TzpMjj25H76V4NyIBpikuURMljmjiJIQ2J7pmCU7cp51LxdD+KkL3A2Ni6II4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606755387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPLMY8agdPfpg8tZym34BdpnYPVQfhVPtqJvt8smWi4=;
        b=1Nx66VEtiIYfeHg4Rlm8TWz5aHeSqbSOmCJNHSKGzoXL5M6r1zcDZ4mNhgC0fZWCBQbKSe
        N5JBdbYEyUDw2BCw==
To:     =?utf-8?Q?Lauren=C8=9Biu?= Nicola <lnicola@dend.ro>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
In-Reply-To: <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
References: <20201126074734.12664-1-lnicola@dend.ro> <875z5rk68z.fsf@nanos.tec.linutronix.de> <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
Date:   Mon, 30 Nov 2020 17:56:27 +0100
Message-ID: <87lfeiiy10.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurentiu,

On Fri, Nov 27 2020 at 10:03, Lauren=C8=9Biu Nicola wrote:
> On Fri, Nov 27, 2020, at 02:12, Thomas Gleixner wrote:
>> On Thu, Nov 26 2020 at 09:47, Lauren=C8=9Biu Nicola wrote:
>> > These messages are described as warnings in the MSI code.
>>=20
>> Where and what has MSI to do with these messages?
>
> There's a comment referring to it as a warning, but an error seemed a mor=
e appropriate severity:
>
>      * If the vector is unused, then it is marked so it won't
>      * trigger the 'No irq handler for vector' warning in
>      * common_interrupt().

That's a description for the logic in the MSI code which is required to
_NOT_ trigger the 'No irq handler' message. If that message appears then
something _is_ badly wrong. Either the kernel screwed up or something in
the BIOS/firmware/hardware is bonkers.

>> > Spotted because they break quiet boot on a Ryzen 5000 CPU.
>>=20
>> They don't break the boot.
>>=20
>> The machine boots fine, but having interrupts raised on a vector which
>> is unused is really bad.
>
> That's right, sorry. It still boots, but it's no longer "quiet",
> that's what I meant.

Right, but surpressing that is not a solution.

>> Can you please provide the actual message from dmesg?
>
> Sure:
>
> [    0.316902] __common_interrupt: 1.55 No irq handler for vector
> [    0.316902] __common_interrupt: 2.55 No irq handler for vector
> [    0.316902] __common_interrupt: 3.55 No irq handler for vector
> [    0.316902] __common_interrupt: 4.55 No irq handler for vector
> [    0.316902] __common_interrupt: 5.55 No irq handler for vector
> [    0.316902] __common_interrupt: 6.55 No irq handler for vector
> [    0.316902] __common_interrupt: 7.55 No irq handler for vector
> [    0.316902] __common_interrupt: 8.55 No irq handler for vector
> [    0.316902] __common_interrupt: 9.55 No irq handler for vector
> [    0.316902] __common_interrupt: 10.55 No irq handler for vector
>
> These only show up during boot (and not e.g. when a disabling and enablin=
g again a CPU).

That's the AMD plague which is known for quite some time and it's pretty
much confirmed that it is a BIOS/firmware issue.

I don't know whether AMD has figured it out and told their OEMs what to
do about that or whether the OEMs just ignore it because windows ignores
it or is not affected for whatever reason.

Thanks,

        tglx


