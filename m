Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3B2EF10D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbhAHLFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:05:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57182 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAHLFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:05:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 108B3cR3033815;
        Fri, 8 Jan 2021 05:03:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610103818;
        bh=pTkr6cX3Rfvr6UWbjUenD9c78tNj8Bhz6DpQu5KGbis=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bSUTE+15a8cQDmf1ChmDWERdufRrS8c+mtqZ1lsLqiHErQ+qFzhQXy+55qTdfXtqw
         MgJYWz7XQSkxH6/WuYV+gQeK6GpbrbNYW4/kfZ61NRkFDynZqgb2v6JarfMS5XefSj
         iAixPHRv7tL339TuwLT3p/3sCQFg+4l61NGeHvZ4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 108B3crr103576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 05:03:38 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 05:03:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 Jan 2021 05:03:38 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 108B3Zso052195;
        Fri, 8 Jan 2021 05:03:36 -0600
Subject: Re: [PATCH 4/7] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
To:     Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-5-kishon@ti.com>
 <cb53a07e-98ed-71df-7e0c-acd78484ab6e@axentia.se>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c5644863-cff5-6516-d7d1-42603fe1d0e3@ti.com>
Date:   Fri, 8 Jan 2021 16:33:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb53a07e-98ed-71df-7e0c-acd78484ab6e@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 08/01/21 4:16 pm, Peter Rosin wrote:
> Hi!
> 
> On 2020-12-24 12:42, Kishon Vijay Abraham I wrote:
>> AM64 has a single lane SERDES which can be configured to be used
>> with either PCIe or USB. Define the possilbe values for the SERDES
>> function in AM64 SoC here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  include/dt-bindings/mux/ti-serdes.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
>> index 9047ec6bd3cf..68e0f76deed1 100644
>> --- a/include/dt-bindings/mux/ti-serdes.h
>> +++ b/include/dt-bindings/mux/ti-serdes.h
>> @@ -90,4 +90,8 @@
>>  #define J7200_SERDES0_LANE3_USB			0x2
>>  #define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
>>  
>> +/* AM64 */
> 
> In case you end up keeping these defines, despite the comment by Rob...
> 
> Nitpick, the J721E and J7200 sections have a blank line here, between the
> header comment and the actual defines. But mehh...
> 
> Acked-by: Peter Rosin <peda@axentia.se>
Sure, will fix it in the next revision.

Thanks
Kishon

> 
> Cheers,
> Peter
> 
>> +#define AM64_SERDES0_LANE0_PCIE0		0x0
>> +#define AM64_SERDES0_LANE0_USB			0x1
>> +
>>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */
>>
