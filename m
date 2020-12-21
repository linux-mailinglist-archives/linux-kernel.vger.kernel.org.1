Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081832DFB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgLULjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:39:36 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:39592 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLULjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:39:35 -0500
Received: by mail-pf1-f181.google.com with SMTP id m6so6301056pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhDL0oFXoLD77Gyqz56Rx7XV0UlGmp5Wa/giIo3BeYk=;
        b=rUqqegpnpO93bR+raxq1kex3q1nt79BCMemqZe/BCbO49OHxPXVsQHoRYk7fDmqv2N
         8RJaWuOpGIOpVB8uyqoNAQB5z47v4KPNFkdPjxqdoNQVMGGDmgeMGxfhijiBOjudlZ1B
         wjZdX4xSjWiGFWtA3VwruLILXZvMUURo3sfRjAfauUuaDWeE5aY7Qwx9o36NBZiKQF8s
         5SpLxogQsQu1zo/nU7Am44o3bVmg9XHnoHOhJYoP1KkQiKJfLj4NrGnzVyQDYTrVKmJI
         n1FIi3R4FkDUYXLgubrEyzlEyA/JLSUH7FjhAT77XrTY0NKKRhmXOcaW8xmM629AvjjG
         eRYw==
X-Gm-Message-State: AOAM531Ydmq5Whpf+PB9ViW/YBTiOIIQmXsEeud0ZzJXfOaZBvhqbg/b
        RBpMqEd+oHYAL6NJ+wgs3zo=
X-Google-Smtp-Source: ABdhPJzWKtOTxupz1ZgfgJVgWGb6FihqwwPrxT8B8aw6kDyZXLFFOMmToGKDRnjztW9iLaVNP8W7QQ==
X-Received: by 2002:a65:688a:: with SMTP id e10mr15012731pgt.347.1608550734804;
        Mon, 21 Dec 2020 03:38:54 -0800 (PST)
Received: from localhost.localdomain ([49.236.93.237])
        by smtp.gmail.com with ESMTPSA id e10sm12653107pgu.42.2020.12.21.03.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 03:38:54 -0800 (PST)
Subject: Re: [PATCH] signal: Don't init struct kernel_siginfo fields to zero
 again
To:     Rae Kim <rae.kim@gmail.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     Leesoo Ahn <dev@ooseel.net>, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <20201220074555.12655-1-lsahn@ooseel.net>
 <20201220142134.GB16470@redhat.com> <20201220154305.ixlm4mwesyfexq57@rae.kim>
From:   Leesoo Ahn <lsahn@ooseel.net>
Message-ID: <185e982b-35c3-f57d-7db7-d23df49102d4@ooseel.net>
Date:   Mon, 21 Dec 2020 20:38:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201220154305.ixlm4mwesyfexq57@rae.kim>
Content-Type: text/plain; charset=euc-kr; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20. 12. 21. 오전 12:43에 Rae Kim 이(가) 쓴 글:
> 
> It looks like compiler optimization is smart enough to know that
> assigning zero is unnecessary after clear_siginfo() which is memset()
> under the hood. At least in my x86_64 machine, w/ or w/o this patch,
> there is no difference in final compiled machine code. (I've compared
> "objdump -d" results for "__send_signal()", "do_tkill()", and
> "collect_signal()")
> 
> Wouldn't it be nicer to have more information for both human and
> compiler since it doesn't generate extra machine code?

I think the patch is still worth in human perspective even if there is no
difference on machine code. Because someone could get confused by
initializing them twice at the point, for example, why still try to init
even though clear_siginfo() takes all the responsibility, so they could
waste more time to figure out the code.

Leesoo

> 
> On Sun, Dec 20, 2020 at 03:21:35PM +0100, Oleg Nesterov wrote:
>> On 12/20, Leesoo Ahn wrote:
>>>
>>> clear_siginfo() is responsible for clearing struct kernel_siginfo object.
>>> It's obvious that manually initializing those fields is needless as
>>> a commit[1] explains why the function introduced and its guarantee that
>>> all bits in the struct are cleared after it.
>>>
>>> [1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")
>>>
>>> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
>>
>> Acked-by: Oleg Nesterov <oleg@redhat.com>
>>
>>
>>> ---
>>>   kernel/signal.c | 21 ---------------------
>>>   1 file changed, 21 deletions(-)
>>>
>>> diff --git a/kernel/signal.c b/kernel/signal.c
>>> index 5736c55aaa1a..8f49fa3ade33 100644
>>> --- a/kernel/signal.c
>>> +++ b/kernel/signal.c
>>> @@ -603,10 +603,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
>>>   		 */
>>>   		clear_siginfo(info);
>>>   		info->si_signo = sig;
>>> -		info->si_errno = 0;
>>>   		info->si_code = SI_USER;
>>> -		info->si_pid = 0;
>>> -		info->si_uid = 0;
>>>   	}
>>>   }
>>>   
>>> @@ -1120,7 +1117,6 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>>>   		case (unsigned long) SEND_SIG_NOINFO:
>>>   			clear_siginfo(&q->info);
>>>   			q->info.si_signo = sig;
>>> -			q->info.si_errno = 0;
>>>   			q->info.si_code = SI_USER;
>>>   			q->info.si_pid = task_tgid_nr_ns(current,
>>>   							task_active_pid_ns(t));
>>> @@ -1133,10 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>>>   		case (unsigned long) SEND_SIG_PRIV:
>>>   			clear_siginfo(&q->info);
>>>   			q->info.si_signo = sig;
>>> -			q->info.si_errno = 0;
>>>   			q->info.si_code = SI_KERNEL;
>>> -			q->info.si_pid = 0;
>>> -			q->info.si_uid = 0;
>>>   			break;
>>>   		default:
>>>   			copy_siginfo(&q->info, info);
>>> @@ -1623,10 +1616,7 @@ void force_sig(int sig)
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = sig;
>>> -	info.si_errno = 0;
>>>   	info.si_code = SI_KERNEL;
>>> -	info.si_pid = 0;
>>> -	info.si_uid = 0;
>>>   	force_sig_info(&info);
>>>   }
>>>   EXPORT_SYMBOL(force_sig);
>>> @@ -1659,7 +1649,6 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = sig;
>>> -	info.si_errno = 0;
>>>   	info.si_code  = code;
>>>   	info.si_addr  = addr;
>>>   #ifdef __ARCH_SI_TRAPNO
>>> @@ -1691,7 +1680,6 @@ int send_sig_fault(int sig, int code, void __user *addr
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = sig;
>>> -	info.si_errno = 0;
>>>   	info.si_code  = code;
>>>   	info.si_addr  = addr;
>>>   #ifdef __ARCH_SI_TRAPNO
>>> @@ -1712,7 +1700,6 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
>>>   	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = SIGBUS;
>>> -	info.si_errno = 0;
>>>   	info.si_code = code;
>>>   	info.si_addr = addr;
>>>   	info.si_addr_lsb = lsb;
>>> @@ -1726,7 +1713,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
>>>   	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = SIGBUS;
>>> -	info.si_errno = 0;
>>>   	info.si_code = code;
>>>   	info.si_addr = addr;
>>>   	info.si_addr_lsb = lsb;
>>> @@ -1740,7 +1726,6 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = SIGSEGV;
>>> -	info.si_errno = 0;
>>>   	info.si_code  = SEGV_BNDERR;
>>>   	info.si_addr  = addr;
>>>   	info.si_lower = lower;
>>> @@ -1755,7 +1740,6 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = SIGSEGV;
>>> -	info.si_errno = 0;
>>>   	info.si_code  = SEGV_PKUERR;
>>>   	info.si_addr  = addr;
>>>   	info.si_pkey  = pkey;
>>> @@ -1934,7 +1918,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = sig;
>>> -	info.si_errno = 0;
>>>   	/*
>>>   	 * We are under tasklist_lock here so our parent is tied to
>>>   	 * us and cannot change.
>>> @@ -2033,7 +2016,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = SIGCHLD;
>>> -	info.si_errno = 0;
>>>   	/*
>>>   	 * see comment in do_notify_parent() about the following 4 lines
>>>   	 */
>>> @@ -2506,7 +2488,6 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>>>   	if (signr != info->si_signo) {
>>>   		clear_siginfo(info);
>>>   		info->si_signo = signr;
>>> -		info->si_errno = 0;
>>>   		info->si_code = SI_USER;
>>>   		rcu_read_lock();
>>>   		info->si_pid = task_pid_vnr(current->parent);
>>> @@ -3660,7 +3641,6 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
>>>   {
>>>   	clear_siginfo(info);
>>>   	info->si_signo = sig;
>>> -	info->si_errno = 0;
>>>   	info->si_code = SI_USER;
>>>   	info->si_pid = task_tgid_vnr(current);
>>>   	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
>>> @@ -3833,7 +3813,6 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
>>>   
>>>   	clear_siginfo(&info);
>>>   	info.si_signo = sig;
>>> -	info.si_errno = 0;
>>>   	info.si_code = SI_TKILL;
>>>   	info.si_pid = task_tgid_vnr(current);
>>>   	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
>>> -- 
>>> 2.26.2
>>>
>>

