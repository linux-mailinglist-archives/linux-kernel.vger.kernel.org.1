Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981D6300370
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbhAVMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:46:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42192 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbhAVMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:45:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10MCiasM079298;
        Fri, 22 Jan 2021 06:44:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611319476;
        bh=JU1Lsif7fCk3o1th5LDZDKioK0SmgdAuCnQ6RlZm29A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jf4hvY1C+lLHQMOTkcgm+0U+gFsbPAZ/u2n97G5eCz08c9S0y3vTdPNMNK2sCegeB
         CEoDIz4gUBcL/G+EAvWtBx9YDMGolO0pU6R/JxBO7HCO+YcnX0P53cgkQYZhMQXyOP
         xgw7CMkcVR6WpPYTY3KLcYzClq5Iz48i/1vtmeZ0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10MCiaRx035869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 06:44:36 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 Jan 2021 06:44:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 Jan 2021 06:44:36 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10MCial4130452;
        Fri, 22 Jan 2021 06:44:36 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] arm64: dts: ti: k3: mmc: fix dtbs_check warnings
Date:   Fri, 22 Jan 2021 06:44:34 -0600
Message-ID: <161131945983.18733.6600361051689989658.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115193016.5581-1-grygorii.strashko@ti.com>
References: <20210115193016.5581-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 21:30:16 +0200, Grygorii Strashko wrote:
> Now the dtbs_check produces below warnings
>  sdhci@4f80000: clock-names:0: 'clk_ahb' was expected
>  sdhci@4f80000: clock-names:1: 'clk_xin' was expected
>  $nodename:0: 'sdhci@4f80000' does not match '^mmc(@.*)?$'
> 
> Fix above warnings by updating mmc DT definitions to follow
> sdhci-am654.yaml bindings:
>  - rename sdhci dt nodes to 'mmc@'
>  - swap clk_xin/clk_ahb clocks, the clk_ahb clock expected to be defined
> first

Hi Grygorii Strashko,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3: mmc: fix dtbs_check warnings
      commit: 0cf73209ce2c60c5b717a02d9de10a6d524e08a6


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

