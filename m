Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604302E1BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgLWLbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgLWLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:31:19 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F94C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:30:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o19so39414125lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBYdNW8Z4yi2ObUNArjSPg/6GZRX3BMgxb5wuc/+8YM=;
        b=udMKnRNSqCZ9VaPT8w+/uer0wFXYURGMXvgy4gF9jZieziZKK3X5ND3buV+GyBOrOV
         QmmNC3oQ59pRtzcWqu3UeNlesSzA3N5XEAmhZmyczK8cPmWO1sgQbvCDDp7tLecIHGYr
         7vbgnA7H6qqSnxCeaM64wjPHlCoF9QYQzFPCUiWQmZFlJr/KgqZe1sLz/f6c1ZWvEJ+n
         8gIlsOuP+EiWYt3X9KcmuAxdZ4fkigaEgnKifRhJw/8UAq9dSak+3E/1cV5eHmNT8Y62
         7gjjjFRLuv5cVTBfMbkhAsognqFhL6tlhnC+/uf8MhL39tEbPcQZb8pQz/OnCKnmSDN0
         CHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBYdNW8Z4yi2ObUNArjSPg/6GZRX3BMgxb5wuc/+8YM=;
        b=AgJ+lB9eiWgFU+AglMiVDCkXwA/dK++dUQn8EyJclmzebQqBGJkVB/FISB1vLpNveG
         gAiXLgd6uu24nHV3qk/a57hCkF+7iDrpQuZGg+R/G2zSRJC/CHOUGZewgNY58vMKL6qG
         AGWZwGMgto/HhH40JxlIRQDsRb02yDrZu6W+vqU3VgClJqJIDSlYqpm2QAqpG2AQmxNK
         fKjz+wafSN6eAOeG8B9udMga3hUMcdBwhNcOf9WVFgFJDnezwLwaYHCB1EdDclFdtBRX
         JFW+6rYPWoMWGv7oWL1dPXSQgS1jqZ90kkfBKxXL7AvwsxsD/ADrMOoqmmQY7KN+pSHi
         YmXQ==
X-Gm-Message-State: AOAM5327n8zMfPnfEGkv6QkJLCbws7mYJXHxvt5OAzfQ+o4MLz0ukwac
        9VWBn8grSglPM2Dl/LWkWKdf3+JbRMXZ1bWHJoNaURF0oVoSzQ==
X-Google-Smtp-Source: ABdhPJycf3eEGhrmO9q23dPzmaPYHjf0H14zA5KsBeHAXZP7SZbwhQljRbUKVi16EUhnJb0N9nPX+QPRdWgmPdNNFCE=
X-Received: by 2002:a19:7718:: with SMTP id s24mr11290716lfc.277.1608723037614;
 Wed, 23 Dec 2020 03:30:37 -0800 (PST)
MIME-Version: 1.0
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
In-Reply-To: <1608710968-31475-1-git-send-email-ultrachin@163.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Dec 2020 12:30:26 +0100
Message-ID: <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
Subject: Re: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
To:     ultrachin@163.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        heddchen@tencent.com,
        =?UTF-8?B?eGlhb2dnY2hlbijpmYjlsI/lhYkp?= <xiaoggchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
>
> From: Chen Xiaoguang <xiaoggchen@tencent.com>
>
> Before a CPU switches from running SCHED_NORMAL task to
> SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other

Could you explain more in detail why you only care about this use case
in particular and not the general case?

> CPU by doing load_balance first.
>
> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> Signed-off-by: Chen He <heddchen@tencent.com>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae7ceba..0a26132 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7004,6 +7004,11 @@ struct task_struct *
>         struct task_struct *p;
>         int new_tasks;
>
> +       if (prev &&
> +           fair_policy(prev->policy) &&

Why do you need a prev and fair task  ? You seem to target the special
case of pick_next_task  but in this case why not only testing rf!=null
 to make sure to not return immediately after jumping to the idle
label?

Also why not doing that for default case too ? i.e. balance_fair() ?

> +           sched_idle_cpu(rq->cpu))
> +               goto idle;
> +
>  again:
>         if (!sched_fair_runnable(rq))
>                 goto idle;
> --
> 1.8.3.1
>
>
