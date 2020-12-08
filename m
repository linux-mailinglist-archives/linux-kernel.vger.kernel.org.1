Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63E2D2E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgLHPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbgLHPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607441384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miua5ROGrphgyENa3zVBXUwOoAslKJxQNqStT5/JBjw=;
        b=aeSNODpx+XpA58Q7nHxCpu+D/zNUEmqUyZY5+/9dZrCkFK0ftRTWkouRc7As4As8msbv7u
        1H6TJa5t0BbqCjJrt92G5QIxk6sAPJN6gIkbcbWBFRf0VVuhQRCUwZ1oBMr3S5TBu2NsuU
        78TXZ2RfGLZUFw0HDp12CzlqQAtFYeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-07-LZiWuNQKcBiRkqqRf3Q-1; Tue, 08 Dec 2020 10:29:41 -0500
X-MC-Unique: 07-LZiWuNQKcBiRkqqRf3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90080858187;
        Tue,  8 Dec 2020 15:29:40 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-227.rdu2.redhat.com [10.10.119.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D57F260BE2;
        Tue,  8 Dec 2020 15:29:39 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] locking/rwsem: Remove reader optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
 <20201121041416.12285-6-longman@redhat.com>
 <20201208100704.GU2414@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <234a49df-0f88-2dc1-968c-8bfe52ccf9d4@redhat.com>
Date:   Tue, 8 Dec 2020 10:29:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201208100704.GU2414@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 5:07 AM, Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 11:14:16PM -0500, Waiman Long wrote:
>
>
>> @@ -1032,40 +901,16 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
>>   	 *
>>   	 * We can take the read lock directly without doing
>>   	 * rwsem_optimistic_spin() if the conditions are right.
> This comment no longer makes sense..

You are right. I forgot to take that out.


>> -	 * Also wake up other readers if it is the first reader.
>>   	 */
>> -	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
>> -	    rwsem_no_spinners(sem)) {
>> +	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
>>   		rwsem_set_reader_owned(sem);
>>   		lockevent_inc(rwsem_rlock_steal);
>> -		if (rcnt == 1)
>> -			goto wake_readers;
>> -		return sem;
>> -	}
>>   
>> -	/*
>> -	 * Save the current read-owner of rwsem, if available, and the
>> -	 * reader nonspinnable bit.
>> -	 */
>> -	waiter.last_rowner = owner;
>> -	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
>> -		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
>> -
>> -	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
>> -		goto queue;
>> -
>> -	/*
>> -	 * Undo read bias from down_read() and do optimistic spinning.
>> -	 */
>> -	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
>> -	adjustment = 0;
>> -	if (rwsem_optimistic_spin(sem, false)) {
> since we're removing the optimistic spinning entirely on the read side.
>
> Also, I was looking at skipping patch #4, which mucks with the reader
> wakeup logic, and afaict this removal doesn't really depend on it.
>
> Or am I missing something?

That is true. Patch 4 isn't essential for this series. So if you are 
general OK with the current patchset, I can send out v3 that remove 
patch 4 and make the your suggested change above.

Cheers,
Longman

