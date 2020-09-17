Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1C26DBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgIQMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:45:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbgIQMl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:41:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E55CB31BFF30A85B6887;
        Thu, 17 Sep 2020 20:41:23 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:41:19 +0800
Subject: Re: [PATCH -next] gpu: host1x: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200716090323.13274-1-miaoqinglang@huawei.com>
 <20200716133450.GJ535268@ulmo>
 <5684dcb3-c5a4-96c1-dd96-c44f5a94938f@huawei.com>
 <20200717142524.GA1218823@ulmo>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <cc115577-e536-d9d9-4e82-715309c40ad1@huawei.com>
Date:   Thu, 17 Sep 2020 20:41:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200717142524.GA1218823@ulmo>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/17 22:25, Thierry Reding 写道:
> On Fri, Jul 17, 2020 at 09:32:21AM +0800, miaoqinglang wrote:
>>
>> 在 2020/7/16 21:34, Thierry Reding 写道:
>>> On Thu, Jul 16, 2020 at 05:03:23PM +0800, Qinglang Miao wrote:
>>>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>>
>>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>>>
>>>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>> ---
>>>>    drivers/gpu/host1x/debug.c | 28 ++++------------------------
>>>>    1 file changed, 4 insertions(+), 24 deletions(-)
>>> This doesn't apply. Can you please resend, based on something like
>>> linux-next?
>>>
>>> Thanks,
>>> Thierry
>> Hi, Thierry
>>
>>    Sorry I didn't mention it in commit log, but this patch is based on
>> linux-next where commit <4d4901c6d7> has switched over direct  seq_read
>> method calls to seq_read_iter, this is why there's conflict in  your apply.
>>
>>    Do you think I should send a new patch based on 5.8rc?
> 
> No need to. I'm about to send out the pull request for v5.9-rc1, so I'll
> just defer this to v5.10 since it doesn't look like it's anything
> urgent.
> 
> Thierry
>
Hi, Thierry

I've sent a new patch against linux-next(20200917), and can be applied 
to mainline cleanly now. So I suggest you v2 patch.

Thanks.
