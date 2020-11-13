Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328E12B2189
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKMRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgKMRG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:06:57 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204A621D1A;
        Fri, 13 Nov 2020 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605287216;
        bh=jxrsetvXvF40pvVmBFCblOz9uKz1shtGKlBiFLqjRkU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KUccD8fXUkWkX4ppCDwKMAfmb1Nq46Gl/b3bD878B8wSV1kL56H3INDaeBuEuVF4q
         zt2TmcDygUBfFipKTp7iCxpdEPwHqEtGPxXDkvFlaWkOzcSH35meNfmyzyzlQk+cMj
         Y9AsY8BsO/ChSPD4RsnlREiN8JvfyvPGzz86oUM8=
Message-ID: <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
Subject: Re: [PATCH RT 1/5] net: Properly annotate the try-lock for the
 seqlock
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Mike Galbraith <efault@gmx.de>, stable-rt@vger.kernel.org
Date:   Fri, 13 Nov 2020 11:06:53 -0600
In-Reply-To: <20201110154024.958923729@goodmis.org>
References: <20201110153853.463368981@goodmis.org>
         <20201110154024.958923729@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2020-11-10 at 10:38 -0500, Steven Rostedt wrote:
> 5.4.74-rt42-rc2 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> In patch
>    ("net/Qdisc: use a seqlock instead seqcount")
> 
> the seqcount has been replaced with a seqlock to allow to reader to
> boost the preempted writer.
> The try_write_seqlock() acquired the lock with a try-lock but the
> seqcount annotation was "lock".
> 
> Opencode write_seqcount_t_begin() and use the try-lock annotation for
> lockdep.
> 
> Reported-by: Mike Galbraith <efault@gmx.de>
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/seqlock.h   |  9 ---------
>  include/net/sch_generic.h | 10 +++++++++-
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index e5207897c33e..f390293974ea 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -489,15 +489,6 @@ static inline void write_seqlock(seqlock_t *sl)
>  	__raw_write_seqcount_begin(&sl->seqcount);
>  }
>  
> -static inline int try_write_seqlock(seqlock_t *sl)
> -{
> -	if (spin_trylock(&sl->lock)) {
> -		__raw_write_seqcount_begin(&sl->seqcount);
> -		return 1;
> -	}
> -	return 0;
> -}
> -
>  static inline void write_sequnlock(seqlock_t *sl)
>  {
>  	__raw_write_seqcount_end(&sl->seqcount);
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index e6afb4b9cede..112d2dca8b08 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -168,8 +168,16 @@ static inline bool qdisc_run_begin(struct Qdisc
> *qdisc)
>  		return false;
>  	}
>  #ifdef CONFIG_PREEMPT_RT
> -	if (try_write_seqlock(&qdisc->running))
> +	if (spin_trylock(&qdisc->running.lock)) {
> +		seqcount_t *s = &qdisc->running.seqcount;
> +		/*
> +		 * Variant of write_seqcount_t_begin() telling lockdep
> that a
> +		 * trylock was attempted.
> +		 */
> +		__raw_write_seqcount_begin(s);
> +		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
>  		return true;
> +	}
>  	return false;
>  #else
>  	/* Variant of write_seqcount_begin() telling lockdep a trylock

I applied this to 4.19 and saw some splat with my 'debug-full'
configuration, so tried 5.4 and saw the same thing:

[   30.573698] BUG: workqueue leaked lock or atomic: kworker/1:4/0x00000000/143
                    last function: wireless_nlevent_process
[   30.573707] 1 lock held by kworker/1:4/143:
[   30.573708]  #0: ffffffff8e981d80 (noop_qdisc.running#2){+.+.}, at: __do_softirq+0xca/0x561
[   30.573715] CPU: 1 PID: 143 Comm: kworker/1:4 Not tainted 5.4.74-rt42-rt-test-full-debug #1
[   30.573716] Hardware name: LENOVO 4236L51/4236L51, BIOS 83ET59WW (1.29 ) 06/01/2011
[   30.573720] Workqueue: events wireless_nlevent_process
[   30.573721] Call Trace:
[   30.573724]  dump_stack+0x71/0x9b
[   30.573728]  process_one_work+0x533/0x760
[   30.573731]  worker_thread+0x39/0x3f0
[   30.573733]  ? process_one_work+0x760/0x760
[   30.573734]  kthread+0x165/0x180
[   30.573736]  ? __kthread_create_on_node+0x180/0x180
[   30.573737]  ret_from_fork+0x3a/0x50
[   30.629329] wlp3s0: authenticate with 84:1b:5e:41:5e:4d
[   30.634864] wlp3s0: send auth to 84:1b:5e:41:5e:4d (try 1/3)
[   30.638433] wlp3s0: authenticated
[   30.642250] wlp3s0: associate with 84:1b:5e:41:5e:4d (try 1/3)
[   30.645704] wlp3s0: RX AssocResp from 84:1b:5e:41:5e:4d (capab=0x411 status=0 aid=6)
[   30.650803] wlp3s0: associated

[   30.656764] ================================================
[   30.656765] WARNING: lock held when returning to user space!
[   30.656766] 5.4.74-rt42-rt-test-full-debug #1 Not tainted
[   30.656767] ------------------------------------------------
[   30.656768] wpa_supplicant/836 is leaving the kernel with locks still held!
[   30.656769] 1 lock held by wpa_supplicant/836:
[   30.656770]  #0: ffff98f1c9622280 (&dev->qdisc_running_key){+.+.}, at: packet_sendmsg+0xec1/0x1ad0

Let me know if you want me to send you my .config or the full output (a
bunch more of the above).

Thanks,

Tom

