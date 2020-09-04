Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E401125CFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIDDb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgIDDbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:31:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13BC061244;
        Thu,  3 Sep 2020 20:31:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so3719521qtd.2;
        Thu, 03 Sep 2020 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3XehbrPYRfRYUCZ13XbEG2FB/0APg52ndRCkIBeff8I=;
        b=ONq6z4Rtfr0mqoWNUDNn+uiJu/F+nB1j+lmTZFPOdzJ7EpSBlW4+65Y7KPrNzNTay+
         L5+LAWRClVwkgBUxOYeGSO8zkwt96J4HUJjwkncvE/n6ol5H3F7HDFyU4+aV0AR8VA82
         yvqbmTQX+v1nwTupWaHZa/6j3zExUKUoe4RY4oMz8spi5rVwpi6ADoyWRaEeUgaaqu+/
         RsbDlEZYmjYDx+1DREDmMMJrTn7WYguJIpnjaCecemakWAjyMDrZG8XvYhDOg+5GFKTb
         lTaFe88KhamycwheHl/TEYf7tXmhEJjGkx2NEeXkHJ3WJ4wZl9DUMCKhMR3ADtyF8an2
         GdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3XehbrPYRfRYUCZ13XbEG2FB/0APg52ndRCkIBeff8I=;
        b=lQOlvFFTzlEi+5xaRPtrbWDNkPZoSx2fg4pSyce0xgmnsnV89Kxs9+eZ0yiccY3w5j
         dz/nngjWHxAhiQWw2AoYTsnPBV9nIAGr+NHXABIsqbLAZku7ymRWC4kbts9MZ/wdHl10
         BjpWK7XL8ZwwiWH8qy5B8HA+29PUraQzzJK6UeFnO1rNudV743oyKtVWxmpZAIMntjYM
         M/lI4Xbg/81APRW2muuT77qSeoczZMGA72fkn5mLhJffxGTP3sNRtrL+xbfdf0A2dfrg
         KlkuCDyeLsODssvrnF/fWsnb/sNfnfcYMCSrjFAFoPXWPx1N0/xTrzndZPgUlpAmFj53
         BDwA==
X-Gm-Message-State: AOAM532wlGHnA7EOWzC20vG13Q8qbOnb2SUDgnghH6f09I7vynaQJ53F
        C5PvWqof5T74ySkdcr/hkJc=
X-Google-Smtp-Source: ABdhPJzaTKiqJKuVCZPCElrgIOpiv5d6Uz/0jrPpMGW3V7yulFncqtybbESUJb4BHI/nEboIRfw1rg==
X-Received: by 2002:ac8:7b95:: with SMTP id p21mr6754715qtu.139.1599190284599;
        Thu, 03 Sep 2020 20:31:24 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y18sm3528037qkf.93.2020.09.03.20.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:31:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2D45127C0054;
        Thu,  3 Sep 2020 23:31:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 23:31:23 -0400
X-ME-Sender: <xms:CbVRXxFW47fUDIn7uNUFa569dFf0XzxHxULgUB4eF-hMXfugso_wOQ>
    <xme:CbVRX2UHwejbW8o2dbZ4gbN9i3MSNANj8HlHR_l1NBoR7I9Y1ugj1PwYdRIGzMPcD
    -6qLJ7-8R0FZwBwNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphephedvrdduheehrdduuddurdej
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:CbVRXzI8UeVS6iNNLMtFBk-mxMFCzdMSO1yaLGgIe04hiNBePBe48Q>
    <xmx:CbVRX3H5pr4nJg2rg_mAGDr3qhP4_b2b_FuUy8zp3Rh5Y7j2aZReDg>
    <xmx:CbVRX3V_o1_ui1FCeADVCxhPDGLlJU_pNaKFXxlnkcjNQjPZVDM-bQ>
    <xmx:C7VRX5bOkrWilOUuTQERFKKAP8s2OPuWI3YvZVkOg7nHIky6YCPOxgb6gw0>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBA14306005C;
        Thu,  3 Sep 2020 23:31:20 -0400 (EDT)
Date:   Fri, 4 Sep 2020 11:31:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH tip/core/rcu 3/4] kernel/smp: Provide CSD lock timeout
 diagnostics
Message-ID: <20200904033119.GC7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
 <20200831181417.1378-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831181417.1378-3-paulmck@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:14:16AM -0700, paulmck@kernel.org wrote:
[...]
> +static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> +{
> +	int cpu = -1;
> +	int cpux;
> +	bool firsttime;
> +	u64 ts2, ts_delta;
> +	call_single_data_t *cpu_cur_csd;
> +	unsigned int flags = READ_ONCE(csd->flags);
> +
> +	if (!(flags & CSD_FLAG_LOCK)) {
> +		if (!unlikely(*bug_id))
> +			return true;
> +		cpu = csd_lock_wait_getcpu(csd);
> +		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> +			 *bug_id, raw_smp_processor_id(), cpu);
> +		return true;
> +	}
> +
> +	ts2 = sched_clock();
> +	ts_delta = ts2 - *ts1;
> +	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
> +		return false;
> +
> +	firsttime = !*bug_id;
> +	if (firsttime)
> +		*bug_id = atomic_inc_return(&csd_bug_count);
> +	cpu = csd_lock_wait_getcpu(csd);
> +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> +		cpux = 0;
> +	else
> +		cpux = cpu;
> +	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 cpu, csd->func, csd->info);
> +	if (cpu_cur_csd && csd != cpu_cur_csd) {
> +		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
> +			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
> +			 READ_ONCE(per_cpu(cur_csd_info, cpux)));
> +	} else {
> +		pr_alert("\tcsd: CSD lock (#%d) %s.\n",
> +			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
> +	}
> +	if (cpu >= 0) {
> +		if (!trigger_single_cpu_backtrace(cpu))
> +			dump_cpu_task(cpu);
> +		if (!cpu_cur_csd) {
> +			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
> +			arch_send_call_function_single_ipi(cpu);
> +		}
> +	}
> +	dump_stack();
> +	*ts1 = ts2;
> +
> +	return false;
> +}
> +
>  /*
>   * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
>   *
> @@ -105,8 +205,28 @@ void __init call_function_init(void)
>   */
>  static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
> +	int bug_id = 0;
> +	u64 ts0, ts1;
> +
> +	ts1 = ts0 = sched_clock();
> +	for (;;) {
> +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> +			break;
> +		cpu_relax();
> +	}
> +	smp_acquire__after_ctrl_dep();

It's a little difficult here to figure out what operation we want to add
ACQUIRE semantics. So maybe a few lines of comments?

	/* 
  	 * Add the ACQUIRE semantics for the read of csd->flags in
	 * csd_lock_wait_toolong().
	 */

Regards,
Boqun

> +}
> +
> +#else
> +static void csd_lock_record(call_single_data_t *csd)
> +{
> +}
> +
> +static __always_inline void csd_lock_wait(call_single_data_t *csd)
> +{
>  	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
>  }
> +#endif
>  
[...]
