Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB52B90D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgKSLUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:20:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50404 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgKSLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:20:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJBK3Ul126808;
        Thu, 19 Nov 2020 05:20:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605784803;
        bh=Zew0Dvi2A89HNOW/hn1DEVlys9zIWcTVd/zrs46sbvI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gwv/IW0RR+LhAHiLskQ3JJkFa5xfFd5eDOuptCIrGCU3uStKnJW8PoZDxgo3BH3kR
         pfzyEU++TqqJJpbgyXkAYSNFceYZebl62cZQTqjRTKlHXeQ94u875WUmBUBdWtBDDN
         LQtWpu8/bbC+PLHMp/iX+1Xd2J1kKLfpqyIjN/Vk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJBK3Fq049958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 05:20:03 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 05:20:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 05:20:03 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJBK09a086175;
        Thu, 19 Nov 2020 05:20:01 -0600
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: J7200 GPIO support and warning
 fixes
To:     Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20201117161942.38754-1-nsekhar@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <9263dd46-15d0-7d8e-ae1c-0acafc46f57d@ti.com>
Date:   Thu, 19 Nov 2020 13:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117161942.38754-1-nsekhar@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2020 18:19, Sekhar Nori wrote:
> These patches add gpio support for TI's J7200 platform. The first
> two patches fix existing warnings in preparation for adding GPIO
> support.
> 
> Changes in v2:
> - Add patches fixing existing warnings so GPIO support does not
>    end up adding more warnings
> - Addressed Nishanth's comments on GPIO patches
>    - merge patches adding main and wakeup domain GPIOs into single patch
>    - fix commit description going over 75 chars
>    - fix W=2 warnings about lack of #address-cells in GPIO nodes


> 
> Faiz Abbas (2):
>    arm64: dts: ti: k3-j7200: Add gpio nodes
>    arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
>      modules
> 
> Sekhar Nori (2):
>    arm64: dts: ti: k3: squelch warning about lack of #interrupt-cells
>    arm64: dts: ti: k3: squelch warnings regarding no #address-cells for
>      interrupt-controller
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  6 ++
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  2 +
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts |  1 +
>   .../dts/ti/k3-j7200-common-proc-board.dts     | 16 ++++
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 75 +++++++++++++++++++
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 35 +++++++++
>   .../dts/ti/k3-j721e-common-proc-board.dts     |  1 +
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 12 +++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  3 +
>   9 files changed, 151 insertions(+)
> 

For patches 1,3,4
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
-- 
Best regards,
grygorii
