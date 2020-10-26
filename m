Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF482998A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgJZVVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:21:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgJZVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:21:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603747296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lkoWn6wcOFMTEOogm/Sqf3fEH2S/rX9rztcdNBPDfA=;
        b=SToqhqmgRX6Vzs/Mym0aZ8Z2G4TzrKFFfjWUHtG0QByqKG7ws9EAw4uRf2Ez6PT9x8BAb1
        LBx3QZEIElMIjEeCkYbCJcAYibNF2Euzo07v2OY9ozAlWswtrzGx/flOvT+pgmlM/7GVmn
        B4zi7+m2VTjvxgcS0wZqGkdLdHtMdyoanfqbgoqEEe2kEU6FAtIzrVOHRDJ1OUacBlhCJf
        QUWuZs4NjdYGVGoI2aVJqnvSHmVLtYBiXVK3Jhqs+vtPYGJixLArq98sI1j8AEU4ESs2zg
        xjGdexISfRQCU6YtSrqom/9k80dBtcfzFOKxyeLNLUmwb4tJGhQcVSnlFjyEqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603747296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lkoWn6wcOFMTEOogm/Sqf3fEH2S/rX9rztcdNBPDfA=;
        b=6HgJyqSFqo4iDdJgNJrQ9Jjj60Sy44P8+J6oyjZXgqpjmijD/kx/J8YwOJSirJ6rzSldOR
        qQw34ev+pgekZpCg==
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com> <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com> <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com> <87y2js3ghv.fsf@nanos.tec.linutronix.de> <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
Date:   Mon, 26 Oct 2020 22:21:36 +0100
Message-ID: <87o8ko3cpr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26 2020 at 17:28, Guilherme Piccoli wrote:
> On Mon, Oct 26, 2020 at 4:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> It gets flooded right at the point where the crash kernel enables
>> interrupts in start_kernel(). At that point there is no device driver
>> and no interupt requested. All you can see on the console for this is
>>
>>  "common_interrupt: $VECTOR.$CPU No irq handler for vector"
>>
>> And contrary to Liu's patches which try to disable a requested interrupt
>> if too many of them arrive, the kernel cannot do anything because there
>> is nothing to disable in your case. That's why you needed to do the MSI
>> disable magic in the early PCI quirks which run before interrupts get
>> enabled.
>
> Wow, thank you very much for this great explanation (without a
> reproducer) - it's nice to hear somebody that deeply understands the
> code! And double thanks for CCing Bjorn.

Understanding the code is only half of the picture. You need to
understand how the hardware works or not :)

> So, I don't want to hijack Liu's thread, but do you think it makes
> sense to have my approach as a (debug) parameter to prevent such a
> degenerate case?

At least it makes sense to some extent even if it's incomplete. What
bothers me is that it'd be x86 specific while the issue is pretty much
architecture independent. I don't think that the APIC is special in that
regard. Rogue MSIs should be able to bring down pretty much all
architectures.

> Or could we have something in core IRQ code to prevent irq flooding in
> such scenarios, something "stronger" than disabling MSIs (APIC-level,
> likely)?

For your case? No. The APIC cannot be protected against rogue MSIs. The
only cure is to disable interrupts or disable MSIs on all PCI[E] devices
early on. Disabling interrupts is not so much of an option obviously :)

Thanks,

        tglx




