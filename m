Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3692927D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgJSNEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSNEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:04:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4603E21D7B;
        Mon, 19 Oct 2020 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603112661;
        bh=f7aZVZxIW095a11h6Oz4CE6srePjutuTG6DDZkS52ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wAleNXbscVK1nEn/IfNnIyd1QJ+0X5dWPS94NFhobuiQLt7XbuP3IceqQFkSk0zeF
         D0qaIzpLT+Evhnn/39n0+5fmsQZpEMfXBi6oVFSRQBt08nQnJmSkA5ioqHDq4OnQG6
         ysGA+HE5Lhj/pJknm60evednwhm/loHPTldjBllE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUUpn-002QJl-9M; Mon, 19 Oct 2020 14:04:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 14:04:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal
 interrupts
In-Reply-To: <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 2020-10-19 13:42, Vincent Guittot wrote:
> Hi Marc,
> 
> On Tue, 1 Sep 2020 at 16:44, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> In order to deal with IPIs as normal interrupts, let's add
>> a new way to register them with the architecture code.
>> 
>> set_smp_ipi_range() takes a range of interrupts, and allows
>> the arch code to request them as if the were normal interrupts.
>> A standard handler is then called by the core IRQ code to deal
>> with the IPI.
>> 
>> This means that we don't need to call irq_enter/irq_exit, and
>> that we don't need to deal with set_irq_regs either. So let's
>> move the dispatcher into its own function, and leave handle_IPI()
>> as a compatibility function.
>> 
>> On the sending side, let's make use of ipi_send_mask, which
>> already exists for this purpose.
>> 
>> One of the major difference is that we end up, in some cases
>> (such as when performing IRQ time accounting on the scheduler
>> IPI), end up with nested irq_enter()/irq_exit() pairs.
>> Other than the (relatively small) overhead, there should be
>> no consequences to it (these pairs are designed to nest
>> correctly, and the accounting shouldn't be off).
> 
> While rebasing on mainline, I have faced a performance regression for
> the benchmark:
> perf bench sched pipe
> on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
> 
> The regression comes from:
> commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal 
> interrupts")

That's interesting, as this patch doesn't really change anything (most
of the potential overhead comes in later). The only potential overhead
I can see is that the scheduler_ipi() call is now wrapped around
irq_enter()/irq_exit().

> 
>           v5.9              + this patch
> hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
> thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
> 
> By + this patch,  I mean merging branch from this patch. Whereas
> merging the previous:
> commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> /proc/interrupts")
>  It doesn't show any regression

Since you are running perf, can you spot where the overhead occurs?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
