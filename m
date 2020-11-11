Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88A42AEF00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgKKKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:53:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7515 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgKKKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:53:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CWM5t3d6FzhjpV;
        Wed, 11 Nov 2020 18:53:22 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 18:53:25 +0800
Subject: Re: [PATCH] regmap: Properly free allocated name for regmap_config of
 syscon
To:     Marc Zyngier <maz@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201109115816.160639-1-wangkefeng.wang@huawei.com>
 <20201109172331.GJ6380@sirena.org.uk>
 <18a3857d-3250-e136-7d80-abdab902367c@huawei.com>
 <9b291d6ebdebe8a3a9f07d2bf4033fe9@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <5660a879-2f11-c577-fe8e-0e1c6f244d8c@huawei.com>
Date:   Wed, 11 Nov 2020 18:53:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9b291d6ebdebe8a3a9f07d2bf4033fe9@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/10 16:47, Marc Zyngier wrote:
> On 2020-11-10 01:35, Kefeng Wang wrote:
>> On 2020/11/10 1:23, Mark Brown wrote:
>>> On Mon, Nov 09, 2020 at 07:58:16PM +0800, Kefeng Wang wrote:
>>>
>> Hi Marc,  the regmap debugfs will duplicate a name in 
>> regmap_set_name(), and
>>
>> syscon_config.name won't be used in syscon,  so your following patch
>> doesn't seem
>>
>> to be necessary,  right ? Please correct me if I'm wrong, thanks.
>
> It was certainly necessary at the time when I wrote the patch, as it
> was fixing some obvious memory corruption (use after free).
>
> It is very possible that the flow has been reorganised since, as the
> following commit hints at:
>
> commit e15d7f2b81d2e7d93115d46fa931b366c1cdebc2
> Author: Suman Anna <s-anna@ti.com>
> Date:   Mon Jul 27 16:10:08 2020 -0500
>
>     mfd: syscon: Use a unique name with regmap_config
>
>     The DT node full name is currently being used in regmap_config
>     which in turn is used to create the regmap debugfs directories.
>     This name however is not guaranteed to be unique and the regmap
>     debugfs registration can fail in the cases where the syscon nodes
>     have the same unit-address but are present in different DT node
>     hierarchies. Replace this logic using the syscon reg resource
>     address instead (inspired from logic used while creating platform
>     devices) to ensure a unique name is given for each syscon.
>
>     Signed-off-by: Suman Anna <s-anna@ti.com>
>     Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> I suggest you come up with a more complete analysis of the problem
> and how it came to be.

I check the history of above patch[1],

"The regmap name is expected to be managed by the caller and should be
live as long as the regmap is live, it is almost always static data."

so keep it as your patch said, thanks.

[1] 
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200727211008.24225-1-s-anna@ti.com/#23575471


>
>         M.
