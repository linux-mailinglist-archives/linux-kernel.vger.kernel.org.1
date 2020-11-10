Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F102AE11E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgKJU4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:56:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgKJU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:56:34 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605041792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3OCDDykxm75oQ+X0v+Bq8zz0zI84NXCyUalM/m2yK8=;
        b=y06k4RY7XCZk4viumC4BENASSjmi6BBNWoavsw6bsqU5UpEt3YJ+pz4WwXdPmSIQMo9i4z
        +pdihdGLS7kVgY86X+CuTdhuGOC39FCjdxqz1o+1EXfFBXp4iY6PooFwSHYcnVI+dVSqjR
        cotEZperNJEQXogbbP7SMe/bR2W3vVZaJ23oEvKzLpYdmEjIsl1HExZKTLZt0Z/imqHYdG
        5LDfLZi2c6i3iUX3vP2BQzricabmv3ivqpFiYG/2DXMpG45ku8ugA5OqtMwDC5mEaoYJQi
        bl9uC9wEZBvoEZxiixJQ3iAevxYNY/O4XM1cAEBYZPMaynRfQZoFv/Z0/fdxyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605041792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3OCDDykxm75oQ+X0v+Bq8zz0zI84NXCyUalM/m2yK8=;
        b=8vc6N5Q7IQ+rrgQ3vqfUqYLHmBWbu1M/XlnUY6QV92mos6uDdr4isiMQqhgDIQKs1JVkqd
        8GHL6CAnY6VZUqCg==
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: "irq 4: Affinity broken due to vector space exhaustion." warning on restart of ttyS0 console
In-Reply-To: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
References: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
Date:   Tue, 10 Nov 2020 21:56:27 +0100
Message-ID: <871rh1gcck.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit,

On Tue, Nov 10 2020 at 14:24, Prarit Bhargava wrote:
> Occasionally when logging out of the ttyS0 aka serial console I see that
>
> 	irq 4: Affinity broken due to vector space exhaustion.
>
> *** console shutdown, IRQ released for cpu on socket 1
> *** console starts back up again, IRQ assigned to on cpu on socket 0
>
> In this process, however, the smp_affinity is not cleared for IRQ4.  That is, it
> remains as
>
> /proc/irq/4/smp_affinity:ffffff00,0000ffff,ff000000
>
> so that the check in activate_reserved() fails and
>
> "irq 4: Affinity broken due to vector space exhaustion."
>
> is output to the screen.
>
> I am not sure of correct fix here.  It looks like the smp_affinity should be
> reset to default at irq shutdown, however, I cannot determine if that should be
> done for every IRQ, or (hopefully not) per driver.

This has been that way forever and there was a discussion about this
at least 15 years ago. I can't find it at the moment because I can't
access my archives and I failed to find the conversation on lore.

But here is the gist:

At some point I actually wanted to reset the affinity mask to the
default affinity mask in free_irq() when the last action was
removed.

That broke setups where the affinity of the serial console interrupt,
was set to some specific CPU by the admin and then it was moved to some
other place due to logout -> shutdown -> startup.

So we left the historic behaviour untouched.

So now you are complaining about it the other way round and I have to
tell you that there is no correct fix neither in the core nor in a
driver.

The real problem is irqbalanced aggressively exhausting the vector space
of a _whole_ socket to the point that there is not a single vector left
for serial. That's the problem you want to fix.

Thanks,

        tglx
