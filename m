Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA311BC2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgD1PS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgD1PSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:18:53 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD5E2186A;
        Tue, 28 Apr 2020 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588087133;
        bh=b/zBXFGJvz7WjogAPSd0Y+ZzPKY0hHARxvv8R3hHUEw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EA4+tttAfKwyjtD+ShEj9VRYXd8WXJ7s0P4qoHxtBc3RVs2gastLvPr+mB0Kg0Hcx
         C5aaJru7EArpoREVcC61YXM/mc92dftH1wLZSdHOPUZis89rb+d9WD34HHrV57Fe/2
         HFZMLRd+zAmkES+HW4pwZWnTyuYDmtfmFjDC6ODY=
Message-ID: <5684baea7257bfe27960ead094fd346dae019b0a.camel@kernel.org>
Subject: Re: [PATCH -rt] hrtimer: fix logic for when grabbing
 softirq_expiry_lock can be elided
From:   Tom Zanussi <zanussi@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julien Grall <julien.grall@arm.com>,
        Daniel Wagner <wagi@monom.org>, John Kacur <jkacur@redhat.com>
Date:   Tue, 28 Apr 2020 10:18:50 -0500
In-Reply-To: <20200428144026.5882-1-rasmus.villemoes@prevas.dk>
References: <20200428144026.5882-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 16:40 +0200, Rasmus Villemoes wrote:
> Commit
> 
>   hrtimer: Add a missing bracket and hide `migration_base' on !SMP
> 
> which is 47b6de0b7f22 in 5.2-rt and 40aae5708e7a in 4.19-rt,
> inadvertently changed the logic from base != &migration_base to base
> == &migration_base.
> 
> On !CONFIG_SMP, the effect was to effectively always elide this
> lock/unlock pair (since is_migration_base() is unconditionally
> false),
> which for me consistently causes lockups during reboot, and
> reportedly
> also often causes a hang during boot.
> 
> Adding this logical negation (or, what is effectively the same thing
> on !CONFIG_SMP, reverting the above commit as well as "hrtimer:
> Prevent using hrtimer_grab_expiry_lock() on migration_base") fixes
> that lockup.
> 
> Fixes: 40aae5708e7a (hrtimer: Add a missing bracket and hide
> `migration_base' on !SMP) # 4.19-rt
> Fixes: 47b6de0b7f22 (hrtimer: Add a missing bracket and hide
> `migration_base' on !SMP) # 5.2-rt
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> Something like this? I wasn't sure what Fixes: tag(s) to include, if
> any. It's quite possible the same fix is needed on earlier -rt
> kernels, I didn't check.
> 

Yeah, looks good, I'll post a new update with this shortly.

Thanks,

Tom

>  kernel/time/hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index e54a95de8b79..c3966c090246 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct
> hrtimer *timer)
>  {
>  	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
>  
> -	if (timer->is_soft && is_migration_base(base)) {
> +	if (timer->is_soft && !is_migration_base(base)) {
>  		spin_lock(&base->cpu_base->softirq_expiry_lock);
>  		spin_unlock(&base->cpu_base->softirq_expiry_lock);
>  	}

