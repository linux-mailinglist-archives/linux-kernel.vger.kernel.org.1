Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6472E2CF8FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 03:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgLECcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 21:32:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9383 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLECcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 21:32:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cntqv0w79z78mM;
        Sat,  5 Dec 2020 10:31:39 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 5 Dec 2020 10:31:58 +0800
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
 <b2919179-3045-bd4b-2e0a-2f472ddb73d8@huawei.com>
 <20201204094021.GG3306@suse.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <32d3a300-f74f-7660-0a78-9be7c8a279ba@huawei.com>
Date:   Sat, 5 Dec 2020 10:31:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201204094021.GG3306@suse.de>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/4 17:40, Mel Gorman wrote:
> On Fri, Dec 04, 2020 at 09:22:34AM +0800, Yunfeng Ye wrote:
>>
>>
>> On 2020/12/3 17:42, Mel Gorman wrote:
>>> On Thu, Dec 03, 2020 at 02:47:14PM +0800, Yunfeng Ye wrote:
>>>> The schedstat include runqueue-specific stats and domain-specific stats,
>>>> so split it into two functions, show_rqstat() and show_domainstat().
>>>>
>>>> No functional changes.
>>>>
>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>
>>> Why?
>>>
>>> I could understand if there was a follow-up patch that adjusted some
>>> subset or there was a difference in checking for schedstat_enabled,
>>> locking or inserting new schedstat information. This can happen in the
>>> general case when the end result is easier to review here it seems to be
>>> just moving code around.
>>>
>> The rqstat and domainstat is independent state information. so I think
>> split it into two individual function is clearer.
>>
> 
> The comments and the names of the structures being accessesd is sufficient
> to make it clear.
> 
ok, thanks.
