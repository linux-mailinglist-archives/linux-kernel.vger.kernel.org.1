Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BCF2ACA87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgKJBfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:35:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7162 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKJBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:35:21 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CVVmH08qpz15TlP;
        Tue, 10 Nov 2020 09:35:11 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 09:35:08 +0800
Subject: Re: [PATCH] regmap: Properly free allocated name for regmap_config of
 syscon
To:     Mark Brown <broonie@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
References: <20201109115816.160639-1-wangkefeng.wang@huawei.com>
 <20201109172331.GJ6380@sirena.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <18a3857d-3250-e136-7d80-abdab902367c@huawei.com>
Date:   Tue, 10 Nov 2020 09:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201109172331.GJ6380@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/10 1:23, Mark Brown wrote:
> On Mon, Nov 09, 2020 at 07:58:16PM +0800, Kefeng Wang wrote:
>
>> syscon_config.name in of_syscon_register is allocated using kasprintf,
>> which should be freed when it is not used after regmap_set_name, fix
>> the following memory leak.
>> unreferenced object 0xffffffe07fe8c150 (size 16):
>>    comm "swapper/0", pid 1, jiffies 4294892540 (age 68.168s)
>>    hex dump (first 16 bytes):
>>      74 65 73 74 40 31 30 30 30 30 30 00 e0 ff ff ff  test@100000.....
>>    backtrace:
>>      [<0000000023d86736>] create_object+0xe8/0x348
>>      [<00000000fe9d1b17>] kmemleak_alloc+0x20/0x2a
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

2899872b627e   "regmap: debugfs: Fix memory leak in regmap_debugfs_init" 
add a similar

backtrack, but the address of the trace is useless, will be careful next 
time.

>> @@ -601,6 +601,7 @@ static int regmap_set_name(struct regmap *map, const struct regmap_config *confi
>>   		if (!name)
>>   			return -ENOMEM;
>>   
>> +		kfree_const(config->name);
>>   		kfree_const(map->name);
>>   		map->name = name;
>>   	}
> Why would we free the passed in name here?  The name wes passed in from
> outside regmap in a const configuration struct, we've no idea within
> regmap if it was dynamically allocted or not and it seems very
> surprising that we'd go off and free it.  The whole reason we're
> duplicating it in regmap_set_name() is that we don't know how long it's
> going to be around so we don't want to reference it after having
> returned to the caller.  If the caller has dynamically allocated it then
> the caller should deal with freeing it.

Yes, after check it again, this patch is wrong.

Hi Marc,  the regmap debugfs will duplicate a name in regmap_set_name(), 
and

syscon_config.name won't be used in syscon,  so your following patch 
doesn't seem

to be necessary,  right ? Please correct me if I'm wrong, thanks.


commit 529a1101212a785c5df92c314b0e718287150c3b
Author: Marc Zyngier <maz@kernel.org>
Date:   Thu Sep 3 17:02:37 2020 +0100

     mfd: syscon: Don't free allocated name for regmap_config

     The name allocated for the regmap_config structure is freed
     pretty early, right after the registration of the MMIO region.

     Unfortunately, that doesn't follow the life cycle that debugfs
     expects, as it can access the name field long after the free
     has occurred.

     Move the free on the error path, and keep it forever otherwise.


