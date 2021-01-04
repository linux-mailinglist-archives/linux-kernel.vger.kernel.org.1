Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE12E9E0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhADTYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbhADTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609788170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5AU8C2ndHXKPm8KZ52wtigPYVZ0w+rsKIi7xnRp8eU=;
        b=IDXBeoAl6QTnH3EoLSUQaZG82J2AJTihgbqF+y9c/gWVQhg54Ca2jHEkId+h9dWriP5vBm
        xroI9DCEAespjU7xOXW2J9KOG54otKAlN1grWHLP/6WgImPr8gkgM27YY+PqaUAcKE0XGO
        rkwZ+tQXBWNwc+ChuGG/54qNXrs/Yts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-2uQJ2cTJMoqwP3MQmFRjaA-1; Mon, 04 Jan 2021 14:22:47 -0500
X-MC-Unique: 2uQJ2cTJMoqwP3MQmFRjaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 830F49CC03;
        Mon,  4 Jan 2021 19:22:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-181.rdu2.redhat.com [10.10.117.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A431A71C8D;
        Mon,  4 Jan 2021 19:22:45 +0000 (UTC)
Subject: Re: [PATCH] locking/lockdep: Use local_irq_save() with call_rcu()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Paul McKenney <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20201222225553.15642-1-longman@redhat.com>
 <20210104153836.GS3021@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cbea5441-c85a-2e96-b0be-f5e5826d2475@redhat.com>
Date:   Mon, 4 Jan 2021 14:22:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210104153836.GS3021@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 10:38 AM, Peter Zijlstra wrote:
> On Tue, Dec 22, 2020 at 05:55:53PM -0500, Waiman Long wrote:
>> The following lockdep splat was hit:
>>
>>   [  560.638354] WARNING: CPU: 79 PID: 27458 at kernel/rcu/tree_plugin.h:1749 call_rcu+0x6dc/0xf00
>>      :
>>   [  560.647761] RIP: 0010:call_rcu+0x6dc/0xf00
>>   [  560.647763] Code: 0f 8f 29 04 00 00 e8 93 da 1c 00 48 8b 3c 24 57 9d 0f 1f 44 00 00 e9 19 fa ff ff 65 8b 05 38 83 c4 49 85 c0 0f 84 cd fb ff ff <0f> 0b e9 c6 fb ff ff e8 b8 45 51 00 4c 89 f2 48 b8 00 00 00 00 00
>>   [  560.647764] RSP: 0018:ff11001050097b58 EFLAGS: 00010002
>>   [  560.647766] RAX: 0000000000000001 RBX: ffffffffbb1f3360 RCX: 0000000000000001
>>   [  560.647766] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb99bac9c
>>   [  560.647767] RBP: 1fe220020a012f73 R08: 000000010004005c R09: dffffc0000000000
>>   [  560.647768] R10: dffffc0000000000 R11: 0000000000000003 R12: ff1100105b7f70e1
>>   [  560.647769] R13: ffffffffb635d8a0 R14: ff1100105b7f72d8 R15: ff1100105b7f7040
>>   [  560.647770] FS:  00007fd9b3437080(0000) GS:ff1100105b600000(0000) knlGS:0000000000000000
>>   [  560.647771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [  560.647772] CR2: 00007fd9b30112bc CR3: 000000105e898006 CR4: 0000000000761ee0
>>   [  560.647773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [  560.647773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [  560.647774] PKRU: 55555554
>>   [  560.647774] Call Trace:
>>   [  560.647778]  ? invoke_rcu_core+0x180/0x180
>>   [  560.647782]  ? __is_module_percpu_address+0xed/0x440
>>   [  560.647787]  lockdep_unregister_key+0x2ab/0x5b0
>>   [  560.647791]  destroy_workqueue+0x40b/0x610
>>   [  560.647862]  xlog_dealloc_log+0x216/0x2b0 [xfs]
>>      :
>>
>> This splat is caused by the fact that lockdep_unregister_key() uses
>> raw_local_irq_save() which doesn't update the hardirqs_enabled
>> percpu flag.  The call_rcu() function, however, will call
>> lockdep_assert_irqs_disabled() to check the hardirqs_enabled flag which
>> remained set in this case.
>>
>> Fix this problem by using local_irq_save()/local_irq_restore() pairs
>> whenever call_rcu() is being called.
> I'm not sure I much like all this,.. :/
>
>> I think raw_local_irq_save() function can be used if no external
>> function is being called except maybe printk() as it means another
>> lockdep problem exists.
> The reason lockdep is using raw_local_irq_save() is to avoid calling
> into itself again, notably local_irq_restore() will end up in
> mark_held_locks().
>
>> Fixes: a0b0fd53e1e67 ("locking/lockdep: Free lock classes that are no longer in use")
> Seems dubious, as the lockdep_assert_irqs_disabled() that triggered was
> added after that patch.
>
> I'm thinking another solution would be to increment the lockdep
> recursion count before calling RCU, because then we'll fail
> __lockdep_enabled and the assertion gets killed. Hmm?
>
Yes, you are right. Incrementing the lockdep recursion count should fix 
the issue. I was missing the commit 43be4388e94b ("lockdep: Put graph 
lock/unlock under lock_recursion protection"). This commit will properly 
increment the percpu lockdep recursion count and disable the call_rcu 
warning. So please ignore this patch.

Thanks,
Longman

