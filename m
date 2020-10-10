Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F928A1E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbgJJWj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730509AbgJJS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602356302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1U6g5wkRy2MmIMDmN+8cP3usquGYm44wAD9C0CHP9c=;
        b=DhjUWMfJA18mqOLQDdS6MeYpPanhKOQuIdynY2PQdX/OVwcyeLFIh8HJsb0+X99T1+Ogiz
        GndRUzoNTBJZEJdz3IZlx26iPQ4P+WG+kqc8aq7cRDZjZ1MlQxwU5z9e8wPFqwDqk6lyhe
        nv/n2oJ4AwHEb9wdBZe1+Fw2roZ8BNU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-D4Ezr4OaPjqDWcmt13yOWw-1; Sat, 10 Oct 2020 14:07:39 -0400
X-MC-Unique: D4Ezr4OaPjqDWcmt13yOWw-1
Received: by mail-oi1-f200.google.com with SMTP id x192so4339528oif.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 11:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o1U6g5wkRy2MmIMDmN+8cP3usquGYm44wAD9C0CHP9c=;
        b=WexJkWzTQzbv/oT+Xmdjwit0KHhser80dpo1J6EvMy0EjirlWzHth/mMP6whXNa2ki
         OxfI0dXTEZCnCr9hVzT2vjCC/suckk+B/Sdj0MQk9D//SrwAhqNr5NhCGbtZINlw4lpG
         raoAGOq86wwadbZrzzu/1MHuMKavWCw/F1I7Rp8mtAcsKu7efD9JlZ2bElgNClg35bEK
         fZoHaIu67tMYRVPIr3dlz4rOQIAzEg+btJfTigW8eAyDuGCgmPUBya7XD4FHDvPBxDXT
         2FzlB6MgtTQTzpiw+mS+CE/kz6N3m7R/WtONOQfYcqVxphz5PvKEL3+MPlGzeL6g4/v4
         hpSA==
X-Gm-Message-State: AOAM532ucXWbQXbVBeCHTvFoHrF8323blDdtJO77sjz4m3KjZ28JtFtH
        yJPf/mS10bnfQJvz8t/T6A4xIoGDgHOdot0Yp+tFVMIGet6dH/fiTKbGMdGJHkLWMw+qTcl++SW
        KvUr26RjxL9U1R5JRdZTRGiou
X-Received: by 2002:aca:dcd5:: with SMTP id t204mr6437494oig.47.1602353258074;
        Sat, 10 Oct 2020 11:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMBM2gcuKCD0WOvTGX8XXKHC/Cau+xTSf5sCDnWs4WwLS/ikfnsZJh2I1VJIWW3klSkdxzcQ==
X-Received: by 2002:aca:dcd5:: with SMTP id t204mr6437477oig.47.1602353257697;
        Sat, 10 Oct 2020 11:07:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 22sm5286695oie.54.2020.10.10.11.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 11:07:37 -0700 (PDT)
Subject: Re: [PATCH] rcutorture: remove unneeded check
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20201009194736.2364-1-trix@redhat.com>
 <20201009201825.GL29330@paulmck-ThinkPad-P72>
 <03e3eeed-6072-ccb8-a9c6-c79a99c701b8@redhat.com>
 <20201009235033.GM29330@paulmck-ThinkPad-P72>
 <92f82632-adbd-ca85-d516-6540a49f01ab@redhat.com>
 <20201010025743.GN29330@paulmck-ThinkPad-P72>
 <20201010175751.GA5714@paulmck-ThinkPad-P72>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c56a94ca-68d0-2e14-7374-a51c4e85b3cc@redhat.com>
Date:   Sat, 10 Oct 2020 11:07:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201010175751.GA5714@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/20 10:57 AM, Paul E. McKenney wrote:
> On Fri, Oct 09, 2020 at 07:57:43PM -0700, Paul E. McKenney wrote:
>> On Fri, Oct 09, 2020 at 05:24:37PM -0700, Tom Rix wrote:
>>> On 10/9/20 4:50 PM, Paul E. McKenney wrote:
>>>> On Fri, Oct 09, 2020 at 02:18:41PM -0700, Tom Rix wrote:
>>>>> On 10/9/20 1:18 PM, Paul E. McKenney wrote:
>>>>>> On Fri, Oct 09, 2020 at 12:47:36PM -0700, trix@redhat.com wrote:
>>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>>
>>>>>>> clang static analysis reports this problem:
>>>>>>>
>>>>>>> rcutorture.c:1999:2: warning: Called function pointer
>>>>>>>   is null (null dereference)
>>>>>>>         cur_ops->sync(); /* Later readers see above write. */
>>>>>>>         ^~~~~~~~~~~~~~~
>>>>>>>
>>>>>>> This is a false positive triggered by an earlier, later ignored
>>>>>>> NULL check of sync() op.  By inspection of the rcu_torture_ops,
>>>>>>> the sync() op is never uninitialized.  So this earlier check is
>>>>>>> not needed.
>>>>>> You lost me on this one.  This check is at the very beginning of
>>>>>> rcu_torture_fwd_prog_nr().  Or are you saying that clang is seeing an
>>>>>> earlier check in one of rcu_torture_fwd_prog_nr()'s callers?  If so,
>>>>>> where exactly is this check?
>>>>>>
>>>>>> In any case, the check is needed because all three functions are invoked
>>>>>> if there is a self-propagating RCU callback that ensures that there is
>>>>>> always an RCU grace period outstanding.
>>>>>>
>>>>>> Ah.  Is clang doing local analysis and assuming that because there was
>>>>>> a NULL check earlier, then the pointer might be NULL later?  That does
>>>>>> not seem to me to be a sound check.
> In this case, the diagnostic was clearly pointing out a latent bug, so
> my bad.  So more of a code-review comment than a diagnostic.  Therefore,
> if clang really wants to be in the code-review space, I suggest that it
> more clearly explain its code-review feedback.  ;-)

Ok.

I have another a change in other area queued up.

I'll improve it's and future comments.

Tom

> 							Thanx, Paul
>
>>>>>> So please let me know exactly what is causing clang to emit this
>>>>>> diagnostic.  It might or might not be worth fixing this, but either way
>>>>>> I need to understand the situation so as to be able to understand the
>>>>>> set of feasible fixes.
>>>>>>
>>>>>> 						Thanx, Paul
>>>>> In rcu_prog_nr() there is check for for sync.
>>>>>
>>>>> if ( ... cur_op->sync ...
>>>>>
>>>>>    do something
>>>>>
>>>>> This flags in clang's static analyzer as 'could be null'
>>>>>
>>>>> later in the function, in a reachable block it is used
>>>>>
>>>>> cur_ops->sync()
>>>>>
>>>>> I agree this is not a good check that's why i said is was a false positive.
>>>>>
>>>>> However when looking closer at how cur_ops is set, it is never uninitialized.
>>>>>
>>>>> So the check is not needed.
>>>> OK, got it, and thank you for the explanation.
>>>>
>>>>> This is not a fix, the code works fine.  It is a small optimization.
>>>> Well, there really is a bug.  Yes, right now all ->sync pointers are
>>>> non-NULL, but they have not been in the past and might not be in the
>>>> future.  So if ->sync is NULL, rcu_torture_fwd_prog_nr() either should
>>>> not be called or it should return immediately without doing anything.
>>>>
>>>> My current thought is something like the (untested) patch below, of
>>>> course with your Reported-by.
>>>>
>>>> Thoughts?
>>> Yes that would be fine.
>>>
>>> In in review these other cases need to be been take care of.
>> I am having a difficult time interpreting this sentence, but will
>> optimistically assume that it means that you are good with this approach.
>> If my optimism is unwarranted, please let me know so I can fix whatever
>> might be broken.
>>
>>> Reported-by: Tom Rix <trix@redhat.com>
>> How does the commit below look?
>>
>> 							Thanx, Paul
>>
>> ------------------------------------------------------------------------
>>
>> commit 75c79a5dd72c1bb59f6bd6c5ec36f3a6516795cd
>> Author: Paul E. McKenney <paulmck@kernel.org>
>> Date:   Fri Oct 9 19:51:55 2020 -0700
>>
>>     rcutorture: Don't do need_resched() testing if ->sync is NULL
>>     
>>     If cur_ops->sync is NULL, rcu_torture_fwd_prog_nr() will nevertheless
>>     attempt to call through it.  This commit therefore flags cases where
>>     neither need_resched() nor call_rcu() forward-progress testing
>>     can be performed due to NULL function pointers, and also causes
>>     rcu_torture_fwd_prog_nr() to take an early exit if cur_ops->sync()
>>     is NULL.
>>     
>>     Reported-by: Tom Rix <trix@redhat.com>
>>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index beba9e7..44749be 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -1989,7 +1989,9 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
>>  	unsigned long stopat;
>>  	static DEFINE_TORTURE_RANDOM(trs);
>>  
>> -	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
>> +	if (!cur_ops->sync) 
>> +		return; // Cannot do need_resched() forward progress testing without ->sync.
>> +	if (cur_ops->call && cur_ops->cb_barrier) {
>>  		init_rcu_head_on_stack(&fcs.rh);
>>  		selfpropcb = true;
>>  	}
>> @@ -2215,8 +2217,8 @@ static int __init rcu_torture_fwd_prog_init(void)
>>  
>>  	if (!fwd_progress)
>>  		return 0; /* Not requested, so don't do it. */
>> -	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
>> -	    cur_ops == &rcu_busted_ops) {
>> +	if ((!cur_ops->sync && !cur_ops->call) ||
>> +	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
>>  		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
>>  		return 0;
>>  	}

