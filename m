Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085602EF3B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAHOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:07:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36238 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAHOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:07:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 108E5o22091577;
        Fri, 8 Jan 2021 08:05:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610114750;
        bh=7QUxdJubf6npHB6XXysEgpQV+ARRLTU9YbZ45EDawGs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Wx+e8zAn/GaP9GFC8ofyKGFEDS1CiHHIFKyNMQmTjWyh7OD73Vmc2BVwqK/Z3iX78
         otxF3oxkoc7ZZI3Lz4+WomzE6vCpwyi5TOXkaIGU9VPRICE2JZv6Ci2rjvyOVBvqdN
         9+y3tHs3yLZWJP3jtdiRlCWMm1473CaLeTTyPzzc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 108E5oh1058228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 08:05:50 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 08:05:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 Jan 2021 08:05:50 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 108E5lEi108720;
        Fri, 8 Jan 2021 08:05:48 -0600
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
To:     Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
 <20201119132829.sr435jf6s4275q4i@boxlike>
 <313a9cd5-7411-4ae1-cde4-42a2c18d11e6@ti.com>
 <20201124012100.fq7w7bjxvewuhbt2@shirt>
 <8885dd79-061b-82e3-1aeb-a318f7d8256d@ti.com>
 <20201127142340.ei7o4zkg5trwcspy@chevron>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2c6df02e-e7a8-fa48-27bc-140bfa500360@ti.com>
Date:   Fri, 8 Jan 2021 19:35:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201127142340.ei7o4zkg5trwcspy@chevron>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Grygorii,

On 27/11/20 7:53 pm, Nishanth Menon wrote:
> On 09:46-20201124, Sekhar Nori wrote:
>> On 24/11/20 6:51 AM, Nishanth Menon wrote:
>>> On 09:45-20201123, Sekhar Nori wrote:
>>>>>> The main reason I commented - is hope to get some clarification from DT maintainers.
>>>>>> 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
>>>>>> (most often is present in PCI and GIC nodes).
>>>>>> and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
>>>>>>
>>>>>> And there is no "never" here - #address-cells always can be added if really required.
>>>>>
>>>>>
>>>>> OK - as a GPIO node, but as an interrupt-controller node, I was
>>>>> looking at [1] and wondering if that was the precedence.
>>>>>
>>>>> Yes, will be good to get direction from the DT maintainers on this
>>>>> topic.
>>>>

Is there a conclusion on this topic?  Without adding address-cells for interrupt
controller we will be introducing new warning for all the new nodes we are adding.

Thanks and regards,
Lokesh
