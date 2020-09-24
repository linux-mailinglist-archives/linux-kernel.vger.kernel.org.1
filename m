Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C9B2771C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIXNG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:06:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:33544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbgIXNG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:06:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600952786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWhiMTbLKygzkeBmeWC4lp5Kk4n1lEhbQG0ng2LQOwg=;
        b=JnQ+jMZI1Zc6Y4y3PEceyIqKyNVXM2TxZpCDIbLQRE/Po5zKgakoC4xUenVAufJ1yItiSA
        HAR4J/iP6F1eBhn/Mt6YLcJ8dDMUhYXORd6P+Vq3SsOpHbQQsWtn6IpYMJ/DuaS/Fko9Rv
        r7D1qzVRqbjoj8wfniprG6vHMKGUx84=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AE7EAF2C;
        Thu, 24 Sep 2020 13:06:26 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:06:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200924130625.GD29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924021756.GD577@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924021756.GD577@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 11:17:56, Sergey Senozhatsky wrote:
> On (20/09/23 15:56), Petr Mladek wrote:
> [..]
> >  	/*
> >  	 * To reduce unnecessarily reopening, first check if the descriptor
> > -	 * state and caller ID are correct.
> > +	 * state and caller infromation are correct.
> >  	 */
> > -	d_state = desc_read(desc_ring, id, &desc, NULL, &cid);
> > -	if (d_state != desc_committed || cid != caller_id)
> > +	d_state = desc_read(desc_ring, id, &desc, NULL, &cal);
> > +	if (d_state != desc_committed ||
> > +	    cal.pid != caller->pid ||
> > +	    cal.cpu_ctx != caller->cpu_ctx) {
> 
> You probably might want to factor out ctx check into a static
> inline helper. Since you use this check in several places, and
> we may check more context fields in the future.

Makes sense.

> [..]
> > +/* Information about the process and context that adds the message */
> > +struct printk_caller {
> > +	pid_t pid;	/* thread id */
> > +	u32 cpu_ctx;	/* processor id and interrupt context */
> > +};
> 
> A question. Suppose we have a task which does
> 
> 	CPU0
> 
> 	pr_err(...);
> 
> 	preempt_disable();
> 	pr_err(...);
> 	preempt_enable();
> 
> 	pr_err(...);
> 
> 	rcu_read_lock();
> 	pr_info(...);
> 	rcu_read_unlock();
> 
> Should we distinguish those as 3 different contexts?
> 
> - normal printk
> - printk under disabled preemption (affects scheduling)
> - printk under RCU read side lock (affects RCU grace periods)

Good question. Well, these contexts could not get detected in
PREEMPT_NONE or PREEMPT_VOLUNTARY. Also I wonder where it would
stop. There are several RCU flavors.

I would not distinguish them unless there is a real demand.

Best Regards,
Petr
