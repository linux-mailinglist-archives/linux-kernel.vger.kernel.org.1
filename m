Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2C2422D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKXc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 19:32:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgHKXc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597188777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0PZbt2gu9cb6IQ7UVghICiVpHs7kwKAG/AqXZropSQ=;
        b=OqZRqgq68WJnltknCL/pWWYZ2qoCqSqhbS4VLn4QissQg5r8rQYYKrsuqWWVf0L5rh2x/N
        awnmEKB7PiPmTduJf9UYuSKTsifZcbiwFSRerihQ0FdS1lrTVFXnX/yFjxLAiPPLW2yGTb
        t160HrC7qw0V/44cfoMYzYzMKgNtfuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-T2xA4c9cMBuy9e3qmW0d2w-1; Tue, 11 Aug 2020 19:32:55 -0400
X-MC-Unique: T2xA4c9cMBuy9e3qmW0d2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8E691902EA1;
        Tue, 11 Aug 2020 23:32:53 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26FE81001B07;
        Tue, 11 Aug 2020 23:32:53 +0000 (UTC)
Subject: Re: [PATCH v2] sched, mm: Optimize current_gfp_context()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
References: <20200618212936.9776-1-longman@redhat.com>
 <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3b353d6a-8430-b847-6ddd-21189c87ef6b@redhat.com>
Date:   Tue, 11 Aug 2020 19:32:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 6:29 PM, Andrew Morton wrote:
> On Thu, 18 Jun 2020 17:29:36 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> The current_gfp_context() converts a number of PF_MEMALLOC_* per-process
>> flags into the corresponding GFP_* flags for memory allocation. In
>> that function, current->flags is accessed 3 times. That may lead to
>> duplicated access of the same memory location.
>>
>> This is not usually a problem with minimal debug config options on as the
>> compiler can optimize away the duplicated memory accesses.  With most
>> of the debug config options on, however, that may not be the case.
>> For example, the x86-64 object size of the __need_fs_reclaim() in a
>> debug kernel that calls current_gfp_context() was 309 bytes. With this
>> patch applied, the object size is reduced to 202 bytes. This is a saving
>> of 107 bytes and will probably be slightly faster too.
>>
>> ...
>>
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -181,18 +181,20 @@ static inline bool in_vfork(struct task_struct *tsk)
>>    */
>>   static inline gfp_t current_gfp_context(gfp_t flags)
>>   {
>> -	if (unlikely(current->flags &
>> +	unsigned int pflags = READ_ONCE(current->flags);
> Why use READ_ONCE() here?

It was a change suggested by PeterZ. He said without the READ_ONCE(), 
the compiler may still choose to access current->flags multiple times 
instead of just reading it once. I think he is right and so I made the 
change.

Cheers,
Longman

