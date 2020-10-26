Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306E1298A32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422427AbgJZKPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:15:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768371AbgJZJr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 629AE30E;
        Mon, 26 Oct 2020 02:47:28 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AFB53F719;
        Mon, 26 Oct 2020 02:47:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Yun Hsiang <hsiang023167@gmail.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net
References: <20201025073632.720393-1-hsiang023167@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
Date:   Mon, 26 Oct 2020 10:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201025073632.720393-1-hsiang023167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2020 08:36, Yun Hsiang wrote:
> If the user wants to stop controlling uclamp and let the task inherit
> the value from the group, we need a method to reset.
> 
> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> sched_setattr syscall.
> 
> The policy is
> _CLAMP_RESET                           => reset both min and max
> _CLAMP_RESET | _CLAMP_MIN              => reset min value
> _CLAMP_RESET | _CLAMP_MAX              => reset max value
> _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> 
> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>

[...]

> @@ -1451,7 +1464,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
>  
>  		/* Keep using defined clamps across class changes */
> -		if (uc_se->user_defined)
> +		if (flags != SCHED_FLAG_UTIL_CLAMP_RESET &&
> +				uc_se->user_defined)
>  			continue;

With:

(1) _CLAMP_RESET                           => reset both min and max
(2) _CLAMP_RESET | _CLAMP_MIN              => reset min value
(3) _CLAMP_RESET | _CLAMP_MAX              => reset max value
(4) _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max

If you reset an RT task with (1) you don't reset its uclamp.min value.

__uclamp_update_util_min_rt_default(p) doesn't know about
SCHED_FLAG_UTIL_CLAMP_RESET. It only knows user_defined and will bail early.

[...]

> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> +	if (likely(!flags || flags == SCHED_FLAG_UTIL_CLAMP_RESET))
>  		return;
>  
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +	if (flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		if (reset) {
> +			clamp_value = __default_uclamp_value(p, UCLAMP_MIN);
> +			user_defined = false;
> +		} else {
> +			clamp_value = attr->sched_util_min;
> +			user_defined = true;
> +		}

Why do you reset for (1) in the for_each_clamp_id(clamp_id) loop and for
(2)-(4) in the if (flags & SCHED_FLAG_UTIL_CLAMP_MXX) condition?

You could reset (1)-(4) in the for_each_clamp_id(clamp_id) loop? In this
case you wouldn't need __default_uclamp_value().

[...]
