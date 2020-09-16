Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E900326D9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIQLKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:10:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52308 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIQLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:10:40 -0400
X-Greylist: delayed 24566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:10:39 EDT
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCZrtR071777;
        Wed, 16 Sep 2020 07:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600259753;
        bh=1Da8xmW4YCbtBzyHtH9tA0Z9gjhWVtmOrMv90+ULU+Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GzTUH0486+ObN4fqS1rw2oZoDyi4ZgwmzYmWiVaCIkflaSiApb/fh8/g9zzgRLJ+k
         2CG6/eWFf83xr8nYcZ1gFC/NuROFBb1RmywxJzo+rcB3vJs/pRyzSUnutun5gMUO1c
         dJWM51TOCvrqx6stCUUYux8blGmZjFASGjqcu5RI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GCZrQe085606
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 07:35:53 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:35:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:35:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCZrWa095396;
        Wed, 16 Sep 2020 07:35:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] Add DT to get PCIe working in J721E SoC
Date:   Wed, 16 Sep 2020 07:35:51 -0500
Message-ID: <160025957194.1798.2528791511684340016.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914152115.1788-1-kishon@ti.com>
References: <20200914152115.1788-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 20:51:13 +0530, Kishon Vijay Abraham I wrote:
> Now that J721E PCIe support is merged (including the YAML bindings),
> add PCIe device tree nodes to get PCIe working in J721E SoC both in
> RC mode and EP mode.
> 
> Series has been rebased to:
> git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux ti-k3-dts-next
> 
> [...]

Hi Kishon Vijay Abraham I,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
      commit: 1a0361c153c2b241d9286d977ae6405a84efb4e4
[2/2] arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances
      commit: c5e91b849c807949959045a2fc03754404a74faa


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

