Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881012D74B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394869AbgLKLcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:32:10 -0500
Received: from foss.arm.com ([217.140.110.172]:51326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394860AbgLKLbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:31:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BECA31B;
        Fri, 11 Dec 2020 03:30:46 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663F93F68F;
        Fri, 11 Dec 2020 03:30:43 -0800 (PST)
Subject: Re: [PATCH] fair/util_est: Separate util_est_dequeue() for
 cfs_rq_util_change
To:     Xuewen Yan <xuewen.yan94@gmail.com>, patrick.bellasi@arm.com,
        vincent.guittot@linaro.org, peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Xuewen.Yan@unisoc.com,
        xuewyan@foxmail.com
References: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2edefcc7-ccea-5665-728e-5b86ac413629@arm.com>
Date:   Fri, 11 Dec 2020 12:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yan,

On 09/12/2020 11:44, Xuewen Yan wrote:
> when a task dequeued, it will update it's util, and cfs_rq_util_change
> would check rq's util, if the cfs_rq->avg.util_est.enqueued is bigger
> than  cfs_rq->avg.util_avg, but because the cfs_rq->avg.util_est.enqueued
> didn't be decreased, this would cause bigger cfs_rq_util by mistake,
> as a result, cfs_rq_util_change may change freq unreasonablely.
> 
> separate the util_est_dequeue() into util_est_dequeue() and
> util_est_update(), and dequeue the _task_util_est(p) before update util.

The issue is that sugov_update_[shared\|single] -> sugov_get_util() ->
cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued value?

cpu_util_cfs()

    if (sched_feat(UTIL_EST))
        util = max_t(util, READ_ONCE(rq->cfs.avg.util_est.enqueued))
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

dequeue_task_fair() (w/ your patch, moving (1) before (2))

    /* (1) update cfs_rq->avg.util_est.enqueued */
    util_est_dequeue()

    /* (2) potential p->se.avg.util_avg update */
    /* 2 for loops */
    for_each_sched_entity()

        /* this can only lead to a freq change for a root cfs_rq */
        (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
         -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]

    /* (3) potential update p->se.avg.util_est */
    util_est_update()


We do need (3) after (2) because of:

util_est_update()
    ...
    ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED); task_util
    ...           ^^^^^^^^^^^^^
                  p->se.avg.util_avg


Did I get this right?

[...]
