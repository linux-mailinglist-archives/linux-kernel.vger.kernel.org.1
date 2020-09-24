Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1D276592
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgIXBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:04:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36936 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgIXBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:04:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O146VY080308;
        Wed, 23 Sep 2020 20:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600909446;
        bh=AlKR8NqqXQKTOzZexkuHK5je8N3ww1hgscFybpkzGIc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B3vha1Rv5fOkpC0pXL6wfZdVZvoyB6hR0Bj8wmwZxU9iSgKZKi5/Zn6SuLCCBgled
         oWOzj47byhhB3sWUL67L89VFJRnfaK8k0mu4UVQYLuHae9TvJ56FZO2phlOyuRAkKG
         XJSN9DOYotd2Sgh0aN7t0fDi83WJf1mOo8WujWus=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O146nF041161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 20:04:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 20:04:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 20:04:06 -0500
Received: from [10.250.69.208] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O145aC032458;
        Wed, 23 Sep 2020 20:04:05 -0500
Subject: Re: [PATCH v4 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20200923220938.30788-1-grygorii.strashko@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <0231303c-ba6d-0d61-fdf7-42d5aec62458@ti.com>
Date:   Wed, 23 Sep 2020 20:04:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923220938.30788-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 5:09 PM, Grygorii Strashko wrote:
> Hi All,
> 
> This series adds DT nodes for TI J7200 SoC
> - Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
>   with J721E Soc, to enable DMA support
> - MCU CPSW2g DT nodes to enable networking and board data
> 
> Changes in v4:
>  - fixed comments from Suman Anna <s-anna@ti.com>
> 
> Changes in v3:
>  - rebase
>  - updated dependencies
>  - added tested-by
> 
> Changes in v2:
>  - fixed DT build warnings (Nishanth Menon)
> 
> v3: https://lore.kernel.org/patchwork/cover/1308044/
> v2: https://lore.kernel.org/patchwork/cover/1302290/
> v1: https://lore.kernel.org/patchwork/cover/1301067/
> 
> Grygorii Strashko (3):
>   arm64: dts: ti: k3-j7200-main: add main navss cpts node
>   arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
>   arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux
>     and phy defs
> 
> Peter Ujfalusi (1):
>   arm64: dts: ti: k3-j7200: add DMA support

Thank you for fixing my comments. For the series,

Reviewed-by: Suman Anna <s-anna@ti.com>

regards
Suman

> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  48 +++++++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++
>  3 files changed, 211 insertions(+)
> 

