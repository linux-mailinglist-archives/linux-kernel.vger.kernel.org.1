Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E41EF956
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFENeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFENeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:34:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C64C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:34:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o6so5165432pgh.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEbUaiw8Kch03CncKtHMTXVy3L/nqFtMr+RdvLV65s4=;
        b=RnbuqibMxwWY5YoolBLjZaVq4mySx6ePfyz7ztDca/v2/vHysyr4itaLXoru69ZFPY
         B/O8AxKv7FCqMwyRUPKQMzPo8RwrXuCSWJLhS+fyTPGFQM/NfOSSw7OCudTvJFJ0EANP
         8C8siPvigH06kr/Undk+t7UDJIOo4D8zHtjsFe8Dm3iyu1l40ZKTPR1T4lE15+y50OVA
         WJhEv9Qaza26f4UAvVrn/WkUIrStLJatxYs8Hxjq7rSyDujjQ3od6l6IEjdSfjlD/4SG
         72kBAP04kA+iYIOK+keKsvKnIj+64nOR5OE4pjTxczxyuWaXFEoWvS3txRSgtJanhNS3
         LRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yEbUaiw8Kch03CncKtHMTXVy3L/nqFtMr+RdvLV65s4=;
        b=kRUcwoowdYVELoMmN/TmT0fFwG5LTCtUDgT1v1/EulHeCrOaeh6ygHGzsAfGVrLAeS
         OvZMPnHgKth4XUgLVGh88PAGCvBdurjfV74/3PZgrvPiLmEzOPg2KxJ80oBhxFi1qgs6
         31wmRyazANhUyEaZ4EQk/34kM79qLgm0V8s4Nv/n1El50UlBnO9PqKm41p7D8JXLDDQJ
         nCe37erLfYB6+FTqTiNJoZb5xe2lYs++NwU7ugL6j8SyTXyHhgtB3x4r+unGB67EbqLF
         IuhlAyq+kS+Qk4LKev3WsAev/oOvpOLXsLO04mpW0E8vtF4XiODauwiFM72mE1jTG7Il
         F6ZA==
X-Gm-Message-State: AOAM533lNQqkGX/pzFEELQn3rN8rN4VR3oGdIczphrgV0irWAI9EpZsB
        wZw7izzvNtVfbunQeTnsmME=
X-Google-Smtp-Source: ABdhPJxkM88UhEXcpZ2blay/ik+j1psU3Daxrv765EDw0RZByKCKYX+kOYwRnDdwnivJwXFz7JA4Gg==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr9162205pgq.265.1591364040731;
        Fri, 05 Jun 2020 06:34:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15sm6463237pgv.45.2020.06.05.06.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 06:33:40 -0700 (PDT)
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605081028.GC2750@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9784a2ec-b778-2492-76fc-c5aef83b66ad@roeck-us.net>
Date:   Fri, 5 Jun 2020 06:33:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200605081028.GC2750@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 1:10 AM, Peter Zijlstra wrote:
> On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
>> On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
> 
>>> +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
>>> +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
>>> +
>>
>> There is no guarantee in C that
>>
>> 	type1 a;
>> 	type2 b;
>>
>> in two different data structures means that offsetof(b) - offsetof(a)
>> is the same in both data structures unless attributes such as
>> __attribute__((__packed__)) are used.
> 
> Do tell more; the alignment requirements and size of the types remains
> the same, this resulting in different layout is unlikely.
> 

I have not made the C standard. You point out yourself a possible explicit
culprit: struct randomization. That by itself shows that you can not rely
on two elements of different structures having the same alignment,
which is pretty much exactly what I said (and may explain why observing
the problem seemed to at least somewhat depend on the weather).

> I found this excellent quote on Hacker News this morning:
> 
>  "I think the attitude of compiler writers is a good reason to fix the
>   spec so they can't keep ratfucking developers trying to get work done."
> 

Qed.

Guenter

>> As result, this does and will cause a variety of build errors depending
>> on the compiler version and compile flags.
> 
> The only thing I can think of that's actually a problem is that retarded
> struct randomization stuff.
> 
> Anyway, I'll move cleaning it up a little higher on the todo list.
> 

