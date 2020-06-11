Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0291F69B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgFKOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 10:12:16 -0400
Received: from foss.arm.com ([217.140.110.172]:53144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgFKOMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:12:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C331A1F1;
        Thu, 11 Jun 2020 07:12:15 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3803F6CF;
        Thu, 11 Jun 2020 07:12:14 -0700 (PDT)
References: <20200609123748.18636-1-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, iwtbavbm@gmail.com
Subject: Re: [PATCH v2] sched/fair: fix nohz next idle balance
In-reply-to: <20200609123748.18636-1-vincent.guittot@linaro.org>
Date:   Thu, 11 Jun 2020 15:12:11 +0100
Message-ID: <jhjpna53d50.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/06/20 13:37, Vincent Guittot wrote:
> With commit:
>   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> rebalance_domains of the local cfs_rq happens before others idle cpus have
> updated nohz.next_balance and its value is overwritten.
>
> Move the update of nohz.next_balance for other idles cpus before balancing
> and updating the next_balance of local cfs_rq.
>
> Also, the nohz.next_balance is now updated only if all idle cpus got a
> chance to rebalance their domains and the idle balance has not been aborted
> because of new activities on the CPU. In case of need_resched, the idle
> load balance will be kick the next jiffie in order to address remaining
> ilb.
>
> Reported-by: Peng Liu <iwtbavbm@gmail.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

FWIW:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Do we want a Fixes: tag for this? I'm thinking
b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")
