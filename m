Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAEE289A83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbgJIVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388799AbgJIVSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602278327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QDABfjQ7mFtWSIvWu7QzsPLKaUIpGA23N/8EAqsvcQ=;
        b=X7ZUv9URW6d9ANq8RImpJrnQz5/YhhblDI1sVdv6seskEGy1r3u8963x8q3WiWOJEj1pkU
        F3R9FETJ88WnIfohRXjIAC4qCDXEeFppmh9QEX2Pxnakm4tE5kiEEJoaVjnuBYK2EI9TVx
        WE5ESu5ZKWjKaZyIEdNnEtpx/9fWbOs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-gOoXApSaPC-raQTNj-OXkQ-1; Fri, 09 Oct 2020 17:18:45 -0400
X-MC-Unique: gOoXApSaPC-raQTNj-OXkQ-1
Received: by mail-ot1-f69.google.com with SMTP id 32so3419508ott.21
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 14:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3QDABfjQ7mFtWSIvWu7QzsPLKaUIpGA23N/8EAqsvcQ=;
        b=ROTgNMubzCHZ3iMfqtT7QxokvytgTO6WuSvMD5W6nOI8sAcuzepknp9Jr3EUWcP3LE
         NDFddPokfk0bTv5cte3qBtV7Jo5Dc7go8J51ZEaIx9c2IvFED4eyjrFyiCWsES4/8TVg
         t6LpIS7bqNHWH3tPn7AkxHyCZm4OH3+cTxWiz1jnaWgunVS0rde4BSaKPez+/Gl1DVTX
         JcpIMre5i56KX2OLUK4xsJ587R+AbuxChyLaxZQyVIBdXfn+w9b7TBWrWzdAav7O4Y4Y
         Ab/OHRhjoptFqAtmSyTEg2dSuKSx4rW4tFRy/Tdpqp68uyV6COXQQXJQTdkjU7wS/tZp
         r6FQ==
X-Gm-Message-State: AOAM531E4a8fPneCmFPhqpDtdDskAFYc/AYrbwrwEalbn8TcE8ZjOWPz
        OUEuTNXu//FRo9rteQLDwTFcGm9AaaTXPZU0P1lYCt8R+YTWGRCd6G/mW1pOwT3q05cplKclIsy
        XrrhQ9An3CYor5gM04WqaeMua
X-Received: by 2002:a4a:db6f:: with SMTP id o15mr10587133ood.36.1602278325010;
        Fri, 09 Oct 2020 14:18:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzorAB0Y9J5973wxtLozHzUjB55pfvofrMrK+S93/GKeY+Sg8+RfGwWuVwOD43u+1F90CHy5Q==
X-Received: by 2002:a4a:db6f:: with SMTP id o15mr10587111ood.36.1602278324691;
        Fri, 09 Oct 2020 14:18:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s66sm6809547oib.16.2020.10.09.14.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 14:18:44 -0700 (PDT)
Subject: Re: [PATCH] rcutorture: remove unneeded check
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20201009194736.2364-1-trix@redhat.com>
 <20201009201825.GL29330@paulmck-ThinkPad-P72>
From:   Tom Rix <trix@redhat.com>
Message-ID: <03e3eeed-6072-ccb8-a9c6-c79a99c701b8@redhat.com>
Date:   Fri, 9 Oct 2020 14:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201009201825.GL29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/20 1:18 PM, Paul E. McKenney wrote:
> On Fri, Oct 09, 2020 at 12:47:36PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis reports this problem:
>>
>> rcutorture.c:1999:2: warning: Called function pointer
>>   is null (null dereference)
>>         cur_ops->sync(); /* Later readers see above write. */
>>         ^~~~~~~~~~~~~~~
>>
>> This is a false positive triggered by an earlier, later ignored
>> NULL check of sync() op.  By inspection of the rcu_torture_ops,
>> the sync() op is never uninitialized.  So this earlier check is
>> not needed.
> You lost me on this one.  This check is at the very beginning of
> rcu_torture_fwd_prog_nr().  Or are you saying that clang is seeing an
> earlier check in one of rcu_torture_fwd_prog_nr()'s callers?  If so,
> where exactly is this check?
>
> In any case, the check is needed because all three functions are invoked
> if there is a self-propagating RCU callback that ensures that there is
> always an RCU grace period outstanding.
>
> Ah.  Is clang doing local analysis and assuming that because there was
> a NULL check earlier, then the pointer might be NULL later?  That does
> not seem to me to be a sound check.
>
> So please let me know exactly what is causing clang to emit this
> diagnostic.  It might or might not be worth fixing this, but either way
> I need to understand the situation so as to be able to understand the
> set of feasible fixes.
>
> 						Thanx, Paul

In rcu_prog_nr() there is check for for sync.

if ( ... cur_op->sync ...

   do something

This flags in clang's static analyzer as 'could be null'

later in the function, in a reachable block it is used

cur_ops->sync()

I agree this is not a good check that's why i said is was a false positive.

However when looking closer at how cur_ops is set, it is never uninitialized.

So the check is not needed.

This is not a fix, the code works fine.  It is a small optimization.

Tom

>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  kernel/rcu/rcutorture.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index beba9e7963c8..6efc03a1d623 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -1989,7 +1989,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
>>  	unsigned long stopat;
>>  	static DEFINE_TORTURE_RANDOM(trs);
>>  
>> -	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
>> +	if  (cur_ops->call && cur_ops->cb_barrier) {
>>  		init_rcu_head_on_stack(&fcs.rh);
>>  		selfpropcb = true;
>>  	}
>> -- 
>> 2.18.1
>>

