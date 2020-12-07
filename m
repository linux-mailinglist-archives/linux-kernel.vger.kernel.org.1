Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A612D0C96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLGJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgLGJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:03:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47D7C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y7X/VOkUREDqJ+oEOnQ8Y30+R63q4j0Vz5MUgoySF08=; b=hTq6ZDv6l5PMJzJNzZMoechW6K
        UtKqAUIeQFtJbJ68ZRWZfGLaNUFDihqlmBR/QBaIgoK+8SfPjD4A3RrtK7l0IRDmfSB7cUmQIb2a2
        GxYVaVwE3D4kfTMr+2ZJ4oZyis/6Z32vOjEGMybT20E6aQyErNX3vnSvpVp0QXTsUnNdiXRNJj6t6
        tpaFfJHnfRZAW5Ez+oL9wU+7zn/sh5h+Trsf596Zjvw/G7mihy8QvJKZmYPXLzqGxAx+z2C64ROoc
        vW1eqAbCsDyg0f+YTSt+scuHSLKUkopIkdBGGlERxqkGXQ3E/OfqinPJvUhvmb7Dx95LX5NR19v6J
        fQWKRtPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmCPu-0005Db-My; Mon, 07 Dec 2020 09:02:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68FB2301478;
        Mon,  7 Dec 2020 10:02:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51A3F213CFB85; Mon,  7 Dec 2020 10:02:43 +0100 (CET)
Date:   Mon, 7 Dec 2020 10:02:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
Message-ID: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 08:59:13PM -0500, Waiman Long wrote:
> On 12/3/20 3:11 PM, Eric W. Biederman wrote:

> > +static inline int __down_read_interruptible(struct rw_semaphore *sem)
> > +{
> > +	if (!rwsem_read_trylock(sem)) {
> > +		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
> > +			return -EINTR;
> > +		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> > +	} else {
> > +		rwsem_set_reader_owned(sem);
> > +	}
> > +	return 0;
> > +}
> > +
> >   static inline int __down_read_killable(struct rw_semaphore *sem)
> >   {
> >   	if (!rwsem_read_trylock(sem)) {
> > @@ -1495,6 +1507,20 @@ void __sched down_read(struct rw_semaphore *sem)
> >   }
> >   EXPORT_SYMBOL(down_read);
> > +int __sched down_read_interruptible(struct rw_semaphore *sem)
> > +{
> > +	might_sleep();
> > +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> > +
> > +	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
> > +		rwsem_release(&sem->dep_map, _RET_IP_);
> > +		return -EINTR;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(down_read_interruptible);
> > +
> >   int __sched down_read_killable(struct rw_semaphore *sem)
> >   {
> >   	might_sleep();
> 
> Acked-by: Waiman Long <longman@redhat.com>

Yeah, that seems correct.. There's an unfortunate amount of copy-paste
there though.

Do we want to follow that up with something like this?

---
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -275,7 +275,25 @@ static inline bool rwsem_read_trylock(st
 	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
 	if (WARN_ON_ONCE(cnt < 0))
 		rwsem_set_nonspinnable(sem);
-	return !(cnt & RWSEM_READ_FAILED_MASK);
+
+	if (!(cnt & RWSEM_READ_FAILED_MASK)) {
+		rwsem_set_reader_owned(sem);
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
+{
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
+		rwsem_set_owner(sem);
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -1335,38 +1353,29 @@ static struct rw_semaphore *rwsem_downgr
 /*
  * lock for reading
  */
-static inline void __down_read(struct rw_semaphore *sem)
+static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	if (!rwsem_read_trylock(sem)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
+		if (IS_ERR(rwsem_down_read_slowpath(sem, state)))
+			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
 	}
+	return 0;
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static __always_inline void __down_read(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
-			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
-	}
-	return 0;
+	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
-			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
-	}
-	return 0;
+	return __down_read_common(sem, TASK_INTERRUPTIBLE);
+}
+
+static __always_inline int __down_read_killable(struct rw_semaphore *sem)
+{
+	return __down_read_common(sem, TASK_KILLABLE);
 }
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
@@ -1392,44 +1401,29 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
-
-	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-						      RWSEM_WRITER_LOCKED)))
-		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
-	else
-		rwsem_set_owner(sem);
+	if (unlikely(!rwsem_write_trylock(sem))) {
+		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
+			return -EINTR;
+	}
+	return 0;
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static __always_inline void __down_write(struct rw_semaphore *sem)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
+	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
+}
 
-	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-						      RWSEM_WRITER_LOCKED))) {
-		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
-			return -EINTR;
-	} else {
-		rwsem_set_owner(sem);
-	}
-	return 0;
+static __always_inline int __down_write_killable(struct rw_semaphore *sem)
+{
+	return __down_write_common(sem, TASK_KILLABLE);
 }
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
-
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
-
-	tmp  = RWSEM_UNLOCKED_VALUE;
-	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					    RWSEM_WRITER_LOCKED)) {
-		rwsem_set_owner(sem);
-		return true;
-	}
-	return false;
+	return rwsem_write_trylock(sem);
 }
 
 /*
