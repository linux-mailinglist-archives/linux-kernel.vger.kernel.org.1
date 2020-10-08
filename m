Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5957D287C47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgJHTQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgJHTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602184574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jO+xIMtwPVNJyG2G2TH4q9jnVpAPpJAZ8dD3Bvbwv2s=;
        b=QrtSQBSIDnGk4KJsBJX2Xn2ftqZxThrj04fFGEH5F/goNJO351gTsCVZZ2wQvGJGPs0awE
        7A7A5C9Aus/pVYRMsh2IsQrn+5GA4b9hviuN/3mgSoWc1ZrUhLGwWyFDT7Sn1QzP/fOeyk
        tNcFi7VrKu8AwWO1rDIV9lW8yMfC+ws=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-oq9Pko9HOK6UAIwn4Rjjsg-1; Thu, 08 Oct 2020 15:16:10 -0400
X-MC-Unique: oq9Pko9HOK6UAIwn4Rjjsg-1
Received: by mail-qk1-f198.google.com with SMTP id 139so4724814qkl.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jO+xIMtwPVNJyG2G2TH4q9jnVpAPpJAZ8dD3Bvbwv2s=;
        b=ICL3ncOKSXhiU4EeZOkdPk3O1iHC0OvMBdz3gZyqPGNnBLKykn4Xofw8B3stIyw6Bv
         +0hT8XZOVY+dbI6RH+dMATJyT4ZGWdsoMNhgN+ULkSenWpiLQJE/qsp3RZI8LFPaDyko
         waiz/c/VsjPzDiqejeDRT/LRGecRu9dYBTT3PIzlFDVUwKs+6SMYlkHGiNc2NsCVfOyS
         4fFAHS5tPv4M32+wjbHE5y35D7UFQGt2nnXWzIaNzC/1um0jd8tobKGTXwqx3bD7k7IT
         apx3wRNue7kdJBugZy5+qREsdpzS6nOUmfwPKfiLjHVEQ75xYPaReo08L98BcqZJlCb4
         iJ6w==
X-Gm-Message-State: AOAM531VfKK6sI9y309dkDJP7cbD92bevOquLY2Hi42Oi1ppc0wAWo4o
        xmxCmtmyls9i9Ly+xC9gKjbep0c5erjT9tB77kP94ly72zFzRI7MB+CmyZfiWF8wLfLQlb2gE84
        KqJFRyODMtHramxQq+LeGLQR1
X-Received: by 2002:ac8:7557:: with SMTP id b23mr9998546qtr.34.1602184570067;
        Thu, 08 Oct 2020 12:16:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTP4G1+yFLJew/NcCEoXDglFE2p+ol3Cy72Dm94p7vQvsfc1t0kCgm+2OsnLr6ukLbWntk/g==
X-Received: by 2002:ac8:7557:: with SMTP id b23mr9998525qtr.34.1602184569809;
        Thu, 08 Oct 2020 12:16:09 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id d9sm4680344qtg.51.2020.10.08.12.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:16:09 -0700 (PDT)
Date:   Thu, 8 Oct 2020 15:16:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008191607.GC376361@xz-x1>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008145940.GG6026@xz-x1>
 <20201008152844.GB2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008152844.GB2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 05:28:44PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 08, 2020 at 10:59:40AM -0400, Peter Xu wrote:
> > On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > > +{
> > > +	int cpu = task_cpu(tsk);
> > > +
> > > +	/*
> > > +	 * If the task concurrently migrates to another cpu,
> > > +	 * we guarantee it sees the new tick dependency upon
> > > +	 * schedule.
> > > +	 *
> > > +	 *
> > > +	 * set_task_cpu(p, cpu);
> > > +	 *   STORE p->cpu = @cpu
> > > +	 * __schedule() (switch to task 'p')
> > > +	 *   LOCK rq->lock
> > > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > > +	 */
> > > +
> > > +	preempt_disable();
> > 
> > Pure question: is preempt_disable() required here?  Same question to
> > tick_nohz_full_kick_all().
> 
> I think it serializes against hotplug.

Thanks Peter.  So is that a lighter but trickier version of get_online_cpus()
which is even allowed with spinlock?

I noticed that this method was actually mentioned in the old cpu-hotplug.txt,
but it was removed during the convertion to rst:

  ff58fa7f556c ("Documentation: Update CPU hotplug and move it to core-api")

Not sure whether it's intended, just to raise this up.  If it's still valid,
maybe still worth to document it somewhere.

-- 
Peter Xu

