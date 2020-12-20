Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798F42DF5F9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgLTPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgLTPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:43:54 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:43:11 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 11so4998255pfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f2K9z82uKLQRqxlPI5YC0r+MUup62BfY2UmSYqpCXHw=;
        b=TCPqZVloeEYbIsnBdKiOmLpNUvfrePtpCyWhM+NkKLlKsFyROcy2uhTn10Q5INz4e8
         bdcqc4wqgq48agwZHQCk3Dfa0DL7VjrosrwH38pMl+sSK/Nj+QTfncQhpVDVSkcn/zzZ
         bQko0Da0r+mnclK9n1qXbxdUhC6mf6HvGU0rRbVCqWz6STYpEb3Ye7o3sRX3Vro/57Vl
         S3gDnWUFQFGPbBXWMXSyPGr7+i2dZx10jKzQr0cFh8jplwN497RJg7ud2746iZ0H/ndn
         kK7OUTElUkppxY1a8yr1vWN4nJ7oqwGD79w23Wvt7KqYfRaNp1cx/d5CBKjJUFeBzbGn
         HT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2K9z82uKLQRqxlPI5YC0r+MUup62BfY2UmSYqpCXHw=;
        b=GZAB/4AWW1BbHZ6wa+ykQXy86fsiQaPiuqppJ4S3eJTgexvFHd8Fi6NW2OSUVAsExN
         mrFecFKHhuVeC03BwKfSkOwHhMVmCB3/JKTs9XenAkfda4p42pl6xbTwByyw5LNt8W5s
         /3SsIkf/ouBOC5cHFGntw4IwKKD2JXwzVvk3Ax9RIxzinMLtAdqEbH9/5r3kw2DohBTo
         0t01yLU0pgdv/nW2Bh04m19c2oNJ0aQlhXjCRsHSoBrfqr01R2b1RLLfsKgTXALyVztl
         x4BYbQXcF6PLJnK4fs3MvTr2yCAHjRKyRp6q64s7eZYbiDdWeiB4iGx/+ee+1ZGpGEwF
         fKRA==
X-Gm-Message-State: AOAM532mO1MLrf7NF/URJ0Lkm5QmFcdzT1BjPTdIT1EHhJLCCB3hmOWT
        AU/cnvPyJdZj9O2NNyjU6fw=
X-Google-Smtp-Source: ABdhPJzvGGthomWXqQvKwgHmDHkkrcklt86wXTrdWXlu7Gby6xPHyx3lpGf0JMU+ji6Zj9ULULvGgw==
X-Received: by 2002:a62:80ce:0:b029:19d:b280:5019 with SMTP id j197-20020a6280ce0000b029019db2805019mr11760836pfd.43.1608478990900;
        Sun, 20 Dec 2020 07:43:10 -0800 (PST)
Received: from rae.kim ([122.37.26.177])
        by smtp.gmail.com with ESMTPSA id g5sm14344644pfr.87.2020.12.20.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 07:43:10 -0800 (PST)
Sender: Rae Kim <raekim@gmail.com>
Date:   Mon, 21 Dec 2020 00:43:05 +0900
From:   Rae Kim <rae.kim@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Leesoo Ahn <dev@ooseel.net>, linux-kernel@vger.kernel.org,
        Leesoo Ahn <lsahn@ooseel.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] signal: Don't init struct kernel_siginfo fields to zero
 again
Message-ID: <20201220154305.ixlm4mwesyfexq57@rae.kim>
References: <20201220074555.12655-1-lsahn@ooseel.net>
 <20201220142134.GB16470@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220142134.GB16470@redhat.com>
User-Agent: NeoMutt/20201127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like compiler optimization is smart enough to know that
assigning zero is unnecessary after clear_siginfo() which is memset()
under the hood. At least in my x86_64 machine, w/ or w/o this patch,
there is no difference in final compiled machine code. (I've compared
"objdump -d" results for "__send_signal()", "do_tkill()", and
"collect_signal()")

Wouldn't it be nicer to have more information for both human and
compiler since it doesn't generate extra machine code?

On Sun, Dec 20, 2020 at 03:21:35PM +0100, Oleg Nesterov wrote:
> On 12/20, Leesoo Ahn wrote:
> >
> > clear_siginfo() is responsible for clearing struct kernel_siginfo object.
> > It's obvious that manually initializing those fields is needless as
> > a commit[1] explains why the function introduced and its guarantee that
> > all bits in the struct are cleared after it.
> >
> > [1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")
> >
> > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> > ---
> >  kernel/signal.c | 21 ---------------------
> >  1 file changed, 21 deletions(-)
> > 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 5736c55aaa1a..8f49fa3ade33 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -603,10 +603,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
> >  		 */
> >  		clear_siginfo(info);
> >  		info->si_signo = sig;
> > -		info->si_errno = 0;
> >  		info->si_code = SI_USER;
> > -		info->si_pid = 0;
> > -		info->si_uid = 0;
> >  	}
> >  }
> >  
> > @@ -1120,7 +1117,6 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
> >  		case (unsigned long) SEND_SIG_NOINFO:
> >  			clear_siginfo(&q->info);
> >  			q->info.si_signo = sig;
> > -			q->info.si_errno = 0;
> >  			q->info.si_code = SI_USER;
> >  			q->info.si_pid = task_tgid_nr_ns(current,
> >  							task_active_pid_ns(t));
> > @@ -1133,10 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
> >  		case (unsigned long) SEND_SIG_PRIV:
> >  			clear_siginfo(&q->info);
> >  			q->info.si_signo = sig;
> > -			q->info.si_errno = 0;
> >  			q->info.si_code = SI_KERNEL;
> > -			q->info.si_pid = 0;
> > -			q->info.si_uid = 0;
> >  			break;
> >  		default:
> >  			copy_siginfo(&q->info, info);
> > @@ -1623,10 +1616,7 @@ void force_sig(int sig)
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = sig;
> > -	info.si_errno = 0;
> >  	info.si_code = SI_KERNEL;
> > -	info.si_pid = 0;
> > -	info.si_uid = 0;
> >  	force_sig_info(&info);
> >  }
> >  EXPORT_SYMBOL(force_sig);
> > @@ -1659,7 +1649,6 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = sig;
> > -	info.si_errno = 0;
> >  	info.si_code  = code;
> >  	info.si_addr  = addr;
> >  #ifdef __ARCH_SI_TRAPNO
> > @@ -1691,7 +1680,6 @@ int send_sig_fault(int sig, int code, void __user *addr
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = sig;
> > -	info.si_errno = 0;
> >  	info.si_code  = code;
> >  	info.si_addr  = addr;
> >  #ifdef __ARCH_SI_TRAPNO
> > @@ -1712,7 +1700,6 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
> >  	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
> >  	clear_siginfo(&info);
> >  	info.si_signo = SIGBUS;
> > -	info.si_errno = 0;
> >  	info.si_code = code;
> >  	info.si_addr = addr;
> >  	info.si_addr_lsb = lsb;
> > @@ -1726,7 +1713,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
> >  	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
> >  	clear_siginfo(&info);
> >  	info.si_signo = SIGBUS;
> > -	info.si_errno = 0;
> >  	info.si_code = code;
> >  	info.si_addr = addr;
> >  	info.si_addr_lsb = lsb;
> > @@ -1740,7 +1726,6 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = SIGSEGV;
> > -	info.si_errno = 0;
> >  	info.si_code  = SEGV_BNDERR;
> >  	info.si_addr  = addr;
> >  	info.si_lower = lower;
> > @@ -1755,7 +1740,6 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = SIGSEGV;
> > -	info.si_errno = 0;
> >  	info.si_code  = SEGV_PKUERR;
> >  	info.si_addr  = addr;
> >  	info.si_pkey  = pkey;
> > @@ -1934,7 +1918,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = sig;
> > -	info.si_errno = 0;
> >  	/*
> >  	 * We are under tasklist_lock here so our parent is tied to
> >  	 * us and cannot change.
> > @@ -2033,7 +2016,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = SIGCHLD;
> > -	info.si_errno = 0;
> >  	/*
> >  	 * see comment in do_notify_parent() about the following 4 lines
> >  	 */
> > @@ -2506,7 +2488,6 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
> >  	if (signr != info->si_signo) {
> >  		clear_siginfo(info);
> >  		info->si_signo = signr;
> > -		info->si_errno = 0;
> >  		info->si_code = SI_USER;
> >  		rcu_read_lock();
> >  		info->si_pid = task_pid_vnr(current->parent);
> > @@ -3660,7 +3641,6 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
> >  {
> >  	clear_siginfo(info);
> >  	info->si_signo = sig;
> > -	info->si_errno = 0;
> >  	info->si_code = SI_USER;
> >  	info->si_pid = task_tgid_vnr(current);
> >  	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > @@ -3833,7 +3813,6 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
> >  
> >  	clear_siginfo(&info);
> >  	info.si_signo = sig;
> > -	info.si_errno = 0;
> >  	info.si_code = SI_TKILL;
> >  	info.si_pid = task_tgid_vnr(current);
> >  	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > -- 
> > 2.26.2
> > 
> 
