Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118A31A8496
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391420AbgDNQXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391389AbgDNQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:21:31 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:21:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l25so13888906qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qO1q6P7urcC/fAzNLncA31bdH5lHcyLQ+KsgAdpa1ZI=;
        b=BtbOfks/3jhe+uiHkAoG+/h6Du7PsbYryI8LlB8CftizsftXCwTaJpSReBQMxv3YND
         E3QFB2U1zdAjFRYgrhS2A/dQigxIw72J9gXp+lSyR9EfNJLi/XZwCgYoQ0Mn7D5+uMka
         cvaS3FFJaJ3V5YRmsdkVgYQAWCZuDcHzNT/Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qO1q6P7urcC/fAzNLncA31bdH5lHcyLQ+KsgAdpa1ZI=;
        b=EMbeHQNpk2nY/te8YpQ5bBaWfnHuq3sTvyzMG9eQGgTKS8TtORfakGgJdHrxN0SYc6
         InoBLqGd2ktQWQm55VJc2sFu5fuIMgP6oZbq3Zjg6GynrEk5RexGXilmcg6Q2vUXVIvJ
         /Nj0wTJ+IGG9X8q8C914/7vs3Bp4htz3HBpeRTx31VvobE4NvQ5FhdPtW7uPpVBK9NmE
         jOOm46lMh2lStyAM/c9IllOL2ObwJIQqjDk8k+Pcah0+wMXUMlcJNAn8yTI6yYVkaoOL
         xRsS8IU8HDNiTau9JYghTYzU3MQ6bR4dLjy914lorM28adMw6QvtY+wh50G2lc6tpu19
         yytA==
X-Gm-Message-State: AGi0Puao0Qr7DEpT3gXsy38o08UhpHOEFk0aNgUlERpIfxensS3Bd4/O
        /uah7D9+ueNkwrH1eFN5xgXeqA==
X-Google-Smtp-Source: APiQypKftdFMdNybcSMayepMnxyaCqgT55vJLwQmFq+2FmywXKI+awCZNld1vohh2HOQ2/MOEJaDFQ==
X-Received: by 2002:a37:4e0a:: with SMTP id c10mr16859737qkb.242.1586881289880;
        Tue, 14 Apr 2020 09:21:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m187sm656423qkc.30.2020.04.14.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:21:29 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:21:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200414162128.GA66453@google.com>
References: <20200414161320.251897-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161320.251897-1-qperret@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:13:20PM +0100, Quentin Perret wrote:
> uclamp_fork() resets the uclamp values to their default when the
> reset-on-fork flag is set. It also checks whether the task has a RT
> policy, and sets its uclamp.min to 1024 accordingly. However, during
> reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> hence leading to an erroneous uclamp.min setting for the new task if it
> was forked from RT.
> 
> Fix this by removing the unnecessary check on rt_policy() in
> uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> set.
> 
> Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..9ea3e484eea2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
>  	for_each_clamp_id(clamp_id) {
>  		unsigned int clamp_value = uclamp_none(clamp_id);
>  
> -		/* By default, RT tasks always get 100% boost */
> -		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> -

Shouldn't this be conditional on p->sched_reset_on_fork instead of deleting
the code?

thanks,

 - Joel


>  		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
>  	}
>  }
> -- 
> 2.26.0.110.g2183baf09c-goog
> 
