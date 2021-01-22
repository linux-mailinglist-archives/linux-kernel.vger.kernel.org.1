Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA45F30105B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbhAVWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbhAVWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:54:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:53:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so4810622pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=IGski1+y3JkNxnP0tP5oKMmY4sq5UVceE8GxBTLe7pw=;
        b=LOGKr0Dq1CkdmK4WZK39MPHGKViuAh6kPptKfzfQK/5Q/snDDpVp3XIks4iesd9Ask
         qOm2tvHwyFlvIitVpGGNxCLFriGAOo2v/tXLsKbFrKzQuI9C/XvIuD5oClS5zjJBJuuT
         Ny2gyZjg2gokQzdj+vFi1cXLD2bZEFvmcbc9bSEWFY5qi8s59diR5+94OdP6nE55W8nf
         YpvyWhpzom8ni7z5kcerYBeoFBn72FHcAgjgQE6kQHAC2OTo1ZtzHa+WOdUYJbtqL8Fb
         vQjRFM6AjcO+uEfY5sIyg3WBb50me7WmfA2rwSx/EpnBIV4/6LURBqJWeeu9anPioMbk
         xt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=IGski1+y3JkNxnP0tP5oKMmY4sq5UVceE8GxBTLe7pw=;
        b=sIe7Z+HUMQhFjvcS/XdpTMKbjXIqPxAUiS4X3YbeiroJEKuKnIAARXr/QacBszxSFl
         ztZwalY2BkR8/vbG9Yd5J4xt7dJJz3ePgb8hjS5s2mIJsQSNeDdrAh7/gE1kdVZhHi9s
         fptAUCLke3zNgyPzUNFs5pDwGEwvE9c68AQjR3XiIYvpdAIhXzFpq+cEHRaJr5SsyOhI
         wNdqTUiwy4syGpHOFRaFzqKpuAnNWeMKIKsmKRE13PrL3Rmi5KsW/SbKrFnJXd8L3qAv
         /VD9mZEi7O0msQPbJQowlTUr/vmpaf/477wljbyANVyEtkDZ5kT8zV8n41AFrMxPLrmJ
         HIdA==
X-Gm-Message-State: AOAM530zoAvgxJSfVwAvDHGOT8dmPj651UlTOmKX4PN09E701QL6JwXV
        Rr5Zor5C1JJs+7K0Cl/aBQYbDQ==
X-Google-Smtp-Source: ABdhPJwfwA51iXKSkwPqrCoiYEJCqPSFjYhura9dcJhbjNguSv3UlDtXYLdpY7wmdBU815jICGFTOg==
X-Received: by 2002:a62:5383:0:b029:1b6:20bf:e5a1 with SMTP id h125-20020a6253830000b02901b620bfe5a1mr7326318pfb.58.1611356027555;
        Fri, 22 Jan 2021 14:53:47 -0800 (PST)
Received: from [192.168.10.153] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id j13sm9713458pfr.214.2021.01.22.14.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 14:53:46 -0800 (PST)
Message-ID: <e4767b84-05a4-07c0-811b-b3a08cad2f43@ozlabs.ru>
Date:   Sat, 23 Jan 2021 09:53:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
References: <c099ad52-0c2c-b886-bae2-c64bd8626452@ozlabs.ru>
 <CACT4Y+Z+kwPM=WUzJ-e359PWeLLqmF0w4Yxp1spzZ=+J0ekrag@mail.gmail.com>
 <6af41136-4344-73da-f821-e831674be473@i-love.sakura.ne.jp>
 <70d427e8-7281-0aae-c524-813d73eca2d7@ozlabs.ru>
 <CACT4Y+bqidtwh1HUFFoyyKyVy0jnwrzhVBgqmU+T9sN1yPMO=g@mail.gmail.com>
 <eb71cc37-afbd-5446-6305-8c7abcc6e91f@i-love.sakura.ne.jp>
 <6eaafbd8-1c10-75df-75ae-9afa0861f69b@i-love.sakura.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <6eaafbd8-1c10-75df-75ae-9afa0861f69b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/2021 02:30, Tetsuo Handa wrote:
> On 2021/01/22 22:28, Tetsuo Handa wrote:
>> On 2021/01/22 21:10, Dmitry Vyukov wrote:
>>> On Fri, Jan 22, 2021 at 1:03 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>
>>>>
>>>>
>>>> On 22/01/2021 21:30, Tetsuo Handa wrote:
>>>>> On 2021/01/22 18:16, Dmitry Vyukov wrote:
>>>>>> The reproducer only does 2 bpf syscalls, so something is slowly leaking in bpf.
>>>>>> My first suspect would be one of these. Since workqueue is async, it
>>>>>> may cause such slow drain that happens only when tasks are spawned
>>>>>> fast. I don't know if there is a procfs/debugfs introspection file to
>>>>>> monitor workqueue lengths to verify this hypothesis.
>>>>>
>>>>> If you can reproduce locally, you can call show_workqueue_state()
>>>>> (part of SysRq-t) when hitting the limit.
>>>>>
>>>>> --- a/kernel/locking/lockdep.c
>>>>> +++ b/kernel/locking/lockdep.c
>>>>> @@ -1277,6 +1277,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
>>>>>
>>>>>                   print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
>>>>>                   dump_stack();
>>>>> +               show_workqueue_state();
>>>>>                   return NULL;
>>>>>           }
>>>>>           nr_lock_classes++;
>>>>>
>>>>
>>>>
>>>>
>>>> Here is the result:
>>>> https://pastebin.com/rPn0Cytu
>>>
>>> Do you mind posting this publicly?
>>> Yes, it seems that bpf_map_free_deferred is the problem (11138
>>> outstanding callbacks).
>>>
>>
>> Wow. Horribly stuck queue. I guess BPF wants to try WQ created by
>>
>>    alloc_workqueue("bpf_free_wq", WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);
>>
>> rather than system_wq . You can add Tejun Heo <tj@kernel.org> for WQ.
>>
>> Anyway, please post your result to ML.



https://pastebin.com/JfrmzguK is with the patch below applied. Seems 
less output. Interestingly when I almost hit "send", OOM kicked in and 
tried killing a bunch of "maxlockdep" processes (my test case):

[  891.037315] [  31007]     0 31007      281        5    49152        0 
          1000 maxlockdep
[  891.037540] [  31009]     0 31009      281        5    49152        0 
          1000 maxlockdep
[  891.037760] [  31012]     0 31012      281        5    49152        0 
          1000 maxlockdep
[  891.037980] [  31013]     0 31013      281        5    47104        0 
             0 maxlockdep
[  891.038210] [  31014]     0 31014      281        5    49152        0 
          1000 maxlockdep
[  891.038429] [  31018]     0 31018      281        5    47104        0 
             0 maxlockdep
[  891.038652] [  31019]     0 31019      281        5    49152        0 
          1000 maxlockdep
[  891.038874] [  31020]     0 31020      281        5    49152        0 
          1000 maxlockdep
[  891.039095] [  31021]     0 31021      281        5    49152        0 
          1000 maxlockdep
[  891.039317] [  31022]     0 31022      281        5    47104        0 
             0 maxlockdep




And (re)adding LKML and Tejun as suggested. Thanks,


>>
> 
> Does this patch (which is only compile tested) reduce number of pending works
> when hitting "BUG: MAX_LOCKDEP_KEYS too low!" ?
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 07cb5d15e743..c6c6902090f0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -41,6 +41,7 @@ struct bpf_local_storage_map;
>   struct kobject;
>   struct mem_cgroup;
>   
> +extern struct workqueue_struct *bpf_free_wq;
>   extern struct idr btf_idr;
>   extern spinlock_t btf_idr_lock;
>   extern struct kobject *btf_kobj;
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1f8453343bf2..8b1cf6aab089 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -994,7 +994,7 @@ static void prog_array_map_clear(struct bpf_map *map)
>   	struct bpf_array_aux *aux = container_of(map, struct bpf_array,
>   						 map)->aux;
>   	bpf_map_inc(map);
> -	schedule_work(&aux->work);
> +	queue_work(bpf_free_wq, &aux->work);
>   }
>   
>   static struct bpf_map *prog_array_map_alloc(union bpf_attr *attr)
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 96555a8a2c54..f272844163df 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -160,7 +160,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
>   	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
>   
>   	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
> -	queue_work(system_wq, &cgrp->bpf.release_work);
> +	queue_work(bpf_free_wq, &cgrp->bpf.release_work);
>   }
>   
>   /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 261f8692d0d2..9d76c0d77687 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -34,6 +34,15 @@
>   #include <linux/log2.h>
>   #include <asm/unaligned.h>
>   
> +struct workqueue_struct *bpf_free_wq;
> +
> +static int __init bpf_free_wq_init(void)
> +{
> +	bpf_free_wq = alloc_workqueue("bpf_free_wq", WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);
> +	return 0;
> +}
> +subsys_initcall(bpf_free_wq_init);
> +
>   /* Registers */
>   #define BPF_R0	regs[BPF_REG_0]
>   #define BPF_R1	regs[BPF_REG_1]
> @@ -2152,7 +2161,7 @@ void bpf_prog_free(struct bpf_prog *fp)
>   	if (aux->dst_prog)
>   		bpf_prog_put(aux->dst_prog);
>   	INIT_WORK(&aux->work, bpf_prog_free_deferred);
> -	schedule_work(&aux->work);
> +	queue_work(bpf_free_wq, &aux->work);
>   }
>   EXPORT_SYMBOL_GPL(bpf_prog_free);
>   
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 747313698178..6507cc8263fc 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -515,7 +515,7 @@ static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
>   	if (old_rcpu) {
>   		call_rcu(&old_rcpu->rcu, __cpu_map_entry_free);
>   		INIT_WORK(&old_rcpu->kthread_stop_wq, cpu_map_kthread_stop);
> -		schedule_work(&old_rcpu->kthread_stop_wq);
> +		queue_work(bpf_free_wq, &old_rcpu->kthread_stop_wq);
>   	}
>   }
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e5999d86c76e..084b903b4ee6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -477,7 +477,7 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
>   		bpf_map_free_id(map, do_idr_lock);
>   		btf_put(map->btf);
>   		INIT_WORK(&map->work, bpf_map_free_deferred);
> -		schedule_work(&map->work);
> +		queue_work(bpf_free_wq, &map->work);
>   	}
>   }
>   
> @@ -2343,7 +2343,7 @@ void bpf_link_put(struct bpf_link *link)
>   
>   	if (in_atomic()) {
>   		INIT_WORK(&link->work, bpf_link_put_deferred);
> -		schedule_work(&link->work);
> +		queue_work(bpf_free_wq, &link->work);
>   	} else {
>   		bpf_link_free(link);
>   	}
> 

-- 
Alexey
