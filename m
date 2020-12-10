Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677A92D58E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbgLJLEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:04:53 -0500
Received: from foss.arm.com ([217.140.110.172]:35348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgLJLEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:04:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F6830E;
        Thu, 10 Dec 2020 03:03:28 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF8F3F718;
        Thu, 10 Dec 2020 03:03:26 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:03:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: report broken irq restoration
Message-ID: <20201210110319.GA88655@C02TD0UTHF1T.local>
References: <20201209183337.1912-1-mark.rutland@arm.com>
 <CALCETrVRiSQn9z7CG2CWHhOeQb=UJSrtPod4-8qBSFLsdYP=iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVRiSQn9z7CG2CWHhOeQb=UJSrtPod4-8qBSFLsdYP=iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:05:21AM -0800, Andy Lutomirski wrote:
> On Wed, Dec 9, 2020 at 10:33 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > index 3ed4e8771b64..bca3c6fa8270 100644
> > --- a/include/linux/irqflags.h
> > +++ b/include/linux/irqflags.h
> > @@ -220,10 +220,26 @@ do {                                              \
> >
> >  #else /* !CONFIG_TRACE_IRQFLAGS */
> >
> > +#ifdef CONFIG_DEBUG_IRQFLAGS
> > +extern void warn_bogus_irq_restore(bool *warned);
> > +#define check_bogus_irq_restore()                              \
> > +       do {                                                    \
> > +               static bool __section(".data.once") __warned;   \
> > +               if (unlikely(!raw_irqs_disabled()))             \
> > +                       warn_bogus_irq_restore(&__warned);      \
> > +       } while (0)
> 
> What's the benefit of having a per-caller __warned instead of just
> having a single global one in warn_bogus_irq_restore()?

I'd copied that from the previous proposal, and had assumed that if we
had several distinct violations we'd want to report all of them in one
boot session. I'm perfectly happy to get rid of that and make
warn_bogus_irq_restore() use WARN_ONCE() directly. 

I'm using this with a local Syzkaller instance, and as that will kill
the kernel on the first WARN() anyway, it makes no difference to me. I
guess in the field having a single warning is likely to be good enough
too.

Thanks,
Mark.
