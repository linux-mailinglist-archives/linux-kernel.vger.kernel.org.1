Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360E522240A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgGPNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgGPNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:36:50 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84402C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:36:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p7so2688201qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6aq1gxLlCQK8XhsdwZ3YqrWIC5XXHCM06bHTQ9xWYQc=;
        b=voqqdiqO2d2c7Lb6zYlFDZcOuUpzAlEMW0o94zl8C+kidNqA1TSDQyciGHybaUX7NB
         dvypIDKKqk6APBuPrfEjnM2ZeUbiAkToqE76Xd/m/KsokB6GVBcoPaKj+RlhJJeth63v
         Go3xiF3ToRSz3qlKoKlu3sBhW2rMlz2M/pBBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6aq1gxLlCQK8XhsdwZ3YqrWIC5XXHCM06bHTQ9xWYQc=;
        b=qQrk2h6WC+IXON9KFTBZV7P+2bP/58veICY0BRoQHU1JEMooc3nmSfvCc3QhFWAAUo
         JCu7fP2q/Awzmm1Q5ahlklFiUJXiuTOZuPMO4xKYz4xFcDkqtfhy6U1QwIuTv5SEzyFm
         m5s73jl3yd368jFxN5ksU62n9MegPTcCLcfABsK3CcDda98ZHL2Te3mnYxlVd8YTp0VN
         RfvqJe9j6aFPRXrnmiAbizpkhAZNMP9oZXZ3eswJyY93JOOxHVbkNZHpXN7MVtfPPwvD
         LieGp7Jv8qmCdfw8O9UQwX1Se6cGTGOI7grECI2I2p6HY3XP3ChVwJ+ACqvqjVfOVyYt
         Xw7w==
X-Gm-Message-State: AOAM531qGctspkeC9xn4vdRK9vFlMb0Rj37djiK3P7RGdrPNx5pl6EVH
        Ele6fsVmB4PTtnRh0MK3ai42cQ==
X-Google-Smtp-Source: ABdhPJyvmYE8tl+5jdGs3PA4YDZHp+glxE8uFXeEo/ltW9QL85Nyr6Lvai+kPlsNjjTSjr4iipqBYg==
X-Received: by 2002:a0c:e80c:: with SMTP id y12mr4338586qvn.146.1594906609571;
        Thu, 16 Jul 2020 06:36:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x13sm7378525qts.57.2020.07.16.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:36:48 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:36:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716133647.GA242690@google.com>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716091913.GA28595@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:19:13AM +0200, Uladzislau Rezki wrote:
> On Wed, Jul 15, 2020 at 07:13:33PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 15, 2020 at 2:56 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > > > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > >                       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > >                               return false;
> > > >
> > > > +                     preempt_disable();
> > > > +                     krc_this_cpu_unlock(*krcp, *flags);
> > >
> > > Now you enter memory allocator with disabled preemption. This isn't any
> > > better but we don't have a warning for this yet.
> > > What happened to the part where I asked for a spinlock_t?
> > 
> > Ulad,
> > Wouldn't the replacing of preempt_disable() with migrate_disable()
> > above resolve Sebastian's issue?
> >
> This for regular kernel only. That means that migrate_disable() is
> equal to preempt_disable(). So, no difference.

But this will force preempt_disable() context into the low-level page
allocator on -RT kernels which I believe is not what Sebastian wants. The
whole reason why the spinlock vs raw-spinlock ordering matters is, because on
RT, the spinlock is sleeping. So if you have:

raw_spin_lock(..);
spin_lock(..);   <-- can sleep on RT, so Sleep while atomic (SWA) violation.

That's the main reason you are dropping the lock before calling the
allocator.

But if you call preempt_disable() and drop the lock, then that may fix the
lock ordering violation only to reintroduce the SWA issue, which is why you
wanted to drop the lock in the first place.

migrate_disable() on -RT kernels will not disable preemption which is where
Sebastian is coming from I think:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/tree/kernel/sched/core.c?h=v5.4-rt#n8178

In your defense, the "don't disable preemption on migrate_disable()" on -RT
part is not upstream yet. So maybe this will not work on upstream PREEMPT_RT,
but I'm not sure whether folks are really running upstream PREEMPT_RT without
going through the RT tree.

I did not see the drawback of just keeping it as migrate_disable() which
should make everyone happy but Sebastian may have other opinions such as
maybe that converting the lock to normal spinlock makes the code work on
upstream's version of PREEMPT_RT without requiring the migrate_disable()
change. But he can elaborate more.

Paul, how does all this sound to you?

thanks,

 - Joel

