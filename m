Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3662DC398
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgLPP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:58:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLPP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:58:19 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608134257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80glSr0jEzo4oSKGGKnGZ7CRQwAkzL5WNM7DgoSyHDg=;
        b=MysT5Gm4zYUtb+q9bv8uTxyLn21ntzSjA9/etg9V811w07sHF/FPwfgartPZrauYpFjpXc
        P8J+zQNpe9BpirCXpozsVAaSkk76ijQ3k28dQdSXNmFY3XE/u3QGf0qxwbUPI24jQAXYKY
        R50fumDtW/2vjXYryxQ9O0AYArhlzsX6uUeAK10+qu4+wZ/UppaAwrf2dy62fH/dK296wc
        RnyLaRRlaLXdO9qWnb9HKKYDzTDuZl/vWy0IMQ32EDPCuMU+AcKn+tJHDUVHdlPIXsxTV/
        nP/Ohy6mpxQt9KeTBnwiUoLIw8Fn40gfTuHbybB1aSGlqAHaCeYxDARLqoVsOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608134257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80glSr0jEzo4oSKGGKnGZ7CRQwAkzL5WNM7DgoSyHDg=;
        b=pT6hJo9THBLSoM+dw82/sH6MwIDLf2vcRmtLFcHEFj144ipex5+hcwMG83s3FXx6EQ0cj1
        XvzUSnZbR4XKs7Cw==
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: x86_32: CONFIG_PHYSICAL_START problem
In-Reply-To: <82a78e8c-b4e6-3eb7-01e3-286bcbb869e3@infradead.org>
References: <82a78e8c-b4e6-3eb7-01e3-286bcbb869e3@infradead.org>
Date:   Wed, 16 Dec 2020 16:57:37 +0100
Message-ID: <87ft45spzi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12 2020 at 22:29, Randy Dunlap wrote:
> Little to my knowledge, this came up with
> CONFIG_PHYSICAL_START=0x81000000
...
> I tracked it down to this large value of CONFIG_PHYSICAL_START
> and changed it back to its default value, then the kernel
> built with no problems.
>
> So far I haven't been able to track the chain of values/changes
> that involve PHYSICAL_START, __PAGE_OFFSET, LOAD_OFFSET, etc.

It's convoluted :)

> Anyway, I would like to see PHYSICAL_START limited to some
> acceptable range of values in arch/x86/Kconfig,

Its the combination of CONFIG_PHYSICAL_START and CONFIG_PAGE_OFFSET so
having checks in Kconfig is going to be a challenge.

> or at a minimum, a little bit better error message coming
> from arch/x86/kernel/vmlinux.lds.S:
>
> . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
> 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
>
> so maybe:
>
> . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
> 	   "kernel image bigger than KERNEL_IMAGE_SIZE or load address is too large");
> (or start address)

Some reasonable error message is definitely due, but we probably can
catch that at the compile stage already once we computed the combined
values. Then we can sanity check those for resonable ranges.

Thanks,

        tglx
