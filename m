Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97E828CA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403826AbgJMIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:22:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33922 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387812AbgJMIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:22:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id x1so19956015eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=7Mr/IpyO39x/wXZWrbKBxs4XSCbr3YJ8rQ8o5CGbaFE=;
        b=m1kdmklgg/BLs69nYg+dz9zJUW9JzsUFeSliQKtPAJPANAgs8SxXqrM32CoJad8lAC
         //xhnlH62vrik4cWT2siQsAH/y9RD8o/xzQ+SWCo6k1XM4K3T9UcxwDsRbFnPS77+fa1
         YFI8Z48CzcaGXPMXr5ACqBPAAdWk+q2YuJiYXArdXgQWG0OFO0VW3/ytOaIcZaDazAb7
         W5ZqRPAWmM5mUqcBxcl8m7affXL6pzzqjuwLOtvbU77Dbj8XcG/3jlVimIkHMz7BroWe
         ByqdXKXhZDne+xfOm1xYDu4joYVipoKEn+MUhLVWCIIx+Apx8Rclagf+pNPdKezu1HDD
         h+kg==
X-Gm-Message-State: AOAM5331BUn1NitU4sQlFxACbwLsy3D25Pjy+Tb3dv8QLfWbHMe6TjzU
        frKBEmdFdMyh8VVGpt8kGO8=
X-Google-Smtp-Source: ABdhPJyAODxU4xa1HhqPdZH44UxoJNlz4LC7DjDYXaSSRyfsbfOK3SPeHriQxMHD+9n7cykm/9/Pfg==
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr18746108edq.315.1602577345172;
        Tue, 13 Oct 2020 01:22:25 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id ok21sm5416096ejb.96.2020.10.13.01.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:22:24 -0700 (PDT)
References: <20201012163140.371688-1-hsiang023167@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     dietmar.eggemann@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
In-reply-to: <20201012163140.371688-1-hsiang023167@gmail.com>
Message-ID: <87blh6iljc.derkling@matbug.net>
Date:   Tue, 13 Oct 2020 10:21:11 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yun,
thanks for sharing this new implementation.

On Mon, Oct 12, 2020 at 18:31:40 +0200, Yun Hsiang <hsiang023167@gmail.com> wrote...

> If the user wants to stop controlling uclamp and let the task inherit
> the value from the group, we need a method to reset.
>
> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> sched_setattr syscall.

Looks like what you say here is not what you code, since you actually
add two new flags, _RESET_{MIN,MAX}.

I think we value instead a simple user-space interface where just the
additional one flag _RESET should be good enough.

> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> ---
>  include/uapi/linux/sched.h |  9 ++++++++-
>  kernel/sched/core.c        | 16 ++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 3bac0a8ceab2..a12e88c362d8 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -132,6 +132,9 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_UTIL_CLAMP_RESET_MIN	0x80
> +#define SCHED_FLAG_UTIL_CLAMP_RESET_MAX	0x100

What about adding just SCHED_FLAG_UTIL_CLAMP_RESET 0x08 ...

>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
> @@ -139,10 +142,14 @@ struct clone_args {
>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
>  				 SCHED_FLAG_UTIL_CLAMP_MAX)

... making it part of SCHED_FLAG_UTIL_CLAMP ...

>  
> +#define SCHED_FLAG_UTIL_CLAMP_RESET (SCHED_FLAG_UTIL_CLAMP_RESET_MIN | \
> +					SCHED_FLAG_UTIL_CLAMP_RESET_MAX)
> +
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
>  			 SCHED_FLAG_DL_OVERRUN		| \
>  			 SCHED_FLAG_KEEP_ALL		| \
> -			 SCHED_FLAG_UTIL_CLAMP)
> +			 SCHED_FLAG_UTIL_CLAMP		| \
> +			 SCHED_FLAG_UTIL_CLAMP_RESET)


... and use it in conjunction with the existing _CLAMP_{MIN,MAX} to know
which clamp should be reset?


>  #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..ed4cb412dde7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1207,15 +1207,22 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  		uclamp_se_set(uc_se, clamp_value, false);
>  	}
>  
> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> +	if (likely(!(attr->sched_flags &
> +			(SCHED_FLAG_UTIL_CLAMP | SCHED_FLAG_UTIL_CLAMP_RESET))))
>  		return;

This check will not be changed, while we will have to add a bypass in
uclamp_validate().

>  
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET_MIN) {
> +		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> +			      0, false);
> +	} else if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
>  	}
>

These checks also will have to be updated to check _RESET and
_{MIN,MAX} combinations.

Bonus point would be to be possible to pass in just the _RESET flag if
we want to reset both clamps. IOW, passing in _RESET only should be
consumed as if we passed in _RESET|_MIN|_MAX.

Caveat, RT tasks have got a special 'reset value' for _MIN.
We should check and ensure __uclamp_update_uti_min_rt_default() is
property called for those tasks, which likely will require some
additional refactoring :/

> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET_MAX) {
> +		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> +			      1024, false);
> +	} else if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>  			      attr->sched_util_max, true);
>  	}
> @@ -4901,7 +4908,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  			goto change;
>  		if (dl_policy(policy) && dl_param_changed(p, attr))
>  			goto change;
> -		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> +		if (attr->sched_flags &
> +				(SCHED_FLAG_UTIL_CLAMP | SCHED_FLAG_UTIL_CLAMP_RESET))
>  			goto change;
>  
>  		p->sched_reset_on_fork = reset_on_fork;

