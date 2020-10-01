Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C460627F9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgJAHII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:08:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:08:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09177xCg121358;
        Thu, 1 Oct 2020 02:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601536079;
        bh=Wy7RCW21TM37534Qy9Jjksa3urMTrTkNCHkt0rmsS3U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HIJYlvkhBUHmLn/FiB04PClPbbNwAEjt7uxtSWIlTsVs/73duOHOSkQIhrvf2/57k
         jDua4e+0wDiMlK8utbQHTeYbyNp1hLzQsN1Mz+OSymltUwpsTuxO/IgQ1iMvNrTyiw
         aNCWjpz1x6NMJ+slHp0RhGW4xk9/98VcPTG8Usto=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09177xMN120597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 02:07:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 02:07:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 02:07:59 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09177tmi058541;
        Thu, 1 Oct 2020 02:07:56 -0500
Subject: Re: [PATCH 11/11] soc: ti: k3-socinfo: Add entry for AM64 SoC family
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-12-peter.ujfalusi@ti.com>
 <aa10c7a1-ddbd-a3ae-3035-f26a5ce073ae@ti.com>
 <c2dcf5a3-abff-923c-7610-a670f02479e6@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <fa46191e-2c44-4220-0fcd-6e68f226d6c5@ti.com>
Date:   Thu, 1 Oct 2020 12:37:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2dcf5a3-abff-923c-7610-a670f02479e6@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/20 12:12 PM, Peter Ujfalusi wrote:
> Hi Grygorii,
> 
> On 30/09/2020 16.56, Grygorii Strashko wrote:
>>
>>
>> On 28/09/2020 11:34, Peter Ujfalusi wrote:
>>> It's JTAG PARTNO is 0xBB38.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>   drivers/soc/ti/k3-socinfo.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
>>> index bbbc2d2b7091..a14ec68846dd 100644
>>> --- a/drivers/soc/ti/k3-socinfo.c
>>> +++ b/drivers/soc/ti/k3-socinfo.c
>>> @@ -40,6 +40,7 @@ static const struct k3_soc_id {
>>>       { 0xBB5A, "AM65X" },
>>>       { 0xBB64, "J721E" },
>>>       { 0xBB6D, "J7200" },
>>> +    { 0xBB38, "AM64" }
>>
>> Shouldn't it be AM64X
> 
> Good point, I'll fix this up and then the DMA series.
> 
> While here, what do you think: should we keep the DMA compatibles as I
> have them in v1 (am64-dmss-bcdma and am64-dmss-pktdma):
> https://lore.kernel.org/lkml/20200930091412.8020-10-peter.ujfalusi@ti.com/
> https://lore.kernel.org/lkml/20200930091412.8020-11-peter.ujfalusi@ti.com/
> 
> or change them to am64x-dmss-* ?
> 
> I'll ask Rob on the binding doc patches as well.

As long as differences within the family are discoverable by some other
means, wild chars may be okay. See one of Rob's earlier responses:

https://linuxlists.cc/l/1/linux-kernel/t/3311057/(patch_1_2)_dt-bindings:_ptp:_add_binding_doc_for_idt_clockmatrix_based_ptp_clock

Regards
Vignesh
