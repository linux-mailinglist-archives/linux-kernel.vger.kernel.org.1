Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87060263005
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgIIOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgIIMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:31:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A62C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:31:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so2158368pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HM4mLAC7ka65HRVFrNTUTXBml1sSF6LU+w6QZrEOI0E=;
        b=To2pXLS+CElqpWw/LYEfxzwEQy0Lx+QQzzs4VF+gXxYZg3Cre0hsAT0+B5zeFlJeH7
         EpOrEFWbUXdX4nJQGYu2L+rruk2tS2SURZVHDrBXZN1qCoARvHUOCelN6Eb4Aoos/1Jo
         7Hmc18vet7gY8eQoab57YhqYTxswbTtTwTjlXwEKcXfRmMaYI4zGLQPedCk8TFSzW9lw
         6kDdTN7IBl9jAyQ/VAr+Y1Gh7odimVJsQtwcafx6r72K9ZRtt1OBcoXhfVKCwMvKFYtM
         u3yG6c3VGw3h4DtRR5b0EZbaN+67THiYwRh/6bLKFHNiqoU4VKIGWIA2z6F1C/Xhviee
         eNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HM4mLAC7ka65HRVFrNTUTXBml1sSF6LU+w6QZrEOI0E=;
        b=d2Ila1dpmu2FZxdGxGP0JgauMCpmHeM1LpXOEGfJFIGpfHb1M1/Vc8msohfn9T9kzV
         pxaUyj2C00KPVEM/qC8qrGVUA3hFgUT6PEK7cUq4HwDOVDLgHLNJiq3qnz4zAmPCrpU8
         hCiVOuGucWfXOraZPznzTjseEuq4aN9AYN62uHEa4c8f40VYf5kvft3sDDIpdBItRzjh
         kS9O8MHVZM6qkUMwMiBVwcjm96KQ3uItcvKYukGAZ27ywOVAQiaeHPhMFXx5OAa1rC+w
         jPVRtNPxv6zboounlO0hjedVKYtBnoAEKt6z1l/o2AFt/ItPd09o40WV9u0pFlzSL9jG
         70ug==
X-Gm-Message-State: AOAM530hhBPfGtnCrAZB+s8dgPIhNtmtuC4GB7vrjG+leydMYtQ2a/82
        AFlfHdjnHodOlGE170qb89tLTz9AR31WZI/y
X-Google-Smtp-Source: ABdhPJwCwieOoRAkQYI4f5mC3H8EyEmUxaJHIrRf5gfWWoyy8yWDcACcoCU9mC8kvBiyrMbiwbPtRA==
X-Received: by 2002:a05:6a00:238c:: with SMTP id f12mr589752pfc.99.1599654668589;
        Wed, 09 Sep 2020 05:31:08 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id e19sm2897596pfl.135.2020.09.09.05.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:31:07 -0700 (PDT)
Subject: Re: [PATCH kernel] srcu: Fix static initialization
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
 <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
 <20200909115010.GG29330@paulmck-ThinkPad-P72>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <37f76aac-d8e3-8ab1-24e9-c417b719e2a6@ozlabs.ru>
Date:   Wed, 9 Sep 2020 22:31:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200909115010.GG29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2020 21:50, Paul E. McKenney wrote:
> On Wed, Sep 09, 2020 at 07:24:11PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 09/09/2020 00:43, Alexey Kardashevskiy wrote:
>>> init_srcu_struct_nodes() is called with is_static==true only internally
>>> and when this happens, the srcu->sda is not initialized in
>>> init_srcu_struct_fields() and we crash on dereferencing @sdp.
>>>
>>> This fixes the crash by moving "if (is_static)" out of the loop which
>>> only does useful work for is_static=false case anyway.
>>>
>>> Found by syzkaller.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  kernel/rcu/srcutree.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>> index c100acf332ed..49b54a50bde8 100644
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>>>  				   levelspread[level - 1];
>>>  	}
>>>  
>>> +	if (is_static)
>>> +		return;
>>
>> Actually, this is needed here too:
>>
>>  if (!ssp->sda)
>>          return;
>>
>> as
>> ssp->sda = alloc_percpu(struct srcu_data)
>>
>> can fail if the process is killed too soon - it is quite easy to get
>> this situation with syzkaller (syscalls fuzzer)
>>
>> Makes sense?
> 
> Just to make sure that I understand, these failures occur when the task
> running init_srcu_struct_nodes() is killed, correct?

There are multiple user tasks (8) which open /dev/kvm, do 1 ioctl -
KVM_CREATE_VM - and terminate, running on 8 vcpus, 8 VMs, crashes every
20min or so, less tasks or vcpus - and the problem does not appear.


> 
> Or has someone managed to invoke (say) synchronize_srcu() on a
> dynamically allocated srcu_struct before invoking init_srcu_struct() on
> that srcu_struct?  

Nah, none of that :)

init_srcu_struct_nodes() assumes ssp->sda!=NULL but alloc_percpu() fails
here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/percpu.c#n1734
===
	} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
			return NULL;
===

I am still up to reading that osr-rcuusage.pdf to provide better
analysis :) Thanks,


> This would be an SRCU usage bug.  If you dynamically
> allocate your srcu_struct, you are absolutely required to invoke
> init_srcu_struct() on it before doing anything else with it.
> 
> Or am I missing something here?
> 
> (The rcutorture test suite does test both static and dynamic allocation
> of the srcu_struct, so I am expecting something a bit subtle here.)
> 
> 							Thanx, Paul
> 
>>> +
>>>  	/*
>>>  	 * Initialize the per-CPU srcu_data array, which feeds into the
>>>  	 * leaves of the srcu_node tree.
>>> @@ -161,8 +164,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>>>  		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
>>>  		sdp->ssp = ssp;
>>>  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
>>> -		if (is_static)
>>> -			continue;
>>>  
>>>  		/* Dynamically allocated, better be no srcu_read_locks()! */
>>>  		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
>>>
>>
>> -- 
>> Alexey

-- 
Alexey
