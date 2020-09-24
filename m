Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1432427721D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgIXN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:26:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgIXN0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:26:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600953992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/o8HUIGyiR7bXTTAsdidVaiFgkeoZ4tJxmxbiSYuUYI=;
        b=sAKDQ8F0bS5bpqu27PZIl/5KpAF0uyLBWULia75Tunf624OzkGPrMAleSkkvRVM5HpoZzT
        PVqtx7uuAvjIkb4h214/16kEXJ6h79nmcXWZV3rLq0f7DAxR0jWI6y5SB5+ADPLxoGjAsU
        dVyTMtOSnQQWVPQ+UCMyWJq7W0QB3n0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64165AC83;
        Thu, 24 Sep 2020 13:26:32 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:26:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200924132630.GE29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924021756.GD577@jagdpanzerIV.localdomain>
 <87k0wj7fcs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0wj7fcs.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 10:29:31, John Ogness wrote:
> On 2020-09-24, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > A question. Suppose we have a task which does
> >
> > 	CPU0
> >
> > 	pr_err(...);
> >
> > 	preempt_disable();
> > 	pr_err(...);
> > 	preempt_enable();
> >
> > 	pr_err(...);
> >
> > 	rcu_read_lock();
> > 	pr_info(...);
> > 	rcu_read_unlock();
> >
> > Should we distinguish those as 3 different contexts?
> >
> > - normal printk
> > - printk under disabled preemption (affects scheduling)
> > - printk under RCU read side lock (affects RCU grace periods)
> 
> The internal purpose of the printk_info's @caller_id is to support
> _some_ sanity with LOG_CONT. True LOG_CONT sanity will not be available
> until we provide a context API like we previously talked about [0]. But
> for now it is good enough (even if it is not good).
> 
> We can also store various flags and counters to describe the current
> context. But these would only exist to provide the user with information
> rather than because printk itself needs it. I only mention this so that
> we don't get things mixed up. We can add as much information as want,
> but LOG_CONT will only be interested in a subset of that.

Yeah, we need to keep this in mind, so that some "tiny" changes in the
context would not prevent concatenating related pieces of the message.

Best Regards,
Petr
