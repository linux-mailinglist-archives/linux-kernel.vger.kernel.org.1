Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251CB2F2B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbhALJV4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jan 2021 04:21:56 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52048 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731334AbhALJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:21:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0ULVrijM_1610443268;
Received: from 192.168.0.112(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0ULVrijM_1610443268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Jan 2021 17:21:09 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <F049FFBB-7B70-43EF-A772-C63D270F9122@linux.alibaba.com>
Date:   Tue, 12 Jan 2021 17:21:08 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        khlebnikov@yandex-team.ru, xiyou.wangcong@gmail.com,
        shanpeic@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <863AB797-9680-4EC7-AE51-4481CD48AA9D@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
 <20201217074620.58338-2-changhuaixin@linux.alibaba.com>
 <20201217133656.GX3040@hirez.programming.kicks-ass.net>
 <F049FFBB-7B70-43EF-A772-C63D270F9122@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 21, 2020, at 9:53 PM, changhuaixin <changhuaixin@linux.alibaba.com> wrote:
> 
> 
> 
>> On Dec 17, 2020, at 9:36 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> On Thu, Dec 17, 2020 at 03:46:17PM +0800, Huaixin Chang wrote:
>>> In this patch, we introduce the notion of CFS bandwidth burst. Unused
>>> "quota" from pervious "periods" might be accumulated and used in the
>>> following "periods". The maximum amount of accumulated bandwidth is
>>> bounded by "burst". And the maximun amount of CPU a group can consume in
>>> a given period is "buffer" which is equivalent to "quota" + "burst in
>>> case that this group has done enough accumulation.
>> 
>> Oh man, Juri, wasn't there a paper about statistical bandwidth
>> accounting somewhere? Where, if you replace every utilization by a
>> statistical variable, the end result is still useful?
>> 
>> That is, instead of something like; \Sum u_i <= 1, you get something
>> like: \Sum {avg(u),var(u)}_i <= {1, sqrt(\Sum var_i^2)} and you can
>> still proof bounded tardiness etc.. (assuming a gaussian distribution).
>> 
>> The proposed seems close to that, but not quite, and I'm afraid it's not
>> quite strong enough to still provide any guarantees.
> 
> After reading some papers on statistical bandwidth sharing, it occurs to me that statistical bandwidth sharing is about the way bandwidth is shared between competitors. I wonder if the paper you mentioned was "Insensitivity results in statistical bandwidth sharing" or some paper referenced, which showed the end result is insensitive to maybe the distribution or the arrival pattern.
> 
> I am sorry that I cannot prove using statistical bandwidth sharing theory now. However, I wonder if it is more acceptable to put rate-based cfsb after share fairness, because the input stream of cfsb account is the output stream of fairness. And that is in contrast with what statistical bandwidth sharing does, in which fairness is used to share bandwidth upon the output stream of rate-based control. In this way, maybe guarantees can be provided by share fairness, and cfsb may use a larger buffer to allow more jitters.
> 
> A buffer, which is several times of quota, is able to handle large bursts, and throttle threads soon when overloaded. The present cfsb, however, has to be configured several times larger to handle jitters, which is ineffective and does not provide the designed rate-based control.

Hi, peter.

Will you please have a look at my earlier reply.

The guarantee provided by cfsb is max-min fairness with strict upper bound, I think. And after this modification, it is still roughly that. As for longer periods, each cfsb group is still limited to their quota on average.

When users configure a huge burst buffer, cfsb doesn't really throttle threads and upper bound is exceeded. In that case, guarantees are provided by share, which provides proportional fairness.

Thanks,
Huaixin
