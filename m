Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887D02BB16C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgKTR1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:27:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728366AbgKTR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605893223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1il0pTTXODgnXf0mIlJ8WwdYMwDpC7bLSR4f4pLYrJs=;
        b=JII+M5tTzg/g5wnVL/k3Nv+VpRpqV73Fcm8C24PJBp1Nib6P7CyFwbgY+yAVy9lXhg8pUA
        YS2H+D0MxNFqRpxQaPQ76h20cm6yUKKKqCxAdHNpMy34ZT/GSpX2hF4coA8/wZu/MNoPcE
        5Wi+3ZnnmK7Cm9nEIVRK01ZXRm/U2r0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-jYqhytHPNem1avGn2oRcYg-1; Fri, 20 Nov 2020 12:27:01 -0500
X-MC-Unique: jYqhytHPNem1avGn2oRcYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D60601DDE6;
        Fri, 20 Nov 2020 17:26:59 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-157.rdu2.redhat.com [10.10.118.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8BE5D9D0;
        Fri, 20 Nov 2020 17:26:59 +0000 (UTC)
Subject: Re: [PATCH 3/5] locking/rwsem: Enable reader optimistic lock stealing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-4-longman@redhat.com>
 <20201120143624.GD3040@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d913b708-0206-2ba6-347f-ea57c2396a83@redhat.com>
Date:   Fri, 20 Nov 2020 12:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120143624.GD3040@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 9:36 AM, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 10:04:27PM -0500, Waiman Long wrote:
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index ee374ae061c3..930dd4af3639 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -957,6 +957,12 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>>   	}
>>   	return false;
>>   }
>> +
>> +static inline bool osq_is_empty(struct rw_semaphore *sem)
>> +{
>> +	return !osq_is_locked(&sem->osq);
>> +}
>> +
>>   #else
>>   static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
>>   					   unsigned long nonspinnable)
>> @@ -977,6 +983,10 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>>   	return false;
>>   }
>>   
>> +static inline bool osq_is_empty(sem)
>> +{
>> +	return false;
>> +}
> Hurph, the naming seems to suggest this ought to be in osq_lock.h, but
> it really is part of rwsem, it captures the lack of osq member for this
> configuration.
>
> How about: rwsem_no_spinners() instead ?
Yes, sure. Will make the name change.
>
>>   static inline int
>>   rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
>>   {
>> @@ -1007,6 +1017,22 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
>>   	   !(count & RWSEM_WRITER_LOCKED))
>>   		goto queue;
>>   
>> +	/*
>> +	 * Reader optimistic lock stealing
>> +	 *
>> +	 * We can take the read lock directly without doing
>> +	 * rwsem_optimistic_spin() if the conditions are right.
>> +	 * Also wake up other readers if it is the first reader.
>> +	 */
>> +	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
>> +	    osq_is_empty(sem)) {
>> +		rwsem_set_reader_owned(sem);
>> +		lockevent_inc(rwsem_rlock_steal);
>> +		if (rcnt == 1)
>> +			goto wake_readers;
>> +		return sem;
>> +	}
> AFAICT this saves at least 3 atomic ops; how common is this case
> (you did add a counter but forgot to mention this).
>
Right, I should have mentioned the counter results.

Below is the relevant counter stats for a test system that have been up 
for more than 21 hours:

rwsem_opt_rlock=11792583 (optmistically acquired read lock)
rwsem_rlock=193357272 (slowpath acquired read lock)
rwsem_rlock_steal=44795149 (lock stealing)

So lock stealing represents about 17.9% of the total read lock acquired 
in non-fast path. I ran some microbenchmark test on the system before, 
so it may skew a bit to the high side. Anyway, this is not an 
insignificant amount.

Cheers,
Longman


