Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98802303665
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbhAZGTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:19:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60416 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbhAYNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:24:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10PBVQJ9109487;
        Mon, 25 Jan 2021 05:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611574286;
        bh=5Sxp0GXPWVYA9x+prZ82naIXZHuHdJg+ZW31CCauN0E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TGwI0cbaj7DOKJGGFEmCeSrZPVDxOZa9MfA4dEHqhdxZ9XkVeDg8MhnaVbb68VjBQ
         rH2YePFdbCzp2b0VEewHb8ShO1AVE8rrmSZHQSrXMJLEY7Zd1N2v84Mh0n4X4UeY6K
         YSfBcA/HtKJX+Dl1rvUPgVyiKhE8vpRG19mWsEu8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10PBVQox049378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jan 2021 05:31:26 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 Jan 2021 05:31:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 Jan 2021 05:31:26 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10PBVM4g017388;
        Mon, 25 Jan 2021 05:31:23 -0600
Subject: Re: [PATCH v2 00/14] PHY: Add support in Sierra to use external clock
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201222070520.28132-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ba7beace-e5b2-5020-2857-069de6aef6a6@ti.com>
Date:   Mon, 25 Jan 2021 17:01:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/20 12:35 pm, Kishon Vijay Abraham I wrote:
> The previous version of the patch series can be found @ [1]
> 
> Changes from v1:
> 1) Remove the part that prevents configuration if the SERDES is already
>    configured and focus only on using external clock and the associated
>    cleanups
> 2) Change patch ordering
> 3) Use exclusive reset control APIs
> 4) Fix error handling code
> 5) Include DT patches in this series (I can send this separately to DT
> MAINTAINER once the driver patches are merged)
> 
> [1] -> http://lore.kernel.org/r/20201103035556.21260-1-kishon@ti.com
> 
I have couple of reports from kernel test robot. If there are any other
comments on this series, I can fix them.

Thanks
Kishon

> Kishon Vijay Abraham I (14):
>   phy: cadence: Sierra: Fix PHY power_on sequence
>   phy: ti: j721e-wiz: Invoke wiz_init() before
>     of_platform_device_create()
>   dt-bindings: phy: cadence-sierra: Add bindings for the PLLs within
>     SERDES
>   phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link"
>     subnode
>   phy: cadence: cadence-sierra: Create PHY only for "phy" or "link"
>     sub-nodes
>   phy: cadence: cadence-sierra: Move all clk_get_*() to a separate
>     function
>   phy: cadence: cadence-sierra: Move all reset_control_get*() to a
>     separate function
>   phy: cadence: cadence-sierra: Explicitly request exclusive reset
>     control
>   phy: cadence: sierra: Model reference receiver as clocks (gate clocks)
>   phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
>   arm64: dts: ti: k3-j721e-main: Add DT nodes for clocks within Sierra
>     SERDES
>   arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
>   arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for
>     SERDES
>   arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as
>     "phy"
> 
>  .../bindings/phy/phy-cadence-sierra.yaml      |  89 ++-
>  .../dts/ti/k3-j721e-common-proc-board.dts     |  57 +-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 186 ++++--
>  drivers/phy/cadence/phy-cadence-sierra.c      | 543 ++++++++++++++++--
>  drivers/phy/ti/phy-j721e-wiz.c                |  21 +-
>  5 files changed, 808 insertions(+), 88 deletions(-)
> 
