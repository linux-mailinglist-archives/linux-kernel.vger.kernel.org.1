Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A02292916
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgJSOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:15:09 -0400
Received: from foss.arm.com ([217.140.110.172]:58738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgJSOPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218D1D6E;
        Mon, 19 Oct 2020 07:15:08 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 725683F66E;
        Mon, 19 Oct 2020 07:15:06 -0700 (PDT)
Subject: Re: [PATCH 4/2] sched/cpupri: Add CPUPRI_HIGHER
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
 <20201014195437.GD2974@worktop.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <17c8a9b5-b63a-1a1a-f11b-5e00c2a6ad34@arm.com>
Date:   Mon, 19 Oct 2020 16:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014195437.GD2974@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 21:54, Peter Zijlstra wrote:
> 
> Add CPUPRI_HIGHER above the RT99 priority to denote the CPU is in use
> by higher priority tasks (specifically deadline).

sugov:X already triggers this now on our !fast-switching devices running
schedutil.

> XXX: we should probably drive PUSH-PULL from cpupri, that would
> automagically result in an RT-PUSH when DL sets cpupri to CPUPRI_HIGHER.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[...]

> @@ -54,6 +56,10 @@ static int convert_prio(int prio)

The BUG_ON could be tightened:

-       BUG_ON(prio >= MAX_PRIO);
+       BUG_ON(prio > MAX_RT_PRIO);

>  	case MAX_RT_PRIO-1:
>  		cpupri = CPUPRI_NORMAL;		/*  0 */
>  		break;
> +
> +	case MAX_RT_PRIO:
> +		cpupri = CPUPRI_HIGHER;		/* 100 */
> +		break;
>  	}
> 
>  	return cpupri;

Just saw that the comment for cpupri_set() needs changing:

@@ -205,7 +208,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct
task_struct *p,
  * cpupri_set - update the CPU priority setting
  * @cp: The cpupri context
  * @cpu: The target CPU
- * @newpri: The priority (INVALID-RT99) to assign to this CPU
+ * @newpri: The priority (INVALID-RT1-RT99-NORMAL-HIGHER) to assign to
this CPU

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
