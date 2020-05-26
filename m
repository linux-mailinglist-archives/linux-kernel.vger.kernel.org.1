Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542B21BC1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgD1Oxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 10:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgD1Oxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:53:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936FB205C9;
        Tue, 28 Apr 2020 14:53:36 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:53:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Daniel Wagner <wagi@monom.org>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH -rt] hrtimer: fix logic for when grabbing
 softirq_expiry_lock can be elided
Message-ID: <20200428105335.16011a4a@gandalf.local.home>
In-Reply-To: <20200428144026.5882-1-rasmus.villemoes@prevas.dk>
References: <20200428144026.5882-1-rasmus.villemoes@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 16:40:26 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> Commit
> 
>   hrtimer: Add a missing bracket and hide `migration_base' on !SMP
> 
> which is 47b6de0b7f22 in 5.2-rt and 40aae5708e7a in 4.19-rt,
> inadvertently changed the logic from base != &migration_base to base
> == &migration_base.
> 
> On !CONFIG_SMP, the effect was to effectively always elide this
> lock/unlock pair (since is_migration_base() is unconditionally false),
> which for me consistently causes lockups during reboot, and reportedly
> also often causes a hang during boot.
> 
> Adding this logical negation (or, what is effectively the same thing
> on !CONFIG_SMP, reverting the above commit as well as "hrtimer:
> Prevent using hrtimer_grab_expiry_lock() on migration_base") fixes
> that lockup.
> 
> Fixes: 40aae5708e7a (hrtimer: Add a missing bracket and hide `migration_base' on !SMP) # 4.19-rt
> Fixes: 47b6de0b7f22 (hrtimer: Add a missing bracket and hide `migration_base' on !SMP) # 5.2-rt
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> Something like this? I wasn't sure what Fixes: tag(s) to include, if
> any. It's quite possible the same fix is needed on earlier -rt
> kernels, I didn't check.
> 
>  kernel/time/hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index e54a95de8b79..c3966c090246 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
>  {
>  	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
>  
> -	if (timer->is_soft && is_migration_base(base)) {
> +	if (timer->is_soft && !is_migration_base(base)) {

That was my sloppiness in not seeing that 5.2-rt had == and 4.19 had !=.

Thanks for tracking this down!

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  		spin_lock(&base->cpu_base->softirq_expiry_lock);
>  		spin_unlock(&base->cpu_base->softirq_expiry_lock);
>  	}

