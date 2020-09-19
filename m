Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95322709FC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISCRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:17:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:17:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B07AE3937706E353A1AF;
        Sat, 19 Sep 2020 10:17:37 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:17:36 +0800
Subject: Re: [PATCH -next] mfd: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Lee Jones <lee.jones@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200716090236.13057-1-miaoqinglang@huawei.com>
 <20200716134603.GR3165313@dell>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <00056e7b-6a6d-459d-2498-f07da156e409@huawei.com>
Date:   Sat, 19 Sep 2020 10:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200716134603.GR3165313@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/16 21:46, Lee Jones 写道:
> On Thu, 16 Jul 2020, Qinglang Miao wrote:
> 
>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> ---
>>   drivers/mfd/ab3100-core.c | 15 ++-------------
>>   drivers/mfd/ab3100-otp.c  | 16 +++-------------
>>   drivers/mfd/tps65010.c    | 14 ++------------
> 
> Can you split this out into different patches please.

Hi Lee,

I've splited this out into three patches.

They are against linux-next(20200917), and can be applied to mainline 
cleanly now.

Thanks.
> 
>>   3 files changed, 7 insertions(+), 38 deletions(-)
> 
