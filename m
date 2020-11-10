Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291FB2AD196
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKJIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJIrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:47:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC71D20731;
        Tue, 10 Nov 2020 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604998030;
        bh=bRvoLrB0UtRy99q/cGp7Y0W/nNNhNmYKBmWRl+RLFkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n/rXYbAVC71GAY98yOi7IDTPuEz4OfcV+kH1tJW8mB85ZVN8bGY7Y5+aqoMF6S24U
         WGsdNbEbbBxvD2PMWX4BjNXcFCTC/PG0LtTeZok5mnPNEZSZZzFLRpbJc4XeJEwfsT
         N4ONyRoaXz4wTuNnyIDbpoa9p+XmSzMrWn741cP4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcPIy-009O74-Jr; Tue, 10 Nov 2020 08:47:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 10 Nov 2020 08:47:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: Properly free allocated name for regmap_config of
 syscon
In-Reply-To: <18a3857d-3250-e136-7d80-abdab902367c@huawei.com>
References: <20201109115816.160639-1-wangkefeng.wang@huawei.com>
 <20201109172331.GJ6380@sirena.org.uk>
 <18a3857d-3250-e136-7d80-abdab902367c@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <9b291d6ebdebe8a3a9f07d2bf4033fe9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangkefeng.wang@huawei.com, broonie@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-10 01:35, Kefeng Wang wrote:
> On 2020/11/10 1:23, Mark Brown wrote:
>> On Mon, Nov 09, 2020 at 07:58:16PM +0800, Kefeng Wang wrote:
>> 
>>> syscon_config.name in of_syscon_register is allocated using 
>>> kasprintf,
>>> which should be freed when it is not used after regmap_set_name, fix
>>> the following memory leak.
>>> unreferenced object 0xffffffe07fe8c150 (size 16):
>>>    comm "swapper/0", pid 1, jiffies 4294892540 (age 68.168s)
>>>    hex dump (first 16 bytes):
>>>      74 65 73 74 40 31 30 30 30 30 30 00 e0 ff ff ff  
>>> test@100000.....
>>>    backtrace:
>>>      [<0000000023d86736>] create_object+0xe8/0x348
>>>      [<00000000fe9d1b17>] kmemleak_alloc+0x20/0x2a
>> Please think hard before including complete backtraces in upstream
>> reports, they are very large and contain almost no useful information
>> relative to their size so often obscure the relevant content in your
>> message. If part of the backtrace is usefully illustrative (it often 
>> is
>> for search engines if nothing else) then it's usually better to pull 
>> out
>> the relevant sections.
> 
> 2899872b627e   "regmap: debugfs: Fix memory leak in
> regmap_debugfs_init" add a similar
> 
> backtrack, but the address of the trace is useless, will be careful 
> next time.
> 
>>> @@ -601,6 +601,7 @@ static int regmap_set_name(struct regmap *map, 
>>> const struct regmap_config *confi
>>>   		if (!name)
>>>   			return -ENOMEM;
>>>   +		kfree_const(config->name);
>>>   		kfree_const(map->name);
>>>   		map->name = name;
>>>   	}
>> Why would we free the passed in name here?  The name wes passed in 
>> from
>> outside regmap in a const configuration struct, we've no idea within
>> regmap if it was dynamically allocted or not and it seems very
>> surprising that we'd go off and free it.  The whole reason we're
>> duplicating it in regmap_set_name() is that we don't know how long 
>> it's
>> going to be around so we don't want to reference it after having
>> returned to the caller.  If the caller has dynamically allocated it 
>> then
>> the caller should deal with freeing it.
> 
> Yes, after check it again, this patch is wrong.
> 
> Hi Marc,  the regmap debugfs will duplicate a name in 
> regmap_set_name(), and
> 
> syscon_config.name won't be used in syscon,  so your following patch
> doesn't seem
> 
> to be necessary,  right ? Please correct me if I'm wrong, thanks.

It was certainly necessary at the time when I wrote the patch, as it
was fixing some obvious memory corruption (use after free).

It is very possible that the flow has been reorganised since, as the
following commit hints at:

commit e15d7f2b81d2e7d93115d46fa931b366c1cdebc2
Author: Suman Anna <s-anna@ti.com>
Date:   Mon Jul 27 16:10:08 2020 -0500

     mfd: syscon: Use a unique name with regmap_config

     The DT node full name is currently being used in regmap_config
     which in turn is used to create the regmap debugfs directories.
     This name however is not guaranteed to be unique and the regmap
     debugfs registration can fail in the cases where the syscon nodes
     have the same unit-address but are present in different DT node
     hierarchies. Replace this logic using the syscon reg resource
     address instead (inspired from logic used while creating platform
     devices) to ensure a unique name is given for each syscon.

     Signed-off-by: Suman Anna <s-anna@ti.com>
     Reviewed-by: Arnd Bergmann <arnd@arndb.de>
     Signed-off-by: Lee Jones <lee.jones@linaro.org>

I suggest you come up with a more complete analysis of the problem
and how it came to be.

         M.
-- 
Jazz is not dead. It just smells funny...
