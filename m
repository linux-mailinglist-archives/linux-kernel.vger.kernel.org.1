Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE67E277074
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgIXL6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgIXL6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600948695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Km6uDO0nBE/t8y6BQfLYL6pxCXJAmPH7W/8Q5WqG6nk=;
        b=SMvJ2MoJ+vglrNgo1pN+1rBZkwTkNCCmh4mctRrLFwz1Mpz4SM5sLxXfCU2AGoFRKDV65L
        /cMFqrYZB+Zl5F4u+rVmIiDrdGxtIDcHJ04qZXxqxzdu83uiw+prdyOqy6/4F2wp5HXVv/
        deJTrtd++ZCsQSzQ1h+aaGJbSp3w/Yo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CFF0AEC8;
        Thu, 24 Sep 2020 11:58:15 +0000 (UTC)
Date:   Thu, 24 Sep 2020 13:58:14 +0200
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
Message-ID: <20200924115814.GB29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924014010.GB577@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924014010.GB577@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 10:40:10, Sergey Senozhatsky wrote:
> On (20/09/23 15:56), Petr Mladek wrote:
> > The information about the printk caller has been added by the commit
> > 15ff2069cb7f967da ("printk: Add caller information to printk() output.").
> > The main motivation was to reconstruct original messages when they
> > longer output from different CPUs got mixed.
> > 
> > But there are more usecases. The number of CPUs and tasks running on
> > a single system is growing. It brings bigger challenges when debugging
> > problems. The context in which kernel reports its state is sometimes
> > pretty useful.
> > 
> > In particular, people suggest to remember the task id, cpu id, more details
> > about the interrupt context, and even the task name [0][1].
> > 
> > Prepare for extending the caller information by replacing caller_id
> > with struct printk_caller. And always store task id, cpu id, and
> > exact interrupt context.
> 
> Wild idea:
> 
> Currently, we have two sides to the problem, I think. There are tasks
> that store messages, but then there are tasks that print those messages
> on the consoles. And those tasks and contexts are not always the same.
> What I found helpful in the past was not only the caller_id, but the
> emitter_id (especially preemption count and irqs state of the context
> that prints messages on the slow consoles).

Yeah, it might be useful. But it should get discussed in a separate thread.

The information about the emitter do not need to get stored into the
metadata. It is mostly need only for debugging printk-related
problems. It should become less important if we succeed with
introducing the printk kthreads.

Best Regards,
Petr
