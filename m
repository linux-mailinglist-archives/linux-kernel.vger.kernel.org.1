Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65922B0682
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKLNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:33:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46304 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:33:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACDXSjP080439;
        Thu, 12 Nov 2020 07:33:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605188008;
        bh=JI5InehPemY3Sji61p0buDdheLhojCylewmwAmnXID4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CUw/SeuIqbOT10vfwQ50lO1AFATRmhEVNbhpAK5tji+jyAJ17tWIfTsImyFggV0Dw
         VcGWXrpOzX2/uWeTHSIEKr+uEN87im/UCzHJzYT1N+LrAN3IFFS/TMMo+alSNu92Wy
         rl9Zvdtth+shWHKlHYB1BqFbtR96SQX7Ds6g09sc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACDXSLK009694
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 07:33:28 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 07:33:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 07:33:28 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACDXPTL116553;
        Thu, 12 Nov 2020 07:33:26 -0600
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <tomi.valkeinen@ti.com>, <kishon@ti.com>, <dmurphy@ti.com>,
        <s-anna@ti.com>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
 <20201112103130.GD1997862@dell> <30ad256b-07f0-f01e-ec4f-c12cf9dbe426@ti.com>
 <20201112132145.GI1997862@dell>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ca303b27-b5a6-0d8e-2577-e6dbd8363382@ti.com>
Date:   Thu, 12 Nov 2020 15:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112132145.GI1997862@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2020 15:21, Lee Jones wrote:
> On Thu, 12 Nov 2020, Tero Kristo wrote:
> 
>> On 12/11/2020 12:31, Lee Jones wrote:
>>> Cc:ing a few people I know.
>>>
>>> On Tue, 03 Nov 2020, Lee Jones wrote:
>>>
>>>> Fixes the following W=1 kernel build warning(s):
>>>>
>>>>    drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
>>>>    drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>>>
>>>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>>>> Cc: Sandeep Nair <sandeep_n@ti.com>
>>>> Cc: Cyril Chemparathy <cyril@ti.com>
>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>> ---
>>>>    drivers/soc/ti/knav_qmss_queue.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> Any idea who will take these TI patches?
>>>
>>> https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/
>>>
>>
>> (Dropped a few inactive emails from delivery.)
>>
>> Santosh is the maintainer for the subsystem, so my vote would go for him.
> 
> Thanks for your prompt reply Tero.
> 
> It looks as though Santosh has been on Cc since the start.  He must
> just be busy.  I'll give him a little while longer before submitting a
> [RESEND].

Yeah, in my experience it can take a while for Santosh to react on 
patches. :)

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
