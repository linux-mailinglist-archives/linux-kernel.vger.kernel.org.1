Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C12A0DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgJ3SsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3SsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:48:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F57FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:48:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so5948702pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8F5WIF+rCm3HVLXk14o4hZUWjT8TkBXwz225BVoVMOo=;
        b=V5le21VF1aguHNznBOtDgJlH/rrCU3HFYK7aikgZIAbNgoEOW0ivdC8Csv98f0oixz
         FxBK61iFqB3wRaShB3q19tpfqbC9e9RotV1ap2sbmEmLhc5mDmak7ner4PAHZ4TO4Xm8
         g/lqcPBVulnDxbJW2EJ7YiKqWasfBdX2IP5PJww7G9agCiUn9eEkhHDYjm7zbWd7uHv5
         Fkk8hA+Rm8FQWctUyHcVuThyIF7C/CHHHV7akdruEIcknxP2TZWMrfg59cFwPa/xnBua
         mnGJfuRGayZ5kPoh96JwwB/lj6Idk1P8gak6uYHcWffHbITGQEU0w/4GbeuGQL2Z8R7g
         L4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8F5WIF+rCm3HVLXk14o4hZUWjT8TkBXwz225BVoVMOo=;
        b=pv2FQiSbHpyVhptyD+UIy7qTO3z3pupbujugjLkw3gq8FLwp+pJFCsUNExmHsOAR8x
         ffRO1BuXBLnDMF99Hy2KuI6SnnvIThDUONzKzQkj70aKOtzHScn8oYWYI2OLYftcxCqi
         ryIVLWtn3rfVqLxwUn99xeViQWklv2+fLtV0mb1o1N0OdE9zYt+xh7QLNnJYB96Cv4QM
         NuAfD2GomSfOpciV48ciPX54MC0sMV1k+4OK7nZjkzfnq2Rt8Uk3QrRDhjcfofKrMUDT
         6bb4OJgc5QH2Plvb1kM6TjXmMDbZDwGezxk9M/XIOwFIj1tfGf8nA7RdrnR30el+w7rk
         SAbw==
X-Gm-Message-State: AOAM532Rxv8M8J0mXpyen0Udat4JN1sOX+yXlbF8fD2eDGgucF4ZsVT1
        KtvDmjkUqfCU1UtkwNHLX6C/Z+/tiOeWSg==
X-Google-Smtp-Source: ABdhPJyzfzNJmjkVrTIQ06rKeQxWsH3pBXsuziL7GjFGJpQqaNE3oPcu3UZyWtJiaMxB4I7DPOBtQw==
X-Received: by 2002:a17:90b:17c8:: with SMTP id me8mr4369298pjb.144.1604083684400;
        Fri, 30 Oct 2020 11:48:04 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id e2sm4355208pjw.13.2020.10.30.11.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:48:03 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Hui Su <sh_def@163.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove the spin_lock operations
References: <20201030144621.GA96974@rlk>
Date:   Fri, 30 Oct 2020 11:48:00 -0700
In-Reply-To: <20201030144621.GA96974@rlk> (Hui Su's message of "Fri, 30 Oct
        2020 22:46:21 +0800")
Message-ID: <xm26mu0335zz.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hui Su <sh_def@163.com> writes:

> Since 'ab93a4bc955b ("sched/fair: Remove
> distribute_running fromCFS bandwidth")',there is
> nothing to protect between raw_spin_lock_irqsave/store()
> in do_sched_cfs_slack_timer().
>
> So remove it.

Reviewed-by: Ben Segall <bsegall@google.com>

(I might nitpick the subject to be clear that it should be trivial
because the lock area is empty, or call them dead or something, but it's
not all that important)

>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e38378c..5ecbf5e63198 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5105,9 +5105,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  		return;
>  
>  	distribute_cfs_runtime(cfs_b);
> -
> -	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
>  
>  /*
