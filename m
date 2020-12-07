Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431892D190B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgLGTEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbgLGTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607367759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjB17pjd2723LqhuIlVK0z7MCUqX+HkOOB14OY2CKoY=;
        b=YA6DazpRSo6Ux63JVMwcDmyaCT/prPUYQHf4mJdoRqljLSmJGgwVNPWJTpowBIsRlvuuvW
        aMl9pGNIBvWifFDUlBsT7tRfgnqEV8R4tU/YMKQ1vEWx1Fpiz8Souq0XVh8GVMoitS0Qvh
        PRbyngNdlVQ9Qu+ie5MOCAzg6aJEflc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-XNRdJasSOM2Qx4iI42Hb-w-1; Mon, 07 Dec 2020 14:02:35 -0500
X-MC-Unique: XNRdJasSOM2Qx4iI42Hb-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC4F80400B;
        Mon,  7 Dec 2020 19:02:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-86.rdu2.redhat.com [10.10.118.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0024D60C05;
        Mon,  7 Dec 2020 19:02:25 +0000 (UTC)
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
 <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
Date:   Mon, 7 Dec 2020 14:02:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/20 11:58 AM, David Laight wrote:
> From: Waiman Long
>> Sent: 07 December 2020 15:34
>>
>> On 12/7/20 4:02 AM, Peter Zijlstra wrote:
>>> On Thu, Dec 03, 2020 at 08:59:13PM -0500, Waiman Long wrote:
>>>> On 12/3/20 3:11 PM, Eric W. Biederman wrote:
>>>>> +static inline int __down_read_interruptible(struct rw_semaphore *sem)
>>>>> +{
>>>>> +	if (!rwsem_read_trylock(sem)) {
>>>>> +		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
>>>>> +			return -EINTR;
>>>>> +		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>>>>> +	} else {
>>>>> +		rwsem_set_reader_owned(sem);
>>>>> +	}
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>     static inline int __down_read_killable(struct rw_semaphore *sem)
>>>>>     {
>>>>>     	if (!rwsem_read_trylock(sem)) {
>>>>> @@ -1495,6 +1507,20 @@ void __sched down_read(struct rw_semaphore *sem)
>>>>>     }
>>>>>     EXPORT_SYMBOL(down_read);
>>>>> +int __sched down_read_interruptible(struct rw_semaphore *sem)
>>>>> +{
>>>>> +	might_sleep();
>>>>> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
>>>>> +
>>>>> +	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
>>>>> +		rwsem_release(&sem->dep_map, _RET_IP_);
>>>>> +		return -EINTR;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL(down_read_interruptible);
>>>>> +
>>>>>     int __sched down_read_killable(struct rw_semaphore *sem)
>>>>>     {
>>>>>     	might_sleep();
>>>> Acked-by: Waiman Long <longman@redhat.com>
>>> Yeah, that seems correct.. There's an unfortunate amount of copy-paste
>>> there though.
>>>
>>> Do we want to follow that up with something like this?
>> I am actually thinking about similar streamlining once the patch lands.
>>
>> Your suggested changes look fine to me.
> How much more difficult would it be to also add a timeout option?
> I looked at adding one to the mutex code - and fell into a big pile
> of replicated code.
>
> ISTM that one the initial locked exchange (and spin) fails a few
> extra instructions when heading for the sleep don't really matter
>
Actually, I had tried that before. See

https://lore.kernel.org/lkml/20190911150537.19527-1-longman@redhat.com/

That is for rwsem, but the same can be done for mutex. However, Peter 
didn't seem to like the idea of a timeout parameter. Anyway, it is 
certainly doable if there is a good use case for it.

Cheers,
Longman

