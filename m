Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257BE27729A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIXNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:38:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:52416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgIXNix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:38:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600954731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWItYUbY3YNkAAw7wM9cL9xVXm/akhjF8HLSfu/R4BU=;
        b=X1pTtNBesdsh7D2hQaOwWIEOBqg8QTEnYvOAQ3smjrbRJUoKs7CfUtKSRqqc13qTMgWBV+
        hFkTnwECJAZ2fJ2+xPq20xt5biHb/KeHGVIj1brHiAdPSyaUtl9Qs9y9cq/IC5zksYtHKL
        UIqlXzvXEYQndaOPPBqNcosdGoLKbfQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51634AD07;
        Thu, 24 Sep 2020 13:38:51 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:38:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] printk: Add more information about the printk caller
Message-ID: <20200924133850.GF29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924042414.GA6039@lx-t490>
 <20200924125259.GC29288@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924125259.GC29288@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 14:53:01, Petr Mladek wrote:
> On Thu 2020-09-24 06:24:14, Ahmed S. Darwish wrote:
> > On Wed, Sep 23, 2020 at 03:56:17PM +0200, Petr Mladek wrote:
> > ...
> > >
> > > -static inline u32 printk_caller_id(void)
> > > +static enum printk_caller_ctx get_printk_caller_ctx(void)
> > > +{
> > > +	if (in_nmi())
> > > +		return printk_ctx_nmi;
> > > +
> > > +	if (in_irq())
> > > +		return printk_ctx_hardirq;
> > > +
> > > +	if (in_softirq())
> > > +		return printk_ctx_softirq;
> > > +
> > > +	return printk_ctx_task;
> > > +}
> > > +
> > 
> > in_softirq() here will be true for both softirq contexts *and*
> > BH-disabled regions. Did you mean in_serving_softirq() instead?
> 
> Good question!
> 
> I am not sure if people would want to distinguish these two
> situations.
> 
> Otherwise, I think that is_softirq() more close to the meaning of
> in_irq(). They both describe a context where a new interrupt has
> to wait until the handling gets enabled again.

Grrrr, I wonder why I thought that in_irq() covered also the situation
when IRQ was disabled. It was likely my wish because disabled
interrupts are problem for printk() because the console might
cause a softlockup.

in_irq() actually behaves like in_serving_softirq().

I am confused and puzzled now. I wonder what contexts are actually
interesting for developers.  It goes back to the ideas from Sergey
about preemption disabled, ...

/me feels shameful and is going to hide under a stone.

Best Regards,
Petr
