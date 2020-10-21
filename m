Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C3294B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441710AbgJUK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410021AbgJUK17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:27:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A9720795;
        Wed, 21 Oct 2020 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603276078;
        bh=bUkGtFLF6jET5lEcrcQKVZVTxu7HB+oWtwgZEXhk4gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KLQBz9PHgGvLwOxBZ+1qjVheotgicuLH1X2/hAEvcswpbIZugQefA2fSIV5fR2oBS
         pX2fDynzIC6NC2z5Si9WEvXFw7GS2YzhgHq5mqrEJZWNTfz+f8l59CW641sDY8/7dL
         lpW6iS3LG0cWXDF0Rb042Exlk/lTdJgMOtBqWOpM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kVBLY-0030gT-B3; Wed, 21 Oct 2020 11:27:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Oct 2020 11:27:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
In-Reply-To: <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
 <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
 <f3596e3ed70737d36f72056827d7d441@kernel.org>
 <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1d41e0e4e6ee6c794b83d2c75c3748da@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-20 12:22, Sumit Garg wrote:
> On Tue, 20 Oct 2020 at 15:38, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-10-20 07:43, Sumit Garg wrote:
>> > On Mon, 19 Oct 2020 at 17:07, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> [...]
>> 
>> >> > +{
>> >> > +     if (!ipi_desc)
>> >> > +             return;
>> >> > +
>> >> > +     if (is_nmi) {
>> >> > +             if (!prepare_percpu_nmi(ipi_id))
>> >> > +                     enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
>> >> > +     } else {
>> >> > +             enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
>> >>
>> >> I'm not keen on this. Normal IRQs can't reliably work, so why do you
>> >> even bother with this?
>> >
>> > Yeah I agree but we need to support existing functionality for kgdb
>> > roundup and sysrq backtrace using normal IRQs as well.
>> 
>> When has this become a requirement? I don't really see the point in
>> implementing something that is known not to work.
>> 
> 
> For kgdb:
> 
> Default implementation [1] uses smp_call_function_single_async() which
> in turn will invoke IPI as a normal IRQ to roundup CPUs.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/debug/debug_core.c#n244
> 
> For sysrq backtrace:
> 
> Default implementation [2] fallbacks to smp_call_function() (IPI as a
> normal IRQ) to print backtrace in case architecture doesn't provide
> arch_trigger_cpumask_backtrace() hook.
> 
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/sysrq.c#n250
> 
> So in general, IPI as a normal IRQ is still useful for debugging but
> it can't debug a core which is stuck in deadlock with interrupts
> disabled.

And that's not something we implement today for good reasons:
it *cannot* work reliably. What changed that we all of a sudden need it?

> And since we choose override default implementations for pseudo NMI
> support, we need to be backwards compatible for platforms which don't
> possess pseudo NMI support.

No. There is nothing to be "backward compatible" with, because
- this isn't a userspace visible feature
- *it doesn't work*

So please drop this non-feature from this series.

         M.
-- 
Jazz is not dead. It just smells funny...
