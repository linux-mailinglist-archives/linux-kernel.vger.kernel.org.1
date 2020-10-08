Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91A287B57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgJHSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730626AbgJHSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602180327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2FMA6dYjcqdGcGBKsq85dw0RtnS7nDHyn2Pz4+p0sU=;
        b=FX0/Z1jbftoe+2+9+8/vAp0R+Awm+n5eoekOWD4kCGHIGZQliRE957i9wGioYAY3VBXoV4
        a/lvXC3MB5+okJbky1+ULFD+DAVZLVf4xt2g9wB/3qoQ2proe1G0iRfhELdwLJrRqPvNp9
        CBG/eTW9XAECs4A2hLgdOyEsM56PmL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ZvUmeQQIN1qnAIRfQsn5NA-1; Thu, 08 Oct 2020 14:05:23 -0400
X-MC-Unique: ZvUmeQQIN1qnAIRfQsn5NA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BFF8064AB;
        Thu,  8 Oct 2020 18:05:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9527E5576D;
        Thu,  8 Oct 2020 18:05:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 23D23416C894; Thu,  8 Oct 2020 14:43:51 -0300 (-03)
Date:   Thu, 8 Oct 2020 14:43:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008174351.GA14207@fuller.cnet>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008145940.GG6026@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008145940.GG6026@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 10:59:40AM -0400, Peter Xu wrote:
> On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > +{
> > +	int cpu = task_cpu(tsk);
> > +
> > +	/*
> > +	 * If the task concurrently migrates to another cpu,
> > +	 * we guarantee it sees the new tick dependency upon
> > +	 * schedule.
> > +	 *
> > +	 *
> > +	 * set_task_cpu(p, cpu);
> > +	 *   STORE p->cpu = @cpu
> > +	 * __schedule() (switch to task 'p')
> > +	 *   LOCK rq->lock
> > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > +	 */
> > +
> > +	preempt_disable();
> 
> Pure question: is preempt_disable() required here?  Same question to
> tick_nohz_full_kick_all().

Hi Peter,

Don't see why: irq_queue_work_on() disables preemption if necessary.

> 
> > +	if (cpu_online(cpu))
> > +		tick_nohz_full_kick_cpu(cpu);
> > +	preempt_enable();
> > +}
> 
> -- 
> Peter Xu

