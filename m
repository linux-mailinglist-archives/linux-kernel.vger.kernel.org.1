Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE12F2A35ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKBVXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:23:39 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:39096 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBVXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:23:39 -0500
Received: from comp-core-i7-2640m-0182e6 (ip-89-103-122-167.net.upcbroadband.cz [89.103.122.167])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id B766F209AF;
        Mon,  2 Nov 2020 21:23:36 +0000 (UTC)
Date:   Mon, 2 Nov 2020 22:23:32 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH v1 1/4] Increase size of ucounts to atomic_long_t
Message-ID: <20201102212332.zsdi2xcx6vxdh5ui@comp-core-i7-2640m-0182e6>
References: <cover.1604335819.git.gladkov.alexey@gmail.com>
 <f3c95ffedbab07f05e0e6e4e5a8bdd6c358194e7.1604335819.git.gladkov.alexey@gmail.com>
 <20201102180301.dup2cmbqdyrexp22@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102180301.dup2cmbqdyrexp22@wittgenstein>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Mon, 02 Nov 2020 21:23:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 07:03:01PM +0100, Christian Brauner wrote:
> On Mon, Nov 02, 2020 at 05:50:30PM +0100, Alexey Gladkov wrote:
> > In order to be able to use ucounts for rlimits, the size must be increased.
> > For example user_struct.mq_bytes (RLIMIT_MSGQUEUE) is unsigned long.
> 
> I don't have any issues with this change I just wonder what the exact
> reason is. It's not immediately obvious to me.

Right now user_struct.mq_bytes that is currently used for checking
RLIMIT_MSGQUEUE is unsigned log, but ucounts is signed int. The rlimit is
also unsigned long. If I migrate RLIMIT_MSGQUEUE to ucounts I will
decrease counter and possibly break backward compatibility. Technically,
it can be violated anyway.

linux/ipc/mqueue.c:376:

	mq_bytes += mq_treesize;
	spin_lock(&mq_lock);
	if (u->mq_bytes + mq_bytes < u->mq_bytes ||
	    u->mq_bytes + mq_bytes > rlimit(RLIMIT_MSGQUEUE)) {
		spin_unlock(&mq_lock);
		/* mqueue_evict_inode() releases info->messages */
		ret = -EMFILE;
		goto out_inode;
	}
	u->mq_bytes += mq_bytes;
	spin_unlock(&mq_lock);

> > 
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  include/linux/user_namespace.h |  4 ++--
> >  kernel/ucount.c                | 14 +++++++-------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > index 6ef1c7109fc4..fc75af812d73 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -86,7 +86,7 @@ struct user_namespace {
> >  	struct ctl_table_header *sysctls;
> >  #endif
> >  	struct ucounts		*ucounts;
> > -	int ucount_max[UCOUNT_COUNTS];
> > +	long ucount_max[UCOUNT_COUNTS];
> >  } __randomize_layout;
> >  
> >  struct ucounts {
> > @@ -94,7 +94,7 @@ struct ucounts {
> >  	struct user_namespace *ns;
> >  	kuid_t uid;
> >  	int count;
> > -	atomic_t ucount[UCOUNT_COUNTS];
> > +	atomic_long_t ucount[UCOUNT_COUNTS];
> >  };
> >  
> >  extern struct user_namespace init_user_ns;
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 11b1596e2542..7b2bca8582ef 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -175,14 +175,14 @@ static void put_ucounts(struct ucounts *ucounts)
> >  	kfree(ucounts);
> >  }
> >  
> > -static inline bool atomic_inc_below(atomic_t *v, int u)
> > +static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
> >  {
> > -	int c, old;
> > -	c = atomic_read(v);
> > +	long c, old;
> > +	c = atomic_long_read(v);
> >  	for (;;) {
> >  		if (unlikely(c >= u))
> >  			return false;
> > -		old = atomic_cmpxchg(v, c, c+1);
> > +		old = atomic_long_cmpxchg(v, c, c+1);
> >  		if (likely(old == c))
> >  			return true;
> >  		c = old;
> > @@ -199,14 +199,14 @@ struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
> >  		int max;
> >  		tns = iter->ns;
> >  		max = READ_ONCE(tns->ucount_max[type]);
> > -		if (!atomic_inc_below(&iter->ucount[type], max))
> > +		if (!atomic_long_inc_below(&iter->ucount[type], max))
> >  			goto fail;
> >  	}
> >  	return ucounts;
> >  fail:
> >  	bad = iter;
> >  	for (iter = ucounts; iter != bad; iter = iter->ns->ucounts)
> > -		atomic_dec(&iter->ucount[type]);
> > +		atomic_long_dec(&iter->ucount[type]);
> >  
> >  	put_ucounts(ucounts);
> >  	return NULL;
> > @@ -216,7 +216,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
> >  {
> >  	struct ucounts *iter;
> >  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> > -		int dec = atomic_dec_if_positive(&iter->ucount[type]);
> > +		int dec = atomic_long_dec_if_positive(&iter->ucount[type]);
> >  		WARN_ON_ONCE(dec < 0);
> >  	}
> >  	put_ucounts(ucounts);
> > -- 
> > 2.25.4
> > 
> 

-- 
Rgrds, legion

