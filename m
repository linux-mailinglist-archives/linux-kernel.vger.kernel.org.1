Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84F30037C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAVMvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:51:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59148 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAVMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:51:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10MCntfR080870;
        Fri, 22 Jan 2021 06:49:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611319795;
        bh=vpLR1jA8DPCM6b5GBCm4iu9IbosfT8CPoAtVlNsYcXA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jVcMmc3aOHdY+7LEvgYmffQcYlDaCpuJPGCNoEjIl5o46XcVmjimoRwvAFkbfg/jM
         xjEJZ3fAuH4OIA8P9z3pak306n9cbSxP877cPTwuWNL0WxRVi3nOir+//Kq1xioXrE
         ygg8K9THXI9rQ3i+obWVhVHifn0RjrYC9MqBvj74=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10MCntAd007169
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 06:49:55 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 Jan 2021 06:49:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 Jan 2021 06:49:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10MCns1F058135;
        Fri, 22 Jan 2021 06:49:54 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>,
        Nishanth Menon <nm@ti.com>, Sudeep Holla <sudeep.holla@arm.com>
CC:     Tero Kristo <kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3*: Fixup PMU compatibility to be CPU specific
Date:   Fri, 22 Jan 2021 06:49:53 -0600
Message-ID: <161131975585.21423.9075334839139359625.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120195145.32259-1-nm@ti.com>
References: <20210120195145.32259-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 13:51:45 -0600, Nishanth Menon wrote:
> We can use CPU specific pmu configuration to expose the appropriate
> CPU specific events rather than just the basic generic pmuv3 perf
> events.

Hi Nishanth Menon,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3*: Fixup PMU compatibility to be CPU specific
      commit: c72bf319f12803d8c8ddc3dbf54927380fc65b50


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

