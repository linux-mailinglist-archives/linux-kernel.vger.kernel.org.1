Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4C2CE4F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgLDBX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:23:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8939 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLDBX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:23:26 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CnFLQ6dw1zhmLg;
        Fri,  4 Dec 2020 09:22:22 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:22:35 +0800
Subject: Re: [PATCH 2/2] sched: Split the function show_schedstat()
To:     Mel Gorman <mgorman@suse.de>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
 <a0245eb6-d7ff-cae5-3608-d46424fa437d@huawei.com>
 <20201203094237.GD3306@suse.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <b2919179-3045-bd4b-2e0a-2f472ddb73d8@huawei.com>
Date:   Fri, 4 Dec 2020 09:22:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201203094237.GD3306@suse.de>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/3 17:42, Mel Gorman wrote:
> On Thu, Dec 03, 2020 at 02:47:14PM +0800, Yunfeng Ye wrote:
>> The schedstat include runqueue-specific stats and domain-specific stats,
>> so split it into two functions, show_rqstat() and show_domainstat().
>>
>> No functional changes.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Why?
> 
> I could understand if there was a follow-up patch that adjusted some
> subset or there was a difference in checking for schedstat_enabled,
> locking or inserting new schedstat information. This can happen in the
> general case when the end result is easier to review here it seems to be
> just moving code around.
> 
The rqstat and domainstat is independent state information. so I think
split it into two individual function is clearer.

Thanks.
