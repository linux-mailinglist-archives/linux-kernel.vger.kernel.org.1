Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6926822D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 02:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgINAgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 20:36:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46579 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgINAg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 20:36:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id b124so11063328pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 17:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOb5/fVBtStcT7CwxGssb2rLXfqX4ouo9PLSR/6SaEc=;
        b=Jm5evZQWG4nclhVFDZFLlEQ5GpgtrCdIs4xyJvS1wobhq9295Mg3HwuaV5BSVvWWVz
         VfmsLa/ShQIKKME1NsLYGkCQ5h2Dy4h7a/7iMivS+ti+UUbwg2v1yepk5mGI71dUgUSs
         0qI6LXkOdk5iH6LjDB4wjxBnpTH3sqWA2lmkYIvy8vWIV/MkUQJJVN/ERT0HtBrdVfp2
         6OexG0mfu0P0bMB9eFzHw7x1yPUN9ZhrJ5EAlO+U1YwgWpbnErmkZZa0jHzoW223yp7Q
         b2iXFHvraZ+7lMS9uJhBJNDvDIG2WXRkRhoQ3FWDaJqcrWAABMb6rg/2gp1gLyHMKW7B
         kTyw==
X-Gm-Message-State: AOAM531Eu9b7Y3rVLZyQiLwI5yGeex1CdyYgxXMvIpDmruT86tTEpEHN
        iSxPvNqotNjteRVP24J2eQVOtk1zH0UJ2A==
X-Google-Smtp-Source: ABdhPJwsORdL0ffWEgS4xiLqVeaWlOhBTdFYd9LQqD047kWn2orvZaMwrSRDx56o4LYorDQa4QbKpg==
X-Received: by 2002:aa7:9a42:: with SMTP id x2mr11398442pfj.5.1600043787673;
        Sun, 13 Sep 2020 17:36:27 -0700 (PDT)
Received: from sultan-book.localdomain ([104.200.129.212])
        by smtp.gmail.com with ESMTPSA id q18sm8401451pfg.158.2020.09.13.17.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 17:36:27 -0700 (PDT)
Date:   Sun, 13 Sep 2020 17:36:24 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking/mutex: Don't hog RCU read lock while
 optimistically spinning
Message-ID: <20200914003624.GA3944@sultan-book.localdomain>
References: <20200807191636.75045-1-sultan@kerneltoast.com>
 <20200907162031.GA13172@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907162031.GA13172@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 05:20:31PM +0100, Will Deacon wrote:
> On Fri, Aug 07, 2020 at 12:16:35PM -0700, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > 
> > There's no reason to hold an RCU read lock the entire time while
> > optimistically spinning for a mutex lock. This can needlessly lengthen
> > RCU grace periods and slow down synchronize_rcu() when it doesn't brute
> > force the RCU grace period via rcupdate.rcu_expedited=1.
> 
> Would be good to demonstrate this with numbers if you can.

I could simulate the worst possible case, which would stall synchronize_rcu() by
one jiffy, which could be 10ms with CONFIG_HZ=100. The way that would happen is
when the mutex owner does a lot of non-sleeping work while the lock is held, and
while another CPU tries to acquire the lock.

This is a dummy example of the scenario I have in mind:
      CPU0                         CPU1
----------------------------------------------
mutex_lock(locky)
mdelay(100)                  mutex_lock(locky)
mutex_unlock(locky)

In this case, CPU1 could spin in mutex_lock() for up to a jiffy (until CPU0
releases locky, which won't happen for 100ms, or until CPU1's task needs to
reschedule). While the spinning occurs, the RCU read lock will be held the whole
time, and then synchronize_rcu() will be stalled.

One could argue that most mutex-locked critical sections probably wouldn't spend
so long working on something without scheduling (at least, not intentionally),
but on slower SMP CPUs I suspect that this is common.

> > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > ---
> >  kernel/locking/mutex.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index 5352ce50a97e..cc5676712458 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -552,21 +552,31 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
> >  {
> >  	bool ret = true;
> >  
> > -	rcu_read_lock();
> > -	while (__mutex_owner(lock) == owner) {
> > +	for (;;) {
> > +		unsigned int cpu;
> > +		bool same_owner;
> > +
> >  		/*
> > -		 * Ensure we emit the owner->on_cpu, dereference _after_
> > -		 * checking lock->owner still matches owner. If that fails,
> > +		 * Ensure lock->owner still matches owner. If that fails,
> >  		 * owner might point to freed memory. If it still matches,
> >  		 * the rcu_read_lock() ensures the memory stays valid.
> >  		 */
> > -		barrier();
> > +		rcu_read_lock();
> > +		same_owner = __mutex_owner(lock) == owner;
> > +		if (same_owner) {
> > +			ret = owner->on_cpu;
> > +			if (ret)
> > +				cpu = task_cpu(owner);
> > +		}
> > +		rcu_read_unlock();
> 
> Are you sure this doesn't break the ww mutex spinning? That thing also goes
> and looks at the owner, but now it's called outside of the read-side
> critical section.

Yes, it's safe because it's not dereferencing the owner pointer.

Sultan
