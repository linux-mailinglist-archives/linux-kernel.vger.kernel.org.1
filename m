Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B9276C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgIXIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:54:47 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35356 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbgIXIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:54:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U9xKTdd_1600937682;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U9xKTdd_1600937682)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Sep 2020 16:54:43 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH RESEND] sched/fair: Fix wrong cpu selecting from isolated
 domain
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com>
 <CAKfTPtAgzcSZekb1D_Gm55vHpm4-9z5OyUxuoRTzx-_5icf5Ew@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <aa06b988-e2bd-4ff9-caab-def399698bf2@linux.alibaba.com>
Date:   Thu, 24 Sep 2020 16:54:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAgzcSZekb1D_Gm55vHpm4-9z5OyUxuoRTzx-_5icf5Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 3:18 PM, Vincent Guittot wrote:
> On Thu, 24 Sep 2020 at 08:48, Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
>> We've met problems that occasionally tasks with full cpumask
>> (e.g. by putting it into a cpuset or setting to full affinity)
>> were migrated to our isolated cpus in production environment.
>>
>> After some analysis, we found that it is due to the current
>> select_idle_smt() not considering the sched_domain mask.
>>
>> Steps to reproduce on my 31-CPU hyperthreads machine:
>> 1. with boot parameter: "isolcpus=domain,2-31"
>>    (thread lists: 0,16 and 1,17)
>> 2. cgcreate -g cpu:test; cgexec -g cpu:test "test_threads"
>> 3. some threads will be migrated to the isolated cpu16~17.
>>
>> Fix it by checking the valid domain mask in select_idle_smt().
>>
>> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
>> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
>> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Thanks, Vincent :-)
