Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFFB295A83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509368AbgJVIht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:37:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508247AbgJVIhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:37:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603355866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QyrQSQmCRoE8e/yyUqmfECgKX4VgXOUeiqXGpq3mP/o=;
        b=B99Knje7mrFwyx04a4DftGWbzUOcUu5Q2wD49824cq5FfoSS6yVttHCESYzlP4uy+Io29N
        FF8KMUsdetdGVgt+iYV0r6eLMNEiVnt1fOXzX8h6Uxkx0tl1iC2TRQB+vR7UkmV+wXjUJ/
        Hut1ewDzhQSVJNcC+6FNZdOrARtyNeBDoXLf2KnvpkZBm62uzIFHXgzZm6PPvHvLmXescC
        Hp8SN2W0SYT0Wgwe1T+vtvWjPZ/DpOzsmzlju1PPdqrYbvsB72+wPQt/mz78FjPnQMGeoP
        HmC9ZcYTWOd8nzEPIPAy/3GUV7d0AV2N0c5LGYr6+zI2oTObq79jpFnSYkGwKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603355866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QyrQSQmCRoE8e/yyUqmfECgKX4VgXOUeiqXGpq3mP/o=;
        b=SBL2SbiGQs74m8lQq8dx4auN2wtwVZkTfiXi6gnjnezfm5dpJdZhHv7gzNIyeeuhl0yb11
        JAtMRK9rJNxqB+Cw==
To:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
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
        kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
Date:   Thu, 22 Oct 2020 10:37:46 +0200
Message-ID: <871rhq7j1h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> When the bug happens, the kernel is totally occupies by irq.  Currently, there
> may be nothing or just soft lockup warning showed in console. It is better
> to warn users with irq flood info.
>
> In the kdump case, the kernel can move on by suppressing the irq flood.

You're curing the symptom not the cause and the cure is just magic and
can't work reliably.

Where is that irq flood originated from and why is none of the
mechanisms we have in place to shut it up working?

Thanks,

        tglx




