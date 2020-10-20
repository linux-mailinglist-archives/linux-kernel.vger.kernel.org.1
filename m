Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D6289CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgJJA3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728992AbgJJAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602289482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1n5KeMHBgg75rXfWx16VkrJqv8CwDfWMRJRvhBV9wg=;
        b=ivBrvVrfxZDRTbh2ORHFgAgrnPoPbsycDAerMsE62+CWD1kdD6JzTh0mEtGk7YeHVNHIKI
        fWHv0EvJCPLrik2/d3dCx/sWmKxm6K9VWOAHRf5IelLgVKRwtBRoSdgXxvFSvHF86xW8+W
        u27aZbXX09UmafzIzppL240sqMGJIyE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-U6yaZZUyOB-aDou3YUPVHQ-1; Fri, 09 Oct 2020 20:24:41 -0400
X-MC-Unique: U6yaZZUyOB-aDou3YUPVHQ-1
Received: by mail-qv1-f72.google.com with SMTP id dd7so7050085qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j1n5KeMHBgg75rXfWx16VkrJqv8CwDfWMRJRvhBV9wg=;
        b=HK3DV0vL7pSi+efXJO57odQsgL2Ar6XNBPXfGvlVoDjSuUZBFpx+VKthHuw/OFlUp9
         rsmqVqE4FW0i1cilzR9Vn8AEL7DEW3X7E9wJbuGbsC5Vo+2wrbapC8gqGKEOdUqujG2c
         OAHxHgFzPp+Q+XE3M22FxGdQOJ98BqdRZ3OBzkorAr8xJxmB2iwhwaFgiroGPOVKR47U
         8jdQYitenvxLDRbZJsg8P/hg4I4F/17m/zuoJem/9cjKtE57bkFg8RJhENczAzFgJvTe
         Yn8ccGm5xruH/67RcUHM0BktMKU9LTbX7RzPQw5irWxYqMkpx8V10mKHTEU4zrqAyT3X
         fUsA==
X-Gm-Message-State: AOAM531K7Yqn/CdYcaRZP5lMmjZOVm8ZLY2l3frAM5bdcGCTpzymZ9X3
        C/s9+yJLNPpcVIkgGvuiKZJTyndX2k4U2tkKPNrjfH4dp1ZRDkp8dx0LdkELLi3HANkdLrs2s62
        gFNJRFpaXMtyt9ZbslCGD6m0f
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr534404qks.57.1602289480540;
        Fri, 09 Oct 2020 17:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZgPf78o39U4kPoIYqNBD3TsfW/QS30rya6KA328k4K6mos+3yKATAPfF55eeaoDm8w1ACrw==
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr534381qks.57.1602289480187;
        Fri, 09 Oct 2020 17:24:40 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i205sm7478724qke.70.2020.10.09.17.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 17:24:39 -0700 (PDT)
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
From:   Tom Rix <trix@redhat.com>
Message-ID: <92f82632-adbd-ca85-d516-6540a49f01ab@redhat.com>
Date:   Fri, 9 Oct 2020 17:24:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201009235033.GM29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/20 4:50 PM, Paul E. McKenney wrote:
> On Fri, Oct 09, 2020 at 02:18:41PM -0700, Tom Rix wrote:
>> On 10/9/20 1:18 PM, Paul E. McKenney wrote:
>>> On Fri, Oct 09, 2020 at 12:47:36PM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> clang static analysis reports this problem:
>>>>
>>>> rcutorture.c:1999:2: warning: Called function pointer
>>>>   is null (null dereference)
>>>>         cur_ops->sync(); /* Later readers see above write. */
>>>>         ^~~~~~~~~~~~~~~
>>>>
>>>> This is a false positive triggered by an earlier, later ignored
>>>> NULL check of sync() op.  By inspection of the rcu_torture_ops,
>>>> the sync() op is never uninitialized.  So this earlier check is
>>>> not needed.
>>> You lost me on this one.  This check is at the very beginning of
>>> rcu_torture_fwd_prog_nr().  Or are you saying that clang is seeing an
>>> earlier check in one of rcu_torture_fwd_prog_nr()'s callers?  If so,
>>> where exactly is this check?
>>>
>>> In any case, the check is needed because all three functions are invoked
>>> if there is a self-propagating RCU callback that ensures that there is
>>> always an RCU grace period outstanding.
>>>
>>> Ah.  Is clang doing local analysis and assuming that because there was
>>> a NULL check earlier, then the pointer might be NULL later?  That does
>>> not seem to me to be a sound check.
>>>
>>> So please let me know exactly what is causing clang to emit this
>>> diagnostic.  It might or might not be worth fixing this, but either way
>>> I need to understand the situation so as to be able to understand the
>>> set of feasible fixes.
>>>
>>> 						Thanx, Paul
>> In rcu_prog_nr() there is check for for sync.
>>
>> if ( ... cur_op->sync ...
>>
>>    do something
>>
>> This flags in clang's static analyzer as 'could be null'
>>
>> later in the function, in a reachable block it is used
>>
>> cur_ops->sync()
>>
>> I agree this is not a good check that's why i said is was a false positive.
>>
>> However when looking closer at how cur_ops is set, it is never uninitialized.
>>
>> So the check is not needed.
> OK, got it, and thank you for the explanation.
>
>> This is not a fix, the code works fine.  It is a small optimization.
> Well, there really is a bug.  Yes, right now all ->sync pointers are
> non-NULL, but they have not been in the past and might not be in the
> future.  So if ->sync is NULL, rcu_torture_fwd_prog_nr() either should
> not be called or it should return immediately without doing anything.
>
> My current thought is something like the (untested) patch below, of
> course with your Reported-by.
>
> Thoughts?

Yes that would be fine.

In in review these other cases need to be been take care of.

Thanks,

Reported-by: Tom Rix <trix@redhat.com>

> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index beba9e7..44749be 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1989,7 +1989,9 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
>  	unsigned long stopat;
>  	static DEFINE_TORTURE_RANDOM(trs);
>  
> -	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
> +	if (!cur_ops->sync) 
> +		return; // Cannot do need_resched() forward progress testing without ->sync.
> +	if (cur_ops->call && cur_ops->cb_barrier) {
>  		init_rcu_head_on_stack(&fcs.rh);
>  		selfpropcb = true;
>  	}
> @@ -2215,8 +2217,8 @@ static int __init rcu_torture_fwd_prog_init(void)
>  
>  	if (!fwd_progress)
>  		return 0; /* Not requested, so don't do it. */
> -	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
> -	    cur_ops == &rcu_busted_ops) {
> +	if ((!cur_ops->sync && !cur_ops->call) ||
> +	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
>  		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
>  		return 0;
>  	}
>

