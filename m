Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326252B04EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKLMZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:25:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60906 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLMZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:25:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACCPOi2057339;
        Thu, 12 Nov 2020 06:25:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605183924;
        bh=38nkddqkRWaLlTaw9qq41SKJYzs+Sc5qQ9Rv7L4RahA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=j5CZBvMg1sNNQV+PBY4/+PFCU46Fv8B86p83+kIe7YMnfiqUbUQ0WnVeiGlXuGTPf
         1UC2Fd1g2KCzGS0rvXwvrBMpboLPg8izvsNWHu/rzMmVYVcnWmaDDYL6mjL+UWghHT
         nKL98n239Lx9BOqd5s1EBVfjIItrOxshWspPSQK8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACCPNur024749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 06:25:23 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 06:25:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 06:25:23 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACCPK0h087229;
        Thu, 12 Nov 2020 06:25:21 -0600
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <tomi.valkeinen@ti.com>, <kishon@ti.com>, <dmurphy@ti.com>,
        <s-anna@ti.com>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
 <20201112103130.GD1997862@dell>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
Date:   Thu, 12 Nov 2020 14:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112103130.GD1997862@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 12:31, Lee Jones wrote:
> Cc:ing a few people I know.
> 
> On Tue, 03 Nov 2020, Lee Jones wrote:
> 
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
>>   drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>
>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>> Cc: Sandeep Nair <sandeep_n@ti.com>
>> Cc: Cyril Chemparathy <cyril@ti.com>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/soc/ti/knav_qmss_queue.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Any idea who will take these TI patches?
> 
> https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/
> 

(Dropped a few inactive emails from delivery.)

Santosh is the maintainer for the subsystem, so my vote would go for him.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
