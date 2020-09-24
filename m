Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A22771C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIXNEz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Sep 2020 09:04:55 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbgIXNEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:04:55 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E7CCCB2F1CEAC7D79E4E;
        Thu, 24 Sep 2020 21:04:52 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 24 Sep 2020 21:04:52 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 24 Sep 2020 21:04:52 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix some comments
Thread-Topic: [PATCH] sched: Fix some comments
Thread-Index: AdaScyyy92CiHjWDS6iDdISEJA8IGw==
Date:   Thu, 24 Sep 2020 13:04:52 +0000
Message-ID: <1c13c996946449f58d607e7a94c54a93@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping. :)

> Since commit dfa50b605c2a ("sched: Make finish_task_switch() return 'struct rq *'"), prev == current is incorrect in finish_task_switch(). Also fix a typo in the comment of struct dl_bandwidth.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/core.c  | 4 ++--
>  kernel/sched/sched.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 8471a0f7eb32..725ccab230da 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3571,8 +3571,8 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>   *
>   * The context switch have flipped the stack from under us and restored the
>   * local variables which were saved when this task called schedule() in the
> - * past. prev == current is still correct but we need to recalculate this_rq
> - * because prev may have moved to another CPU.
> + * past. We need to recalculate this_rq because prev may have moved to
> + * another CPU.
>   */
>  static struct rq *finish_task_switch(struct task_struct *prev)
>  	__releases(rq->lock)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index 28709f6b0975..1d7e45f7fbb9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -278,7 +278,7 @@ void __dl_clear_params(struct task_struct *p);
>   * consume bandwidth on the CPU they're running on.
>   * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
>   * that will be shown the next time the proc or cgroup controls will
> - * be red. It on its turn can be changed by writing on its own
> + * be read. It on its turn can be changed by writing on its own
>   * control.
>   */
>  struct dl_bandwidth {
> --
> 2.19.1
>
