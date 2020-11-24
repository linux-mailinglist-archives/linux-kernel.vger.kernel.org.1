Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E82C1C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgKXERL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:17:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44230 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKXERL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:17:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AO4Gxpb108677;
        Mon, 23 Nov 2020 22:16:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606191419;
        bh=xT+n8mlJn9Eo903Kfy60kB5HunA+0yDvTT3bwH6YPUo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bzux2KAEW/eppb98qT0B12Clt2EhwONOpTwWxcsN7ZNtLtlOTY5v3RlKC5Sj00nwq
         WWXNGlc8UKV5mc19KTFBg6nIwQ4nbWiPOVc54Ot3bs/Hd9hsnm9tI+ZxY2IKbYsp14
         XhOdD1Vls/0VAWjV7gkoGzEmy6FwKJfhto3WP+6w=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AO4Gxpj043474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 22:16:59 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 23
 Nov 2020 22:16:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 23 Nov 2020 22:16:59 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AO4Gs3L026518;
        Mon, 23 Nov 2020 22:16:54 -0600
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
To:     Nishanth Menon <nm@ti.com>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
 <20201119132829.sr435jf6s4275q4i@boxlike>
 <313a9cd5-7411-4ae1-cde4-42a2c18d11e6@ti.com>
 <20201124012100.fq7w7bjxvewuhbt2@shirt>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <8885dd79-061b-82e3-1aeb-a318f7d8256d@ti.com>
Date:   Tue, 24 Nov 2020 09:46:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201124012100.fq7w7bjxvewuhbt2@shirt>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/20 6:51 AM, Nishanth Menon wrote:
> On 09:45-20201123, Sekhar Nori wrote:
>>>> The main reason I commented - is hope to get some clarification from DT maintainers.
>>>> 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
>>>> (most often is present in PCI and GIC nodes).
>>>> and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
>>>>
>>>> And there is no "never" here - #address-cells always can be added if really required.
>>>
>>>
>>> OK - as a GPIO node, but as an interrupt-controller node, I was
>>> looking at [1] and wondering if that was the precedence.
>>>
>>> Yes, will be good to get direction from the DT maintainers on this
>>> topic.
>>
>> Shall I respin this series with 2/4 dropped while we wait for decision
>> on this?
>>
>> #address-cells warnings on interrupt controller can perhaps be handled
>> all at once (there are many of those in existing DT anyway).
>>
>> GPIO is basic support and holds up many other modules (like MMC/SD).
> 
> 
> There are'nt too many new patches in my queue that depends on GPIO, I'd
> rather not introduce new warnings unless we are completely at a
> stalemate. I'd rather use this opportunity to understand where what we
> need to be doing.
GPIO was originally submitted as part of 8  patch series titled "[PATCH
0/8] Add support for UHS modes in TI's J721e and J7200 boards"

Rest of those patches need to be resubmitted after GPIO is accepted.

Can you apply patch 1/4 at least. Its fairly non-controversial. It will
help reduce patch backlog and fix some warnings too.

Thanks,
Sekhar
