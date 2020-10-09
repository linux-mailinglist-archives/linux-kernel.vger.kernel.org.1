Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B72883D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbgJIHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:43:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44096 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgJIHnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:43:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0997h7tF021302;
        Fri, 9 Oct 2020 02:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602229387;
        bh=uzWU1jVJgqEJ0imeOeii6jSMjb6zY2m2vYotevkhIPQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YHLPZCyyCGyJ/rvgdrXLO3DllYVRVt0FIRz4hsWCT9VLax4Pa6dDRMlupCmy6p9El
         SuadmVkuY3go9fNiM6PyiP07QJwpgFWQsC2HXTOjc9VEtDXW07qSJunehzZl5wQT7X
         RucUI8Jv6N6v0QzzGMvSn3xggq6sIeEIGQ2ATTJ4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0997h7gc122368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 02:43:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 02:43:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 02:43:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0997h4ul015714;
        Fri, 9 Oct 2020 02:43:05 -0500
Subject: Re: [PATCH v2 10/11] soc: ti: k3-ringacc: Use correct device for
 allocation in RING mode
To:     Nishanth Menon <nm@ti.com>
CC:     <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
 <20201008115224.1591-11-peter.ujfalusi@ti.com>
 <20201009030204.3i3d6azsmfekl5qx@whole>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6d8f5331-251d-5409-4a1c-e3e42d340071@ti.com>
Date:   Fri, 9 Oct 2020 10:43:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009030204.3i3d6azsmfekl5qx@whole>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 09/10/2020 6.02, Nishanth Menon wrote:
> On 14:52-20201008, Peter Ujfalusi wrote:
>> -	ring->ring_mem_virt = dma_alloc_coherent(ringacc->dev,
>> +	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
>>  					ring->size * (4 << ring->elm_size),
>>  					&ring->ring_mem_dma, GFP_KERNEL);
> 
> Any chance of getting a cleanup of the file for 5.11? I know this series
> has'nt introduced this warning or set of warnings, but I am starting to
> get concerned that we are carrying over too much of a debt now?
> 
> https://pastebin.ubuntu.com/p/tT2kPDsCWD/

Right, you know that git blame points the finger at you on ti_sci.c errors?

Never the less, I have run the tool locally on my linux-next-wip with
these patches:
https://pastebin.ubuntu.com/p/myJwjvKYw8/

and I don't see the noise you see.

> Checkpatch does point this:
> 
> --- /tmp/kernel-patch-verify.25812/ptest_check-start	2020-10-08
> 19:33:31.025898581 +0000
> +++ /tmp/kernel-patch-verify.25812/ptest_check-end	2020-10-08
> 19:33:31.593893830 +0000
> @@ -0,0 +1,6 @@
> +CHECK: Alignment should match open parenthesis
> +#84: FILE: drivers/soc/ti/k3-ringacc.c:657:
> ++	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
> + 					ring->size * (4 << ring->elm_size),

Yes, that's correct. Readability VS very long lines

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
