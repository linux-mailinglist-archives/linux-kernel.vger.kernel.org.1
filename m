Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0028223053
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 03:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGQBc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 21:32:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgGQBc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:32:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ED2CFCB7FADA5FB032E4;
        Fri, 17 Jul 2020 09:32:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 09:32:22 +0800
Subject: Re: [PATCH -next] gpu: host1x: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200716090323.13274-1-miaoqinglang@huawei.com>
 <20200716133450.GJ535268@ulmo>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <5684dcb3-c5a4-96c1-dd96-c44f5a94938f@huawei.com>
Date:   Fri, 17 Jul 2020 09:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200716133450.GJ535268@ulmo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/16 21:34, Thierry Reding 写道:
> On Thu, Jul 16, 2020 at 05:03:23PM +0800, Qinglang Miao wrote:
>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> ---
>>   drivers/gpu/host1x/debug.c | 28 ++++------------------------
>>   1 file changed, 4 insertions(+), 24 deletions(-)
> This doesn't apply. Can you please resend, based on something like
> linux-next?
>
> Thanks,
> Thierry
Hi, Thierry

   Sorry I didn't mention it in commit log, but this patch is based on 
linux-next where commit <4d4901c6d7> has switched over direct  seq_read 
method calls to seq_read_iter, this is why there's conflict in  your apply.

   Do you think I should send a new patch based on 5.8rc?

Thanks.

