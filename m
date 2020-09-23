Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14FC275A83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIWOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:43:49 -0400
Received: from foss.arm.com ([217.140.110.172]:47944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:43:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF7E11D4;
        Wed, 23 Sep 2020 07:43:48 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3072E3F73B;
        Wed, 23 Sep 2020 07:43:47 -0700 (PDT)
References: <20200921072424.14813-1-vincent.guittot@linaro.org> <20200921072424.14813-3-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH 2/4 v2] sched/fair: reduce minimal imbalance threshold
In-reply-to: <20200921072424.14813-3-vincent.guittot@linaro.org>
Date:   Wed, 23 Sep 2020 15:43:45 +0100
Message-ID: <jhjd02cmu3i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/09/20 08:24, Vincent Guittot wrote:
> The 25% default imbalance threshold for DIE and NUMA domain is large
> enough to generate significant unfairness between threads. A typical
> example is the case of 11 threads running on 2x4 CPUs. The imbalance of
> 20% between the 2 groups of 4 cores is just low enough to not trigger
> the load balance between the 2 groups. We will have always the same 6
> threads on one group of 4 CPUs and the other 5 threads on the other
> group of CPUS. With a fair time sharing in each group, we ends up with
> +20% running time for the group of 5 threads.
>
> Consider decreasing the imbalance threshold for overloaded case where we
> use the load to balance task and to ensure fair time sharing.
>
> Acked-by: Hillf Danton <hdanton@sina.com>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
