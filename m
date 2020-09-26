Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EF2279591
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgIZA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:28:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49262 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgIZA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:28:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08Q0SUdO068263;
        Fri, 25 Sep 2020 19:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601080111;
        bh=9n7pUTyuv/cuPHlTws9RJoHfjArgioF7CkoVZuD5NAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=US6zcE7BdGGh0SWtoDchcR85l3876Eyx2UuFvinr4kQLfFr5mf4U4QUnqXZqO1SR7
         cpgJbBQma4ZPw5eVzLyjQEIkv5fnHf7qj/j4k/bB81LPeOTiZVRZTfnrWP4QWl2++B
         XncXGpR0HNrDI3twqC8XkxFKXbO0PSTipmbkpDAU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08Q0SUvv069296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 19:28:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 25
 Sep 2020 19:28:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 25 Sep 2020 19:28:30 -0500
Received: from [10.250.69.208] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08Q0SU0D086435;
        Fri, 25 Sep 2020 19:28:30 -0500
Subject: Re: [PATCH] mfd: syscon: Don't free allocated name for regmap_config
To:     Lee Jones <lee.jones@linaro.org>, Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <kernel-team@android.com>
References: <20200903160237.932818-1-maz@kernel.org>
 <20200924123936.GJ4678@dell>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <04fac15b-8866-efe4-1047-b20713f5200f@ti.com>
Date:   Fri, 25 Sep 2020 19:28:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924123936.GJ4678@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 7:39 AM, Lee Jones wrote:
> On Thu, 03 Sep 2020, Marc Zyngier wrote:
> 
>> The name allocated for the regmap_config structure is freed
>> pretty early, right after the registration of the MMIO region.
>>
>> Unfortunately, that doesn't follow the life cycle that debugfs
>> expects, as it can access the name field long after the free
>> has occured.
>>
>> Move the free on the error path, and keep it forever otherwise.
>>
>> Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/mfd/syscon.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Fixed the spelling mistake and applied, thanks.
> 

Marc,
Can you recheck the behavior once on the latest master to see if this patch is
still needed? I see a new patch within the regmap core that is dealing with the
delayed debugfs registration name. This follows the similar design logic I
suggested on your initial submission [1].

Please see commit 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string
for debugfs init delays") in mainline.

Lee,
I haven't seen this patch in -next yet, so maybe worthwhile to hold it a little
longer.

regards
Suman

[1] https://patchwork.kernel.org/comment/23575471/

