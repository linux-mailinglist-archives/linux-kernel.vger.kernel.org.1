Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8746B29EFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgJ2PbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:31:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgJ2P3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:29:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B142C1063;
        Thu, 29 Oct 2020 08:29:21 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 450763F66E;
        Thu, 29 Oct 2020 08:29:20 -0700 (PDT)
References: <20201029151103.373410-1-colin.king@canonical.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] sched/debug: fix memory corruption caused by multiple small reads of flags
In-reply-to: <20201029151103.373410-1-colin.king@canonical.com>
Date:   Thu, 29 Oct 2020 15:29:18 +0000
Message-ID: <jhjft5xoxtd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/20 15:11, Colin King wrote:
> Detected by running 'stress-ng --procfs 0' on 5.10-rc1; example splat:
>

That's definitely what I'll need to run next time I lay my dirty hands on
procfs.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209919
> Reported-by: Jeff Bastian <jbastian@redhat.com>
> Fixes: 5b9f8ff7b320 ("sched/debug: Output SD flag names rather than their values")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/debug.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 0655524..2357921 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -251,7 +251,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
>       unsigned long flags = *(unsigned long *)table->data;
>       size_t data_size = 0;
>       size_t len = 0;
> -	char *tmp;
> +	char *tmp, *buf;
>       int idx;
>
>       if (write)
> @@ -269,17 +269,17 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
>               return 0;
>       }
>
> -	tmp = kcalloc(data_size + 1, sizeof(*tmp), GFP_KERNEL);
[...]
> -	tmp += *ppos;
[...]
> -	kfree(tmp);

Yeah, that's downright sloppy :( I can't remember which one it was in a
hurry, but I was "inspired" by another proc handler somewhere; I'll try to
find out if there's any issue in that one or if I really cannot shift the
blame elsewhere.
