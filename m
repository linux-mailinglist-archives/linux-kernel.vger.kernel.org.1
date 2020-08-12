Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94122242B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHLOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 10:39:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgHLOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:39:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597243182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtqjfrjk/gwIUo2z+x3Wlx6nrBpRl0eqdlnNtm5WIlE=;
        b=wrTJs/YOqvIU6zzxlJwEc1R4Rs9XLE394co6fvG3qBwMyKh1ckhIi+W5iEMNHerTkYSpX6
        /quBL1HAnncWZuAz7tpphQOEYxr/DDH9x1CPgx7tdNzM0dwYW5amMI66uk+9xKMl9oJEXp
        JpuXpPOpBIA9iA7J+NAm7+7EALOIXRqC3IS3yjh7BTpVUGEG82rzSocwSXX2yPlsT2TwK8
        vvQDtkQKQKb7KNPNWNMdH9CQz7ms5NQuVLxBUp/upCrcVkfATzu6xhfYj1ii0GCNZxOSyP
        GLAK1VKFZPAnL7R/AVWAkIEYYbGumMqoy1WvFcdQ/CqHol1HLFMj0urDifbD/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597243182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtqjfrjk/gwIUo2z+x3Wlx6nrBpRl0eqdlnNtm5WIlE=;
        b=KQcwQp41X3nIbc8yOoAdrGFBddQ312fnDY/gkBH6XUFmsRgbMv+F5b4zyyeqTqxZON1EH1
        mjELv/9eYyb0adAw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/alternatives: Let __text_poke() acquire the pte lock with enabled interrupts
In-Reply-To: <20200706164215.2502730-1-bigeasy@linutronix.de>
References: <20200706164215.2502730-1-bigeasy@linutronix.de>
Date:   Wed, 12 Aug 2020 16:39:41 +0200
Message-ID: <87eeoc53o2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

sorry this fell through the cracks ...

> The pte lock is never acquired from an IRQ-off region so it does not
> require the interrupts to be disabled.

I doubt that this is true. It surely is acquired within other locks
which might be taken with spin_lock_irq(). Which is completely fine on
RT.

But that's not the point. The point is that pte_lock() does not require
to be taken with interrupts disabled.

Please be precise about these kind of things. Handwavy descriptions
cause more problems than they solve.

> RT complains here because the spinlock_t must not be acquired with
> disabled interrupts.
>
> use_temporary_mm() expects interrupts to be off because it invokes
> switch_mm_irqs_off() and uses per-CPU (current active mm) data.
>
> Move local_irq_save() after the the pte lock has been acquired. Move
> local_irq_restore() after the pte lock has been released.

While part 1 is correct, part 2 is the exact opposite of what the patch
does.

  Move the PTE lock handling outside the interrupt disabled region.

describes precisely what this is about without any gory details which
can be seen in the patch itself. Hmm?

Thanks,

        tglx

