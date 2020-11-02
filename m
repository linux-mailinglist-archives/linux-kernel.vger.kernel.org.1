Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB72A2563
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgKBHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:39:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7395 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:39:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CPlCk0Xs1z6vyZ;
        Mon,  2 Nov 2020 15:38:58 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 15:38:50 +0800
Subject: Re: [PATCH v3 0/2] uacce: fix some coding styles
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
 <5F9FAA08.2000406@hisilicon.com> <20201102070937.GA71996@kroah.com>
CC:     Kai Ye <yekai13@huawei.com>, <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F9FB789.9090204@hisilicon.com>
Date:   Mon, 2 Nov 2020 15:38:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20201102070937.GA71996@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/2 15:09, Greg Kroah-Hartman wrote:
> On Mon, Nov 02, 2020 at 02:41:12PM +0800, Zhou Wang wrote:
>> On 2020/9/23 18:09, Kai Ye wrote:
>>> 1. delete some redundant code.
>>> 2. modify the module author information. "Hisilicon"
>>> spelling is error.
>>>
>>> Changes v2 -> v3:
>>> 	Two things, splited to two patches.
>>> Changes v1 -> v2:
>>> 	deleted extra NULL pointer check in uacce_fops.
>>>
>>> Kai Ye (2):
>>>   uacce: fix some coding styles
>>>   uacce: modify the module author information.
>>>
>>>  drivers/misc/uacce/uacce.c | 13 +------------
>>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>>
>>
>> Hi Hartman，
>>
>> Could you help to take this clean up patch?
> 
> I do not see a patch here :(

I know the reason, Kai Ye did not To you and I also added your
Email address in this ping :) I have replied patches directly.

Could you take them?

Best,
Zhou

> 
> If I have missed something, please resend it.
> 
> thanks,
> 
> greg k-h
> .
> 
