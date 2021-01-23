Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1930630139C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 07:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbhAWGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 01:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAWGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 01:35:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB6C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 22:35:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x18so4536067pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 22:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iudd+qwQt2ff0UUu7St7PPKkKMyl19DSeY6rflstK9g=;
        b=x5lXX+30mRayjbAdbgq23WraYm87Ph/qvVJR8Y0+E7d9vbqHgF2Xvg0qI26iS0Wws2
         ur2mgNDehG/KmRfG9/eN8xx0P1pTsTl4mMbdYkMjv/oP0cByVRC9ns/ZqCNsG6HhAfja
         3EC0trPT1mScgImblzSmA1Q+pZ37iu4cd2ea8g7FNRN8e3aILyo6fAooUEmnlZTv7eNs
         qCB2qET/3zeP/oJoxwIQWdrFOr1BwZal8+wGMBq+V2cCJZRL36g+Ht7oGyfUN/490YqW
         u23rkSATNPKMVfseTr7tT8kr96PPffgPuMSWEIVOJyCJKPWJs9VmuJIby13+a8zcnyi3
         4f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iudd+qwQt2ff0UUu7St7PPKkKMyl19DSeY6rflstK9g=;
        b=BzJYjOepaQDuOziymikN94+ZIe1bsfnZ/lu894EbhN026tntwUzaEWvZ4NNnYuawtX
         InRuS9OXtzYkyay1yJRiHNnVYvHy12hkHRtAPsJf47KWzt4vYve8HWP22LX6HqsFszD0
         8JQWOsVdrTCRAsaXHWsJDpN1IJS5sgQr5xtA0aXrNyZwEOh9L+HLg3WbIIPrEA35sDJs
         CxzH6poAQGEFfFCuL3siizYYyCjlW30m4DLUjrj1WH/0Dc9kfn7tnLQXj1GP57b99e/O
         8VpEasJ/KCHCtOcX6pRsxjBU7o7gS7mtKb3Siy4t+xP9wvLlsdxeFHM9+OHLQv4AJr9W
         quDw==
X-Gm-Message-State: AOAM531HDxDbH0g6OV+NTJCvUtkRl0xhzszPxK4Z8oi0dR3dsFVk+PUM
        JQD6zyrxDiH4LfdLo5pywaQpYA==
X-Google-Smtp-Source: ABdhPJxHm0f0RLabOORPzNpaCeJb8LW1b84bLlbjTEQJ+lewj3tvvhR/bY/wFdk6+1Ydif92YVkhAQ==
X-Received: by 2002:a17:90a:8594:: with SMTP id m20mr9558168pjn.215.1611383708450;
        Fri, 22 Jan 2021 22:35:08 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id 67sm10431582pfv.20.2021.01.22.22.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 22:35:07 -0800 (PST)
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
To:     Hillf Danton <hdanton@sina.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <c099ad52-0c2c-b886-bae2-c64bd8626452@ozlabs.ru>
 <CACT4Y+Z+kwPM=WUzJ-e359PWeLLqmF0w4Yxp1spzZ=+J0ekrag@mail.gmail.com>
 <6af41136-4344-73da-f821-e831674be473@i-love.sakura.ne.jp>
 <70d427e8-7281-0aae-c524-813d73eca2d7@ozlabs.ru>
 <CACT4Y+bqidtwh1HUFFoyyKyVy0jnwrzhVBgqmU+T9sN1yPMO=g@mail.gmail.com>
 <eb71cc37-afbd-5446-6305-8c7abcc6e91f@i-love.sakura.ne.jp>
 <6eaafbd8-1c10-75df-75ae-9afa0861f69b@i-love.sakura.ne.jp>
 <20210123060145.18356-1-hdanton@sina.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8b1fff6b-1acc-4582-0abe-86f948ac4b4a@ozlabs.ru>
Date:   Sat, 23 Jan 2021 17:35:03 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210123060145.18356-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/2021 17:01, Hillf Danton wrote:
> On Sat, 23 Jan 2021 09:53:42 +1100  Alexey Kardashevskiy wrote:
>> On 23/01/2021 02:30, Tetsuo Handa wrote:
>>> On 2021/01/22 22:28, Tetsuo Handa wrote:
>>>> On 2021/01/22 21:10, Dmitry Vyukov wrote:
>>>>> On Fri, Jan 22, 2021 at 1:03 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 22/01/2021 21:30, Tetsuo Handa wrote:
>>>>>>> On 2021/01/22 18:16, Dmitry Vyukov wrote:
>>>>>>>> The reproducer only does 2 bpf syscalls, so something is slowly leaking in bpf.
>>>>>>>> My first suspect would be one of these. Since workqueue is async, it
>>>>>>>> may cause such slow drain that happens only when tasks are spawned
>>>>>>>> fast. I don't know if there is a procfs/debugfs introspection file to
>>>>>>>> monitor workqueue lengths to verify this hypothesis.
>>>>>>>
>>>>>>> If you can reproduce locally, you can call show_workqueue_state()
>>>>>>> (part of SysRq-t) when hitting the limit.
>>>>>>>
>>>>>>> --- a/kernel/locking/lockdep.c
>>>>>>> +++ b/kernel/locking/lockdep.c
>>>>>>> @@ -1277,6 +1277,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
>>>>>>>
>>>>>>>                    print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
>>>>>>>                    dump_stack();
>>>>>>> +               show_workqueue_state();
>>>>>>>                    return NULL;
>>>>>>>            }
>>>>>>>            nr_lock_classes++;
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Here is the result:
>>>>>> https://pastebin.com/rPn0Cytu
>>>>>
>>>>> Do you mind posting this publicly?
>>>>> Yes, it seems that bpf_map_free_deferred is the problem (11138
>>>>> outstanding callbacks).
> 
> Need to set up a local queue for releasing bpf maps if 10,000 means
> flooding.
> 
>>>>>
>>>>
>>>> Wow. Horribly stuck queue. I guess BPF wants to try WQ created by
>>>>
>>>>     alloc_workqueue("bpf_free_wq", WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);
>>>>
>>>> rather than system_wq . You can add Tejun Heo <tj@kernel.org> for WQ.
>>>>
>>>> Anyway, please post your result to ML.
>>
>> https://pastebin.com/JfrmzguK is with the patch below applied. Seems
>> less output. Interestingly when I almost hit "send", OOM kicked in and
>> tried killing a bunch of "maxlockdep" processes (my test case):
>>
>> [  891.037315] [  31007]     0 31007      281        5    49152        0
>>           1000 maxlockdep
>> [  891.037540] [  31009]     0 31009      281        5    49152        0
>>           1000 maxlockdep
>> [  891.037760] [  31012]     0 31012      281        5    49152        0
>>           1000 maxlockdep
>> [  891.037980] [  31013]     0 31013      281        5    47104        0
>>              0 maxlockdep
>> [  891.038210] [  31014]     0 31014      281        5    49152        0
>>           1000 maxlockdep
>> [  891.038429] [  31018]     0 31018      281        5    47104        0
>>              0 maxlockdep
>> [  891.038652] [  31019]     0 31019      281        5    49152        0
>>           1000 maxlockdep
>> [  891.038874] [  31020]     0 31020      281        5    49152        0
>>           1000 maxlockdep
>> [  891.039095] [  31021]     0 31021      281        5    49152        0
>>           1000 maxlockdep
>> [  891.039317] [  31022]     0 31022      281        5    47104        0
>>              0 maxlockdep
>>
> 
> A local queue, the mix of list head and spin lock, helps to collapse
> the entities of map->work into one work in order to cut the risk of
> work flooding to WQ.
> 
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -448,16 +448,40 @@ static void bpf_map_release_memcg(struct
>   }
>   #endif
>   
> -/* called from workqueue */
> +static int worker_idle = 1;
> +static LIST_HEAD(bpf_map_work_list);
> +static DEFINE_SPINLOCK(bpf_map_work_lock);
> +
>   static void bpf_map_free_deferred(struct work_struct *work)
>   {
> -	struct bpf_map *map = container_of(work, struct bpf_map, work);
> +	struct bpf_map *map;
> +
> +	worker_idle = 0;
> +again:
> +	map = NULL;
> +	spin_lock_irq(&bpf_map_work_lock);
> +
> +	if (!list_empty(&bpf_map_work_list)) {
> +		map = list_first_entry(&bpf_map_work_list, struct bpf_map,
> +							work_list);
> +		list_del_init(&map->work_list);
> +	} else
> +		worker_idle = 1;
> +
> +	spin_unlock_irq(&bpf_map_work_lock);
> +
> +	if (!map)
> +		return;
>   
>   	security_bpf_map_free(map);
>   	bpf_map_release_memcg(map);
>   	/* implementation dependent freeing */
>   	map->ops->map_free(map);
> +
> +	cond_resched();
> +	goto again;
>   }
> +static DECLARE_WORK(bpf_map_release_work, bpf_map_free_deferred);
>   
>   static void bpf_map_put_uref(struct bpf_map *map)
>   {
> @@ -473,11 +497,20 @@ static void bpf_map_put_uref(struct bpf_
>   static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
>   {
>   	if (atomic64_dec_and_test(&map->refcnt)) {
> +		unsigned long flags;
> +		int idle;
> +
>   		/* bpf_map_free_id() must be called first */
>   		bpf_map_free_id(map, do_idr_lock);
>   		btf_put(map->btf);
> -		INIT_WORK(&map->work, bpf_map_free_deferred);
> -		schedule_work(&map->work);
> +
> +		spin_lock_irqsave(&bpf_map_work_lock, flags);
> +		idle = worker_idle;
> +		list_add(&map->work_list, &bpf_map_work_list);
> +		spin_unlock_irqrestore(&bpf_map_work_lock, flags);
> +
> +		if (idle)
> +			queue_work(system_unbound_wq, &bpf_map_release_work);
>   	}
>   }
>   
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -149,7 +149,7 @@ struct bpf_map {
>   	 */
>   	atomic64_t refcnt ____cacheline_aligned;
>   	atomic64_t usercnt;
> -	struct work_struct work;
> +	struct list_head work_list;
>   	struct mutex freeze_mutex;
>   	u64 writecnt; /* writable mmap cnt; protected by freeze_mutex */
>   };
> --
> 

this behaves quite different but still produces the message (i have 
show_workqueue_state() right after the bug message):


[   85.803991] BUG: MAX_LOCKDEP_KEYS too low!
[   85.804338] turning off the locking correctness validator.
[   85.804474] Showing busy workqueues and worker pools:
[   85.804620] workqueue events_unbound: flags=0x2
[   85.804764]   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/512 refcnt=3
[   85.804965]     in-flight: 81:bpf_map_free_deferred
[   85.805229] workqueue events_power_efficient: flags=0x80
[   85.805357]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   85.805558]     in-flight: 57:gc_worker
[   85.805877] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=3 
idle: 82 24
[   85.806147] pool 16: cpus=0-7 flags=0x4 nice=0 hung=69s workers=3 
idle: 7 251
^C[  100.129747] maxlockdep (5104) used greatest stack depth: 8032 bytes 
left

root@le-dbg:~# grep "lock-classes" /proc/lockdep_stats
  lock-classes:                         8192 [max: 8192]





-- 
Alexey
