Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A248A2AD5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgKJLyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:54:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C61C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UAajrM677dL7eVoyW0QPGvN9cZSwD9azwJnK/fLbYZM=; b=n21kT9raBuM+RKEWUQjaQXR8kX
        O91WZ/RMy7EYuT8uKrhCqZvoZXhmO1TI/HWWybG3MhqfFETVI3t8/nphPW72RqfU2ckFRU8ASoe17
        4iT85WhKwkxpuCnFXgwXOYG4AvEz2dQwZ6OIjwocr0EmU84ePBe67DCD90mfaQ5lCcLsvjaGOORx2
        jOi3bBnPHJojGHoRGhCVuAAu55ilyF2V0MtM8hGgMNyBe8VBvNvAA/lzeOsRC8yLyPoQjAXIct299
        aJUu+nwTq40ThD8SgLuRUaxs+YqUAz9715bXWqwmSblzqL9fG9PCOFcCsdrt1YoKXruzbHrMCeYsx
        5mWLsi2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcSDp-00008I-IR; Tue, 10 Nov 2020 11:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A10C301E02;
        Tue, 10 Nov 2020 12:53:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E97F12342E3E9; Tue, 10 Nov 2020 12:53:58 +0100 (CET)
Date:   Tue, 10 Nov 2020 12:53:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201110115358.GE2594@hirez.programming.kicks-ass.net>
References: <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490>
 <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490>
 <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
 <20201103065225.GA63301@lx-t490>
 <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
 <20201104013212.GA82153@lx-t490>
 <29e4f7f7-5774-7d8f-694b-75eb55ae1b2e@nvidia.com>
 <20201104031711.GA227990@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104031711.GA227990@lx-t490>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:17:11AM +0100, Ahmed S. Darwish wrote:
> On Tue, Nov 03, 2020 at 06:01:30PM -0800, John Hubbard wrote:
> > On 11/3/20 5:32 PM, Ahmed S. Darwish wrote:
> ...
> > >   #define __read_seqcount_retry(s, start)					\
> > > -	__read_seqcount_t_retry(__seqcount_ptr(s), start)
> > > +	__do___read_seqcount_retry(__seqcount_ptr(s), start)
> >
> ...
> > A nit: while various numbers of leading underscores are sometimes used, it's a lot
> > less common to use, say, 3 consecutive underscores (as above) *within* the name. And
> > I don't think you need it for uniqueness, at least from a quick look around here.
> >
> ...
> > But again, either way, I think "do" is helping a *lot* here (as is getting rid
> > of the _t_ idea).
> 
> The three underscores are needed because there's a do_ version for
> read_seqcount_retry(), and another for __read_seqcount_retry().
> 
> Similarly for {__,}read_seqcount_begin(). You want to be very careful
> with this, and never mistaknely mix the two, because it affects some VFS
> hot paths.
> 
> Nonetheless, as you mentioned in the later (dropped) part of your
> message, I think do_ is better than __do_, so the final result will be:
> 
>   do___read_seqcount_retry()
>   do_read_seqcount_retry()
>   do_raw_write_seqcount_begin()
>   do_raw_write_seqcount_end()
>   do_write_seqcount_begin()
>   ...
> 
> and so on.
> 
> I'll wait for some further feedback on the two patches (possibly from
> Linus or PeterZ), then send a mini patch series.

I'm Ok with that. The change I have issues with is:

-#define __seqcount_lock_preemptible(s) __seqprop(s, preemptible)
+#define __seqcount_associated_lock_exists_and_is_preemptible(s)        __seqprop(s, preemptible)

That's just _realllllllly_ long.

Would something like the below make it easier to follow?

seqprop_preemptible() is 'obviously' related to __seqprop_preemptible()
without having to follow through the _Generic token pasting maze.

---
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8d8552474c64..576594add921 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -307,10 +307,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
-#define __seqcount_ptr(s)		__seqprop(s, ptr)
-#define __seqcount_sequence(s)		__seqprop(s, sequence)
-#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
-#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
+#define seqprop_ptr(s)			__seqprop(s, ptr)
+#define seqprop_sequence(s)		__seqprop(s, sequence)
+#define seqprop_preemptible(s)		__seqprop(s, preemptible)
+#define seqprop_assert(s)	__seqprop(s, assert)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -330,7 +330,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 ({									\
 	unsigned __seq;							\
 									\
-	while ((__seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = seqprop_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -359,7 +359,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(__seqcount_ptr(s));		\
+	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -376,7 +376,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned __seq = __seqcount_sequence(s);			\
+	unsigned __seq = seqprop_sequence(s);				\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -425,7 +425,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(__seqcount_ptr(s), start)
+	__read_seqcount_t_retry(seqprop_ptr(s), start)
 
 static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -445,7 +445,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(__seqcount_ptr(s), start)
+	read_seqcount_t_retry(seqprop_ptr(s), start)
 
 static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -459,10 +459,10 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
+	raw_write_seqcount_t_begin(seqprop_ptr(s));			\
 } while (0)
 
 static inline void raw_write_seqcount_t_begin(seqcount_t *s)
@@ -478,9 +478,9 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
+	raw_write_seqcount_t_end(seqprop_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
@@ -501,12 +501,12 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
+	write_seqcount_t_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
 static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
@@ -528,12 +528,12 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
  */
 #define write_seqcount_begin(s)						\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(__seqcount_ptr(s));			\
+	write_seqcount_t_begin(seqprop_ptr(s));				\
 } while (0)
 
 static inline void write_seqcount_t_begin(seqcount_t *s)
@@ -549,9 +549,9 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(__seqcount_ptr(s));			\
+	write_seqcount_t_end(seqprop_ptr(s));				\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
@@ -603,7 +603,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
+	raw_write_seqcount_t_barrier(seqprop_ptr(s))
 
 static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
@@ -623,7 +623,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(__seqcount_ptr(s))
+	write_seqcount_t_invalidate(seqprop_ptr(s))
 
 static inline void write_seqcount_t_invalidate(seqcount_t *s)
 {

