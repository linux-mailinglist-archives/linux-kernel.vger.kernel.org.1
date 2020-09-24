Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7DA276F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIXLNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:13:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgIXLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:13:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBDQUS042544;
        Thu, 24 Sep 2020 06:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600946006;
        bh=CGDMjLiRfWcLMFZW+6G8I1fMQNV1IX0vtYvWoHRS1Hc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=miQDfvEFpP1eK/4LVw1DfjBOlZSEKJNnT3/s4p7ZIrPuueya4Z2JnQ7f6wZZzpcUq
         oUBJzoV7tUgr/xdDVQ7j4/jQFrJI9ivYZ7JBdh7Cpn+GlxB0/LfKhp3C5sabDBVmlz
         p0zP+nrqco7b1uoGDXdWGnxhfgRjAMSOgXhriHNA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBDQsf047311;
        Thu, 24 Sep 2020 06:13:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:13:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:13:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBDPED073946;
        Thu, 24 Sep 2020 06:13:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] J7200: Add I2C support
Date:   Thu, 24 Sep 2020 06:13:24 -0500
Message-ID: <160094581403.6691.7126086748501099348.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923155400.13757-1-vigneshr@ti.com>
References: <20200923155400.13757-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 21:23:58 +0530, Vignesh Raghavendra wrote:
> Add I2C and I2C IO expanders nodes for J7200
> 
> v2:
> Align reg address format with that of file's (s/0x0/0x00)
> 
> Vignesh Raghavendra (2):
>   arm64: dts: ti: j7200: Add I2C nodes
>   arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders
> 
> [...]

Hi Vignesh Raghavendra,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: j7200: Add I2C nodes
      commit: afc0406bd8a797d8d5066e935eb7c098cf9449de
[2/2] arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders
      commit: ef0b69464cc5182b35e8b4a7b0652f5ccef9c70a


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

