Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5DA280790
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgJATNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:13:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57434 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJATNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:13:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091JD339002532;
        Thu, 1 Oct 2020 14:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601579583;
        bh=XkRsE/80MRGiiYxpscQ9aSHG+du3GrkIZbvGNcB8JWY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vaf1e7i2jcFrWkk3maT0czQLrpNCcChbCW/JHj94fDcCVVfnvg53FRyqhNCAHao3r
         xVM5pDNQw8R9N6fspZwUsOLUx2DEYu4Hqx/eZq9F1xQp/pNkDMywHkgowEKXKBXwMc
         zyBPhvfDUzwiTEGg6GZABV/7ZOkRCyh54MtzYCYQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091JD356102200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 14:13:03 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:13:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:13:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091JD2gh002174;
        Thu, 1 Oct 2020 14:13:02 -0500
Date:   Thu, 1 Oct 2020 14:13:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
Subject: Re: [PATCH 0/8] Add support for UHS modes in TI's J721e and J7200
 boards
Message-ID: <20201001191302.dlp2tzbvkk35vzgd@akan>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001190541.6364-1-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:35-20201002, Faiz Abbas wrote:
> The following patches add support for UHS modes for TI's j721e and j7200
> boards.
> 
> Patches 1-3 add support for gpios to j7200-evm
> 
> Patches 4-6 add support for voltage regulators for required by the
> SD card in both devices as well as enable UHS modes at 1.8V
> 
> Patches 5-6 add some required configs to the arm64 defconfig.
> 
> This series depends on driver patches adding tuning support here:
> https://lore.kernel.org/linux-arm-kernel/20200923105206.7988-1-faiz_abbas@ti.com/
> 
> Faiz Abbas (8):
>   arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
>   arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
>   arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
>     modules
>   arm64: dts: ti: k3-j721e-main: Add output tap delay values
>   arm64: dts: ti: k3-j721e-common-proc-board: Add support SD card UHS
>     modes
>   arm64: dts: ti: k3-j7200-common-proc-board: Add support SD card UHS
>     modes

Split these up please!
>   arm64: defconfig: Enable OMAP I2C driver
>   arm64: defconfig: Enable DAVINCI_GPIO driver
> 

defconfig patches can be posted independent of dts patches, they go to
different branches.

Also, These are a little too late for 5.10 at this point.
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 48 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 69 ++++++++++++++++++-
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 32 +++++++++
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 35 +++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 22 ++++--
>  arch/arm64/configs/defconfig                  |  2 +
>  6 files changed, 201 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
