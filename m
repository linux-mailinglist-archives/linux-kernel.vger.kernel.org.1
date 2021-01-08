Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CD2EF109
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbhAHLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:02:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56862 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbhAHLCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:02:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 108B1SU1033052;
        Fri, 8 Jan 2021 05:01:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610103688;
        bh=R4Yy4dCpfh9AHQPLVUeWFf7FZqP7PVvn8Phi3uIchgo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DNZB79daPaUyZaI1f2/DEBiKfErA6FrhElMLondatFvJ7p5ARl0yZUDtDk5uwF6dz
         NzKi02+q7PRGcRoOJvJU6ayL8PPMVe9iAPUcOHcxOMyjdNsm6JLm/Ga6ihBtWAyH8n
         uDXTn8zIDeQ4oTLdBremZXPAmFhGH/50iQV4WAHs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 108B1SUI099716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 05:01:28 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 05:01:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 Jan 2021 05:01:27 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 108B1OId103623;
        Fri, 8 Jan 2021 05:01:25 -0600
Subject: Re: [PATCH 4/7] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-5-kishon@ti.com>
 <20210108030325.GA1794594@robh.at.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0c89f4c7-94f2-2653-f951-3c4191c9f4e5@ti.com>
Date:   Fri, 8 Jan 2021 16:31:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108030325.GA1794594@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 08/01/21 8:33 am, Rob Herring wrote:
> On Thu, Dec 24, 2020 at 05:12:47PM +0530, Kishon Vijay Abraham I wrote:
>> AM64 has a single lane SERDES which can be configured to be used
>> with either PCIe or USB. Define the possilbe values for the SERDES
>> function in AM64 SoC here.
> 
> Doesn't look like this is used? Would the common phy modes work?

This will be used when the dts files are added.

Thanks
Kishon
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
>> +#define AM64_SERDES0_LANE0_PCIE0		0x0
>> +#define AM64_SERDES0_LANE0_USB			0x1
>> +
>>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */
>> -- 
>> 2.17.1
>>
