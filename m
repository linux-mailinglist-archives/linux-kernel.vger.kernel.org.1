Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4272276F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgIXLNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:13:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgIXLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:13:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBDQll042546;
        Thu, 24 Sep 2020 06:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600946006;
        bh=XwfLjYFp2jwsCzESQtCyoGzKTJsrtkUeoml8Fo9Z80U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HDkJb0eFeRceVTGJ6pz34mJP6FwixIVd8nbq4/YxQ2b0tyNonVtOA9VOu8LxPwD9p
         3GBPHByjmUkRMrhwFaiL6WTp+9jc3SgFX6vZaZAIQlwRKV8XIYvIb6jPWgwxYnmIXi
         /h5B0I8D91Ln0K5jtFK3R5fA/pvJkeamboeXoSRk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBDQlc067873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:13:26 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:13:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:13:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBDPo3097129;
        Thu, 24 Sep 2020 06:13:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j7200: Add HyperFlash related nodes
Date:   Thu, 24 Sep 2020 06:13:23 -0500
Message-ID: <160094581404.6691.15021925542082151621.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923163150.16973-1-vigneshr@ti.com>
References: <20200923163150.16973-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 22:01:48 +0530, Vignesh Raghavendra wrote:
> This series adds HyperBus and HyperFlash nodes for TI's J7200 SoC
> 
> v2:
> Rebase on latest ti-k3-next + I2C series
> Align reg address format with this file's convention
> 
> Vignesh Raghavendra (2):
>   arm64: dts: ti: k3-j7200-mcu-wakeup: Add HyperBus node
>   arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node
> 
> [...]

Hi Vignesh Raghavendra,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j7200-mcu-wakeup: Add HyperBus node
      commit: b905466d930a17393f3b67514568b14cbd629b34
[2/2] arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node
      commit: 78af3696f4b92b1038805e480f21ba2f51353276


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

