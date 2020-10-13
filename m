Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD228CFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgJMOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:15:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbgJMOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:15:13 -0400
Date:   Tue, 13 Oct 2020 16:15:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602598510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYacgbXKXIghmtFdPVa5sF41PCDiy4UY9D7P0jt1jbk=;
        b=tMTQJmXJIOQDjAn9dYT21+0G8Z5gXgNkV0pGGS3TX+bBTwS6+qje0M59rsHjkLKJAnzIRb
        mP7qwK8zjG6JfK9oiOaynPDmUX6J94EASOL7eTVGaU0VHB+ATi/NGthapqW+vA/hX9DOHK
        nPZUX9ny09CWzygxfNK9fWy0wcOveRYxdTt9VWWcvow4T4jV+2iKvYJL5wOr7D0ejsPnfQ
        I7TC5e3hy1XvjyspavCDxQvp0HS40TX0G4vsEwNWNOmO76wSSERRzOPsGpvQLU9o/Ulknk
        Y1lauAdQYreHao3ybw15xSxi5uxcAADTjx1OuqOaP97EX41wLDDJ4CRvYmIZbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602598510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYacgbXKXIghmtFdPVa5sF41PCDiy4UY9D7P0jt1jbk=;
        b=vLEDxH4tmIykBhYqQwSG9gRU69rfY3t6Q74sgsg8hU7onhTnp+69HZkxanaV2c7Q9za44Z
        jCB6AHCf0mUB/FDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH 1/2] sched: Deny self-issued __set_cpus_allowed_ptr()
 when migrate_disable()
Message-ID: <20201013141508.u7saiudjyuvihvcx@linutronix.de>
References: <20201005145717.346020688@infradead.org>
 <20201013140116.26651-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013140116.26651-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-13 15:01:15 [+0100], Valentin Schneider wrote:
>   migrate_disable();
>   set_cpus_allowed_ptr(current, {something excluding task_cpu(current)});
>   affine_move_task(); <-- never returns
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4ccd1099adaa..7f4e38819de1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2189,6 +2189,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
>  		goto out;
>  
> +	if (p == current &&
> +	    is_migration_disabled(p) &&
> +	    !cpumask_test_cpu(task_cpu(p), new_mask))
> +		ret = -EBUSY;
> +

This shouldn't happen, right? The function may sleep so it shouldn't be
entered with disabled migration. A WARN_ON might spot the bad caller.

Sebastian
