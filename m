Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39A2FFFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhAVKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:05:20 -0500
Received: from foss.arm.com ([217.140.110.172]:39154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbhAVKBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:01:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2733311D4;
        Fri, 22 Jan 2021 02:00:49 -0800 (PST)
Received: from [10.57.9.64] (unknown [10.57.9.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124DC3F719;
        Fri, 22 Jan 2021 02:00:46 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Add governor data with pre-defined
 thresholds
To:     Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        robh@kernel.org, tomeu.vizoso@collabora.com,
        alyssa.rosenzweig@collabora.com, dri-devel@lists.freedesktop.org,
        daniel.lezcano@linaro.org
References: <20210121170445.19761-1-lukasz.luba@arm.com>
 <c5ad1148-0494-aaed-581a-c13ed94e42e8@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <38c4dc94-0613-33f9-e4e4-e42d451aed9b@arm.com>
Date:   Fri, 22 Jan 2021 10:00:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c5ad1148-0494-aaed-581a-c13ed94e42e8@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/21 8:21 AM, Steven Price wrote:
> On 21/01/2021 17:04, Lukasz Luba wrote:
>> The simple_ondemand devfreq governor uses two thresholds to decide about
>> the frequency change: upthreshold, downdifferential. These two tunable
>> change the behavior of the governor decision, e.g. how fast to increase
>> the frequency or how rapidly limit the frequency. This patch adds needed
>> governor data with thresholds values gathered experimentally in different
>> workloads.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> Hi all,
>>
>> This patch aims to improve the panfrost performance in various workloads,
>> (benchmarks, games). The simple_ondemand devfreq governor supports
>> tunables to tweak the behaviour of the internal algorithm. The default
>> values for these two thresholds (90 and 5) do not work well with 
>> panfrost.
>> These new settings should provide good performance, short latency for
>> rising the frequency due to rapid workload change and decent freq slow
>> down when the load is decaying. Based on frequency change statistics,
>> gathered during experiments, all frequencies are used, depending on
>> the load. This provides some power savings (statistically). The highest
>> frequency is also used when needed.
>>
>> Example glmark2 results:
>> 1. freq fixed to max: 153
>> 2. these new thresholds values (w/ patch): 151
>> 3. default governor values (w/o patch): 114
> 
> It would be good to state which platform this is on as this obviously 
> can vary depending on the OPPs available.

Sorry about that. It was Rock Pi 4B and I have mesa 20.2.4.

> 
> Of course the real fix here would be to improve the utilisation of the 
> GPU[1] so we actually hit the 90% threshold more easily (AFAICT kbase 
> uses the default 90/5 thresholds), but this seems like a reasonable 
> change for now.

Agree, improving the scheduler would be the best option. I'll have a
look at that patch and why it got this 10% lower performance. Maybe
I would find something during testing.

> 
> Reviewed-by: Steven Price <steven.price@arm.com>

Thank you for the review. I guess this patch would go through drm tree?

Regards,
Lukasz

> 
> Thanks,
> 
> Steve
> 
> [1] When I get some time I need to rework the "queue jobs on the 
> hardware"[2] patch I posted ages ago. Last time it actually caused a 
> performance regression though...
> 
> [2] https://lore.kernel.org/r/20190816093107.30518-2-steven.price%40arm.com
> 
