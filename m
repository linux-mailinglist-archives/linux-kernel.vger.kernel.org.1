Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36C2C4138
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgKYNgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:36:44 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58730 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727687AbgKYNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:36:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGVgCX6_1606311371;
Received: from 30.0.173.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGVgCX6_1606311371)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 21:36:11 +0800
Subject: Re: [PATCH 5/7] blk-iocost: Move the usage ratio calculation to the
 correct place
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <89a6e1223944e96e0e5e001191d87dd8079345c8.1606186717.git.baolin.wang@linux.alibaba.com>
 <X75L39ZY3GQ+eL0B@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <e137c315-22e9-3ca9-b4ab-1ce58a53b14d@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 21:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X75L39ZY3GQ+eL0B@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/11/25 20:19, Tejun Heo д��:
> Hello,
>> @@ -2225,6 +2207,25 @@ static void ioc_timer_fn(struct timer_list *timer)
>>   		     time_before64(vtime, now.vnow - ioc->margins.low))) {
>>   			u32 hwa, old_hwi, hwm, new_hwi;
>>   
>> +			if (vdone != vtime) {
>> +				u64 inflight_us = DIV64_U64_ROUND_UP(
>> +					cost_to_abs_cost(vtime - vdone, hw_inuse),
>> +					ioc->vtime_base_rate);
>> +
>> +				usage_us = max(usage_us, inflight_us);
>> +			}
>> +
>> +			/* convert to hweight based usage ratio */
>> +			if (time_after64(iocg->activated_at, ioc->period_at))
>> +				usage_dur = max_t(u64, now.now - iocg->activated_at, 1);
>> +			else
>> +				usage_dur = max_t(u64, now.now - ioc->period_at, 1);
>> +
>> +			usage = clamp_t(u32,
>> +				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE,
>> +						   usage_dur),
>> +				1, WEIGHT_ONE);
> 
> Can you please move the variable declarations inside the block together with
> the code?

Yes, sure. Will do in next version. Thanks.
