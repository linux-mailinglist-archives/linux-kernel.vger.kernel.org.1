Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC72A5C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgKDCBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:01:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9210 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgKDCBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:01:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa20b7a0005>; Tue, 03 Nov 2020 18:01:30 -0800
Received: from [10.2.49.167] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 02:01:31 +0000
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "Hugh Dickins" <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1> <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490> <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490>
 <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
 <20201103065225.GA63301@lx-t490>
 <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
 <20201104013212.GA82153@lx-t490>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <29e4f7f7-5774-7d8f-694b-75eb55ae1b2e@nvidia.com>
Date:   Tue, 3 Nov 2020 18:01:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201104013212.GA82153@lx-t490>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604455291; bh=kMd6aQOzio5Y01MbaLhJ6yY7S3LzPg63xSqyrm2oahE=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=cy8KrwAyX0h+xdvt9QywjQ0ycXIBl+sehFFOMkgiSB6adkjBTIrL10j9HJU3PEur7
         u5+4AJ/ZIiS/AlGDbea4yL5uaK6+RLgJwbqy5Zl6SMpR/y1MTBFf2Qo+PgpArNYbgd
         yogT4LoVexOhqEmBbEsytM4zrc9Mygzux/CrKMUuCaSQ+jyncldwLFMW4c+VoEW5Mi
         7oCrOGKbcFTFfoHs/mV7SWgOh2TffbMjxAsS+vGqd9IA6fNSJSIM2qDusv+9OQzWiC
         qI4NyyfUflD1hGCPugFKN6/8FsnJdeB6jk813BT7Q+pZGIOvPf313NsN2CMk6oeaHo
         CNRhnmyWbQhiw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 5:32 PM, Ahmed S. Darwish wrote:
> On Tue, Nov 03, 2020 at 09:40:22AM -0800, Linus Torvalds wrote:
>> On Mon, Nov 2, 2020 at 10:52 PM Ahmed S. Darwish
>> <a.darwish@linutronix.de> wrote:
...
> 
> ====>
> ====> patch #1:
> ====>
> 
> Subject: [RFC][PATCH 1/2] seqlock: Use __do_ prefix instead of non-standed
>   _seqcount_t_ marker
> 
> The use of "*_seqcount_t_*" as a marker to denote internal seqlock.h
> functions taking only plain seqcount_t instead of the whole
> seqcount_LOCKNAME_t family is confusing users, as it's also not the
> standard kernel pattern for denoting header file internal functions.
> 
> Use the __do_ prefix instead.
> 
> Note, a plain "__" prefix is not used since seqlock.h already uses it
> for some of its exported functions; e.g. __read_seqcount_begin() and
> __read_seqcount_retry().
> 
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Reported-by: John Hubbard <jhubbard@nvidia.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lkml.kernel.org/r/CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> ---
>   include/linux/seqlock.h | 62 ++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index cbfc78b92b65..5de043841d33 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -425,9 +425,9 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
>    * Return: true if a read section retry is required, else false
>    */
>   #define __read_seqcount_retry(s, start)					\
> -	__read_seqcount_t_retry(__seqcount_ptr(s), start)
> +	__do___read_seqcount_retry(__seqcount_ptr(s), start)

Looking better. "do_" is clearly an internal function name prefix, so that's good.

A nit: while various numbers of leading underscores are sometimes used, it's a lot
less common to use, say, 3 consecutive underscores (as above) *within* the name. And
I don't think you need it for uniqueness, at least from a quick look around here.

In fact, if you actually need 3 vs 2 vs 1 underscore within the name, I'm going to
claim that that's too far afield, and the naming should be re-revisited. :)

So why not just:

     __do_read_seqcount_retry()

?

...or, if you feeling bold:

	do_read_seqcount_retry()

...thus taking further advantage of the "do" convention, in order to get rid of some
more underscores.

And similarly for other __do___*() functions.

But again, either way, I think "do" is helping a *lot* here (as is getting rid
of the _t_ idea).


thanks,
-- 
John Hubbard
NVIDIA

> 
> -static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
> +static inline int __do___read_seqcount_retry(const seqcount_t *s, unsigned start)
>   {
>   	kcsan_atomic_next(0);
>   	return unlikely(READ_ONCE(s->sequence) != start);
> @@ -445,12 +445,12 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
>    * Return: true if a read section retry is required, else false
>    */
>   #define read_seqcount_retry(s, start)					\
> -	read_seqcount_t_retry(__seqcount_ptr(s), start)
> +	__do_read_seqcount_retry(__seqcount_ptr(s), start)
> 
> -static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
> +static inline int __do_read_seqcount_retry(const seqcount_t *s, unsigned start)
>   {
>   	smp_rmb();
> -	return __read_seqcount_t_retry(s, start);
> +	return __do___read_seqcount_retry(s, start);
>   }
> 
>   /**
> @@ -462,10 +462,10 @@ do {									\
>   	if (__seqcount_lock_preemptible(s))				\
>   		preempt_disable();					\
>   									\
> -	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
> +	__do_raw_write_seqcount_begin(__seqcount_ptr(s));		\
>   } while (0)
> 
> -static inline void raw_write_seqcount_t_begin(seqcount_t *s)
> +static inline void __do_raw_write_seqcount_begin(seqcount_t *s)
>   {
>   	kcsan_nestable_atomic_begin();
>   	s->sequence++;
> @@ -478,13 +478,13 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
>    */
>   #define raw_write_seqcount_end(s)					\
>   do {									\
> -	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
> +	__do_raw_write_seqcount_end(__seqcount_ptr(s));			\
>   									\
>   	if (__seqcount_lock_preemptible(s))				\
>   		preempt_enable();					\
>   } while (0)
> 
> -static inline void raw_write_seqcount_t_end(seqcount_t *s)
> +static inline void __do_raw_write_seqcount_end(seqcount_t *s)
>   {
>   	smp_wmb();
>   	s->sequence++;
> @@ -506,12 +506,12 @@ do {									\
>   	if (__seqcount_lock_preemptible(s))				\
>   		preempt_disable();					\
>   									\
> -	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
> +	__do_write_seqcount_begin_nested(__seqcount_ptr(s), subclass);	\
>   } while (0)
> 
> -static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
> +static inline void __do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
>   {
> -	raw_write_seqcount_t_begin(s);
> +	__do_raw_write_seqcount_begin(s);
>   	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
>   }
> 
> @@ -533,12 +533,12 @@ do {									\
>   	if (__seqcount_lock_preemptible(s))				\
>   		preempt_disable();					\
>   									\
> -	write_seqcount_t_begin(__seqcount_ptr(s));			\
> +	__do_write_seqcount_begin(__seqcount_ptr(s));			\
>   } while (0)
> 
> -static inline void write_seqcount_t_begin(seqcount_t *s)
> +static inline void __do_write_seqcount_begin(seqcount_t *s)
>   {
> -	write_seqcount_t_begin_nested(s, 0);
> +	__do_write_seqcount_begin_nested(s, 0);
>   }
> 
>   /**
> @@ -549,16 +549,16 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
>    */
>   #define write_seqcount_end(s)						\
>   do {									\
> -	write_seqcount_t_end(__seqcount_ptr(s));			\
> +	__do_write_seqcount_end(__seqcount_ptr(s));			\
>   									\
>   	if (__seqcount_lock_preemptible(s))				\
>   		preempt_enable();					\
>   } while (0)
> 
> -static inline void write_seqcount_t_end(seqcount_t *s)
> +static inline void __do_write_seqcount_end(seqcount_t *s)
>   {
>   	seqcount_release(&s->dep_map, _RET_IP_);
> -	raw_write_seqcount_t_end(s);
> +	__do_raw_write_seqcount_end(s);
>   }
> 
>   /**
> @@ -603,9 +603,9 @@ static inline void write_seqcount_t_end(seqcount_t *s)
>    *      }
>    */
>   #define raw_write_seqcount_barrier(s)					\
> -	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
> +	__do_raw_write_seqcount_barrier(__seqcount_ptr(s))
> 
> -static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
> +static inline void __do_raw_write_seqcount_barrier(seqcount_t *s)
>   {
>   	kcsan_nestable_atomic_begin();
>   	s->sequence++;
> @@ -623,9 +623,9 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
>    * will complete successfully and see data older than this.
>    */
>   #define write_seqcount_invalidate(s)					\
> -	write_seqcount_t_invalidate(__seqcount_ptr(s))
> +	__do_write_seqcount_invalidate(__seqcount_ptr(s))
> 
> -static inline void write_seqcount_t_invalidate(seqcount_t *s)
> +static inline void __do_write_seqcount_invalidate(seqcount_t *s)
>   {
>   	smp_wmb();
>   	kcsan_nestable_atomic_begin();
> @@ -865,7 +865,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
>   }
> 
>   /*
> - * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
> + * For all seqlock_t write side functions, use __do_write_seqcount_begin()
>    * instead of the generic write_seqcount_begin(). This way, no redundant
>    * lockdep_assert_held() checks are added.
>    */
> @@ -886,7 +886,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
>   static inline void write_seqlock(seqlock_t *sl)
>   {
>   	spin_lock(&sl->lock);
> -	write_seqcount_t_begin(&sl->seqcount.seqcount);
> +	__do_write_seqcount_begin(&sl->seqcount.seqcount);
>   }
> 
>   /**
> @@ -898,7 +898,7 @@ static inline void write_seqlock(seqlock_t *sl)
>    */
>   static inline void write_sequnlock(seqlock_t *sl)
>   {
> -	write_seqcount_t_end(&sl->seqcount.seqcount);
> +	__do_write_seqcount_end(&sl->seqcount.seqcount);
>   	spin_unlock(&sl->lock);
>   }
> 
> @@ -912,7 +912,7 @@ static inline void write_sequnlock(seqlock_t *sl)
>   static inline void write_seqlock_bh(seqlock_t *sl)
>   {
>   	spin_lock_bh(&sl->lock);
> -	write_seqcount_t_begin(&sl->seqcount.seqcount);
> +	__do_write_seqcount_begin(&sl->seqcount.seqcount);
>   }
> 
>   /**
> @@ -925,7 +925,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
>    */
>   static inline void write_sequnlock_bh(seqlock_t *sl)
>   {
> -	write_seqcount_t_end(&sl->seqcount.seqcount);
> +	__do_write_seqcount_end(&sl->seqcount.seqcount);
>   	spin_unlock_bh(&sl->lock);
>   }
> 
> @@ -939,7 +939,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
>   static inline void write_seqlock_irq(seqlock_t *sl)
>   {
>   	spin_lock_irq(&sl->lock);
> -	write_seqcount_t_begin(&sl->seqcount.seqcount);
> +	__do_write_seqcount_begin(&sl->seqcount.seqcount);
>   }
> 
>   /**
> @@ -951,7 +951,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
>    */
>   static inline void write_sequnlock_irq(seqlock_t *sl)
>   {
> -	write_seqcount_t_end(&sl->seqcount.seqcount);
> +	__do_write_seqcount_end(&sl->seqcount.seqcount);
>   	spin_unlock_irq(&sl->lock);
>   }
> 
> @@ -960,7 +960,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
>   	unsigned long flags;
> 
>   	spin_lock_irqsave(&sl->lock, flags);
> -	write_seqcount_t_begin(&sl->seqcount.seqcount);
> +	__do_write_seqcount_begin(&sl->seqcount.seqcount);
>   	return flags;
>   }
> 
> @@ -989,7 +989,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
>   static inline void
>   write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
>   {
> -	write_seqcount_t_end(&sl->seqcount.seqcount);
> +	__do_write_seqcount_end(&sl->seqcount.seqcount);
>   	spin_unlock_irqrestore(&sl->lock, flags);
>   }
> 
> ====>
> ====> patch #2:
> ====>
> 
> Subject: [PATCH 2/2] seqlock: seqcount_LOCKAME_t: Use more verbose macro names
> 
> As evidenced by multiple discussions over LKML so far, it's not clear
> that __seqcount_lock_preemptible() is always false for plain seqcount_t.
> For that data type, the _Generic() selection resolves to
> __seqprop_preemptible(), which just returns false.
> 
> Use __seqcount_associated_lock_exists_and_is_preemptible() instead,
> which hints that "preemptibility" is for the associated write
> serialization lock (if any), not for the seqcount itself.
> 
> Similarly, rename __seqcount_assert_lock_held() to
> __seqcount_assert_associated_lock_held().
> 
> Link: https://lkml.kernel.org/r/CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com
> Link: https://lkml.kernel.org/r/20201030235121.GQ2620339@nvidia.com
> Link: https://lkml.kernel.org/r/20201103170327.GJ20600@xz-x1
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> ---
>   include/linux/seqlock.h | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5de043841d33..eb1e5a822e44 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -307,10 +307,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
>   	__seqprop_case((s),	mutex,		prop),			\
>   	__seqprop_case((s),	ww_mutex,	prop))
> 
> -#define __seqcount_ptr(s)		__seqprop(s, ptr)
> -#define __seqcount_sequence(s)		__seqprop(s, sequence)
> -#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
> -#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
> +#define __seqcount_ptr(s)					__seqprop(s, ptr)
> +#define __seqcount_sequence(s)					__seqprop(s, sequence)
> +#define __seqcount_associated_lock_exists_and_is_preemptible(s)	__seqprop(s, preemptible)
> +#define __seqcount_assert_associated_lock_held(s)		__seqprop(s, assert)
> 
>   /**
>    * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
> @@ -459,7 +459,7 @@ static inline int __do_read_seqcount_retry(const seqcount_t *s, unsigned start)
>    */
>   #define raw_write_seqcount_begin(s)					\
>   do {									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seqcount_associated_lock_exists_and_is_preemptible(s))	\
>   		preempt_disable();					\
>   									\
>   	__do_raw_write_seqcount_begin(__seqcount_ptr(s));		\
> @@ -480,7 +480,7 @@ static inline void __do_raw_write_seqcount_begin(seqcount_t *s)
>   do {									\
>   	__do_raw_write_seqcount_end(__seqcount_ptr(s));			\
>   									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seqcount_associated_lock_exists_and_is_preemptible(s))	\
>   		preempt_enable();					\
>   } while (0)
> 
> @@ -501,9 +501,9 @@ static inline void __do_raw_write_seqcount_end(seqcount_t *s)
>    */
>   #define write_seqcount_begin_nested(s, subclass)			\
>   do {									\
> -	__seqcount_assert_lock_held(s);					\
> +	__seqcount_assert_associated_lock_held(s);			\
>   									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seqcount_associated_lock_exists_and_is_preemptible(s))	\
>   		preempt_disable();					\
>   									\
>   	__do_write_seqcount_begin_nested(__seqcount_ptr(s), subclass);	\
> @@ -528,9 +528,9 @@ static inline void __do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
>    */
>   #define write_seqcount_begin(s)						\
>   do {									\
> -	__seqcount_assert_lock_held(s);					\
> +	__seqcount_assert_associated_lock_held(s);			\
>   									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seqcount_associated_lock_exists_and_is_preemptible(s))	\
>   		preempt_disable();					\
>   									\
>   	__do_write_seqcount_begin(__seqcount_ptr(s));			\
> @@ -551,7 +551,7 @@ static inline void __do_write_seqcount_begin(seqcount_t *s)
>   do {									\
>   	__do_write_seqcount_end(__seqcount_ptr(s));			\
>   									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seqcount_associated_lock_exists_and_is_preemptible(s))	\
>   		preempt_enable();					\
>   } while (0)
> 
>>                     Linus
> 
> Thanks,
> 
> --
> Ahmed S. Darwish
> Linutronix GmbH
> 
