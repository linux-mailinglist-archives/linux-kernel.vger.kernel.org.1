Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB070284ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJFLUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:20:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:20:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D7B143D;
        Tue,  6 Oct 2020 04:20:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2D3F3F66B;
        Tue,  6 Oct 2020 04:20:08 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150921.759789837@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 08/17] sched: Massage set_cpus_allowed()
In-reply-to: <20201005150921.759789837@infradead.org>
Date:   Tue, 06 Oct 2020 12:20:03 +0100
Message-ID: <jhjy2kjmwik.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/20 15:57, Peter Zijlstra wrote:
> Thread a u32 flags word through the *set_cpus_allowed*() callchain.
> This will allow adding behavioural tweaks for future users.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
[...]
> @@ -1899,7 +1900,9 @@ extern void update_group_capacity(struct
>
>  extern void trigger_load_balance(struct rq *rq);
>
> -extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
> +#define SCA_CHECK		0x01
> +

That most likely needs to live outside of the #define CONFIG_SMP, so this
should be hoisted up - you already do that in the next patch, this should
be done here.

> +extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
>
>  #endif
>
