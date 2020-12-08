Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50B2D1EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgLHAJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgLHAJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:09:38 -0500
Date:   Tue, 8 Dec 2020 01:08:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607386137;
        bh=pq18e9ZiVwpEi32VyuK7sdM+hmzGVadlVgXoYMtFU5w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LigfSa9qFu0ATqUTZTo2bKQbQ8zlOeyw6lUP3dWtwAgXmcNLPRiJGaykw+stjJBjF
         YtyDxj4rcSIzaO3Iss9ykV6Bt2nUkbpmGsop7wVAm+Dlgb+PTcDyTHQroWTx3lTRcE
         PdoQnr70jk7pIejwcL0sDhOrfJAa/epL/8UPH2ufRRcfnBNB6EKNTHDeUvwZGUdPXh
         VdUwjvh/WHepM2wyFxkVWogX/wibm2sRJeGDhk44SNPMtbLf/uFtSM0WQN1CbSXvbt
         SkTu8VUFAtm2xHfrkfZN0ydRQaF2aMCkL7MKUzDW1oAYFRKwQyQhEOF7EHejXuHLqK
         mhJgkckXceiVg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201208000854.GA2877@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.114951971@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.114951971@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
> +static void __local_bh_enable(unsigned int cnt, bool unlock)
> +{
> +	unsigned long flags;
> +	int newcnt;
> +
> +	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
> +			    this_cpu_read(softirq_ctrl.cnt));

Less important since it's debug code, but still can be __this_cpu_read().

> +
> +	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
> +		raw_local_irq_save(flags);
> +		lockdep_softirqs_on(_RET_IP_);
> +		raw_local_irq_restore(flags);
> +	}
> +
> +	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
> +	current->softirq_disable_cnt = newcnt;
> +
> +	if (!newcnt && unlock) {
> +		rcu_read_unlock();
> +		local_unlock(&softirq_ctrl.lock);
> +	}
> +}
> +
> +static inline bool should_wake_ksoftirqd(void)
> +{
> +	return !this_cpu_read(softirq_ctrl.cnt);

And that too.

Other than these boring details:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
