Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90C82D154F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLGP54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:57:56 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50440 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLGP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:57:56 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kmIsy-00EPxe-Ho; Mon, 07 Dec 2020 08:57:12 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kmIsx-0007O9-BU; Mon, 07 Dec 2020 08:57:12 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
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
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
        <87k0tybqfy.fsf@x220.int.ebiederm.org>
        <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
        <20201207090243.GE3040@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 09:56:34 -0600
In-Reply-To: <20201207090243.GE3040@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 7 Dec 2020 10:02:43 +0100")
Message-ID: <87360hy5hp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kmIsx-0007O9-BU;;;mid=<87360hy5hp.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4Dv8ij08d6JmqqyY9GO2q9L+ifSbts+M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 736 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.3%), parse: 1.69 (0.2%),
         extract_message_metadata: 22 (3.0%), get_uri_detail_list: 5 (0.7%),
        tests_pri_-1000: 27 (3.7%), tests_pri_-950: 1.98 (0.3%),
        tests_pri_-900: 1.53 (0.2%), tests_pri_-90: 91 (12.3%), check_bayes:
        89 (12.0%), b_tokenize: 26 (3.5%), b_tok_get_all: 10 (1.3%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 45 (6.1%), b_finish: 1.17
        (0.2%), tests_pri_0: 545 (74.0%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 3.1 (0.4%), poll_dns_idle: 0.84 (0.1%), tests_pri_10:
        3.6 (0.5%), tests_pri_500: 19 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Dec 03, 2020 at 08:59:13PM -0500, Waiman Long wrote:
>> On 12/3/20 3:11 PM, Eric W. Biederman wrote:
>
>> > +static inline int __down_read_interruptible(struct rw_semaphore *sem)
>> > +{
>> > +	if (!rwsem_read_trylock(sem)) {
>> > +		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
>> > +			return -EINTR;
>> > +		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>> > +	} else {
>> > +		rwsem_set_reader_owned(sem);
>> > +	}
>> > +	return 0;
>> > +}
>> > +
>> >   static inline int __down_read_killable(struct rw_semaphore *sem)
>> >   {
>> >   	if (!rwsem_read_trylock(sem)) {
>> > @@ -1495,6 +1507,20 @@ void __sched down_read(struct rw_semaphore *sem)
>> >   }
>> >   EXPORT_SYMBOL(down_read);
>> > +int __sched down_read_interruptible(struct rw_semaphore *sem)
>> > +{
>> > +	might_sleep();
>> > +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
>> > +
>> > +	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
>> > +		rwsem_release(&sem->dep_map, _RET_IP_);
>> > +		return -EINTR;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL(down_read_interruptible);
>> > +
>> >   int __sched down_read_killable(struct rw_semaphore *sem)
>> >   {
>> >   	might_sleep();
>> 
>> Acked-by: Waiman Long <longman@redhat.com>
>
> Yeah, that seems correct.. There's an unfortunate amount of copy-paste
> there though.
>
> Do we want to follow that up with something like this?

Do you want to pull these two into a topic branch in the tip tree
based on v10-rc1?

That way we can share these two patches, and then you folks can make
your locking cleanups and I can change exec_update_mutex to a rw_semaphore?

Eric

> ---
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -275,7 +275,25 @@ static inline bool rwsem_read_trylock(st
>  	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
>  	if (WARN_ON_ONCE(cnt < 0))
>  		rwsem_set_nonspinnable(sem);
> -	return !(cnt & RWSEM_READ_FAILED_MASK);
> +
> +	if (!(cnt & RWSEM_READ_FAILED_MASK)) {
> +		rwsem_set_reader_owned(sem);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp = RWSEM_UNLOCKED_VALUE;
> +
> +	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
> +		rwsem_set_owner(sem);
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  /*
> @@ -1335,38 +1353,29 @@ static struct rw_semaphore *rwsem_downgr
>  /*
>   * lock for reading
>   */
> -static inline void __down_read(struct rw_semaphore *sem)
> +static inline int __down_read_common(struct rw_semaphore *sem, int state)
>  {
>  	if (!rwsem_read_trylock(sem)) {
> -		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
> +		if (IS_ERR(rwsem_down_read_slowpath(sem, state)))
> +			return -EINTR;
>  		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> -	} else {
> -		rwsem_set_reader_owned(sem);
>  	}
> +	return 0;
>  }
>  
> -static inline int __down_read_interruptible(struct rw_semaphore *sem)
> +static __always_inline void __down_read(struct rw_semaphore *sem)
>  {
> -	if (!rwsem_read_trylock(sem)) {
> -		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
> -			return -EINTR;
> -		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> -	} else {
> -		rwsem_set_reader_owned(sem);
> -	}
> -	return 0;
> +	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
>  }
>  
> -static inline int __down_read_killable(struct rw_semaphore *sem)
> +static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
>  {
> -	if (!rwsem_read_trylock(sem)) {
> -		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
> -			return -EINTR;
> -		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> -	} else {
> -		rwsem_set_reader_owned(sem);
> -	}
> -	return 0;
> +	return __down_read_common(sem, TASK_INTERRUPTIBLE);
> +}
> +
> +static __always_inline int __down_read_killable(struct rw_semaphore *sem)
> +{
> +	return __down_read_common(sem, TASK_KILLABLE);
>  }
>  
>  static inline int __down_read_trylock(struct rw_semaphore *sem)
> @@ -1392,44 +1401,29 @@ static inline int __down_read_trylock(st
>  /*
>   * lock for writing
>   */
> -static inline void __down_write(struct rw_semaphore *sem)
> +static inline int __down_write_common(struct rw_semaphore *sem, int state)
>  {
> -	long tmp = RWSEM_UNLOCKED_VALUE;
> -
> -	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> -						      RWSEM_WRITER_LOCKED)))
> -		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
> -	else
> -		rwsem_set_owner(sem);
> +	if (unlikely(!rwsem_write_trylock(sem))) {
> +		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
> +			return -EINTR;
> +	}
> +	return 0;
>  }
>  
> -static inline int __down_write_killable(struct rw_semaphore *sem)
> +static __always_inline void __down_write(struct rw_semaphore *sem)
>  {
> -	long tmp = RWSEM_UNLOCKED_VALUE;
> +	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
> +}
>  
> -	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> -						      RWSEM_WRITER_LOCKED))) {
> -		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
> -			return -EINTR;
> -	} else {
> -		rwsem_set_owner(sem);
> -	}
> -	return 0;
> +static __always_inline int __down_write_killable(struct rw_semaphore *sem)
> +{
> +	return __down_write_common(sem, TASK_KILLABLE);
>  }
>  
>  static inline int __down_write_trylock(struct rw_semaphore *sem)
>  {
> -	long tmp;
> -
>  	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
> -
> -	tmp  = RWSEM_UNLOCKED_VALUE;
> -	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> -					    RWSEM_WRITER_LOCKED)) {
> -		rwsem_set_owner(sem);
> -		return true;
> -	}
> -	return false;
> +	return rwsem_write_trylock(sem);
>  }
>  
>  /*
