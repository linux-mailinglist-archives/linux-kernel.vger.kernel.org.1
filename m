Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449B82AF9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKKU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKU1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:27:12 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20730C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:27:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so2370710pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HFbcfghrXl/4oELlWns8aLXCM0wCJzjklzVvbre9mS0=;
        b=i7xHcbVHlMh+l+Mh/dgtYoaVdDJQysJVYSWkJD6/29rhevjco7bnVs16js7zNcTtqJ
         IhZF3E4neHZ3WXmN62faoMbEv05Ai/RrLaFn+l0QR6VEbiiTxckYGurS7acTcoI0c5Pd
         0+SR/j1xtr5HJ2T76ByDCBDMn6PrL4JewJRGjJI6poLrLhjszbLoMyAd7tVefl4aAr/3
         0G+o21tgTKor6E7Gd45jZqSKsCd99kIsMTM2u1MsZLGcvkj+MYUXTL66QCHZbficuXlN
         EjCTEoKZwFn2BP7Hte1hohXxmoZSzIPIQ7LJxrSe7fLQR8u6Cdm6enyzIySPJtpnFem/
         4KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HFbcfghrXl/4oELlWns8aLXCM0wCJzjklzVvbre9mS0=;
        b=mkr7uuFP6MhsvQFjwyOiYorLcUY/CK/hv7a87PDh5bLou0f93EgnbBy5z+WT2hC42m
         8OXCJm8sbuovf9vDlMR+dBme7fZzHxWUDl1CLVoZBuO+RRw+l/Aa/ekskIhOYkTMQpYW
         QF+cequVs7tgNFgVU5YADWbESgQlmaQgiWTvDW+qlr2Aa/jEIrPXStrmgWI47m77/1YB
         yXKEtAq0JLjq4R04IXIoCLmJ1znukFo0M2ZMo8TvEggqFqw8oWKq3FeBk3YPINFuEDwu
         A4xMM9gb50/lW4XOf3+VGMDQF4UHQhI6rxFxbxaFCD5/ZtZvC0xznbO8J9XRtfXGuxYw
         9nrA==
X-Gm-Message-State: AOAM533frtcZQmeONHwW4/Lpf3UNc8JGucXiYaaeZ+A3wKAHXswheVCC
        narQES1HgAjbe0Bw7n4PVH1NLBA+keC0ow==
X-Google-Smtp-Source: ABdhPJzOAz6A6oJLsIV2oUVKwkn196np51B9p4Q7OX+Q9/3HJ8QeRUAGaHDzGPFZLnLDH2D/yBWpyQ==
X-Received: by 2002:a62:86c9:0:b029:18b:e117:3cb7 with SMTP id x192-20020a6286c90000b029018be1173cb7mr19513297pfd.62.1605126431151;
        Wed, 11 Nov 2020 12:27:11 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id u197sm3714329pfc.127.2020.11.11.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:27:10 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Reorder throttle_cfs_rq() path
References: <f11dd2e3ab35cc538e2eb57bf0c99b6eaffce127.1604973978.git.rocking@linux.alibaba.com>
Date:   Wed, 11 Nov 2020 12:27:07 -0800
In-Reply-To: <f11dd2e3ab35cc538e2eb57bf0c99b6eaffce127.1604973978.git.rocking@linux.alibaba.com>
        (Peng Wang's message of "Tue, 10 Nov 2020 10:11:59 +0800")
Message-ID: <xm26imab3ahw.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Wang <rocking@linux.alibaba.com> writes:

> As commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for
> leaf_cfs_rq list") does in unthrottle_cfs_rq(), throttle_cfs_rq()
> can also use the same pattern as dequeue_task_fair().
>
> There is no functional changes.

It's generally a bit more hassle and less clear, but the parallel to
dequeue_task_fair probably makes up for it.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e3..27a69af 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4779,25 +4779,37 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>  		/* throttled entity or throttle-on-deactivate */
>  		if (!se->on_rq)
> -			break;
> +			goto done;
>  
> -		if (dequeue) {
> -			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> -		} else {
> -			update_load_avg(qcfs_rq, se, 0);
> -			se_update_runnable(se);
> -		}
> +		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>  
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
>  
> -		if (qcfs_rq->load.weight)
> -			dequeue = 0;
> +		if (qcfs_rq->load.weight) {
> +			/* Avoid re-evaluating load for this entity: */
> +			se = parent_entity(se);
> +			break;
> +		}
>  	}
>  
> -	if (!se)
> -		sub_nr_running(rq, task_delta);
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> +		/* throttled entity or throttle-on-deactivate */
> +		if (!se->on_rq)
> +			goto done;
> +
> +		update_load_avg(qcfs_rq, se, 0);
> +		se_update_runnable(se);
>  
> +		qcfs_rq->h_nr_running -= task_delta;
> +		qcfs_rq->idle_h_nr_running -= idle_task_delta;
> +	}
> +
> +	/* At this point se is NULL and we are at root level*/
> +	sub_nr_running(rq, task_delta);
> +
> +done:
>  	/*
>  	 * Note: distribution will already see us throttled via the
>  	 * throttled-list.  rq->lock protects completion.
