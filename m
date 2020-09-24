Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A0276F29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgIXK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:59:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60952 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:59:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OAwu84034140;
        Thu, 24 Sep 2020 05:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600945136;
        bh=ZYaooliMG5ZmHlYisRjqi0EDHcM1XEQAdnWOAQuO3M4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mRugwMPlP0+cvrZgkvbTs5q2gSRqtYXknoQnORgX2KPDn9/60cDbRtjShnEQDV98K
         iDZJvd9HMispfh7KuZMLXKjdo2/p3m1FdkECxJvDoymHkshmYnUAClEM5FfZudnuaZ
         zAGRxUZPxz0wwW8Z4dHqK+hN2XMReWjUSYv0JweY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OAwuJn025745;
        Thu, 24 Sep 2020 05:58:56 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 05:58:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 05:58:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OAwu8e044564;
        Thu, 24 Sep 2020 05:58:56 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
Date:   Thu, 24 Sep 2020 05:58:55 -0500
Message-ID: <160094485503.28349.15928892177922171688.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923220938.30788-1-grygorii.strashko@ti.com>
References: <20200923220938.30788-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 01:09:34 +0300, Grygorii Strashko wrote:
> This series adds DT nodes for TI J7200 SoC
> - Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
>   with J721E Soc, to enable DMA support
> - MCU CPSW2g DT nodes to enable networking and board data
> 
> Changes in v4:
>  - fixed comments from Suman Anna <s-anna@ti.com>
> 
> [...]

Hi Grygorii Strashko,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j7200: add DMA support
      commit: fd409bfe0e44ea36ed6be77c331a001e50a9bc12
[2/4] arm64: dts: ti: k3-j7200-main: add main navss cpts node
      commit: 3273476c3b1c7ef61ec971ed866b9fb6660c82fe
[3/4] arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
      commit: e86fc00bb04b1d3d387ae6bf4d176bfa9859ea66
[4/4] arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux and phy defs
      commit: c67487a68e13ee450cbc45b622b8ee9a75f1812a


All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

