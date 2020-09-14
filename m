Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615B6268B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgINMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:42:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55648 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgINMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:35:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ECYfEK008278;
        Mon, 14 Sep 2020 07:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600086881;
        bh=iZ36DYYwwn935GJlNS/klU1CS9JBOktHWLkEslO30bg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Spz4rg+1S6Lrt+muwSV8y5lRtK8PtADMJvjzTOhiQdOFibqTVLa9egBSivIDeT/Dt
         hzUPtO/AiDw+D/48y8ynSD4bH4awFYPcxypNBhERThykcdL6I8ROEk2TcsqEe9pYMD
         Sjc4hyzRcazAewsZaVYsYK67042k2bXz8lcHWjoM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ECYfNP047391;
        Mon, 14 Sep 2020 07:34:41 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 07:34:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 07:34:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ECYf6B126142;
        Mon, 14 Sep 2020 07:34:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <santosh.shilimkar@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
Date:   Mon, 14 Sep 2020 07:34:39 -0500
Message-ID: <160008683286.21302.10845118207565494240.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829184139.15547-1-grygorii.strashko@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 21:41:36 +0300, Grygorii Strashko wrote:
> I've rebased on top of  linux-next and identified merge conflict of patch 3
> with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM resource types")
> in -next.

Hi Grygorii Strashko,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am65: ringacc: drop ti, dma-ring-reset-quirk
      commit: 69fba6172b9f03ad1079c9c72f5cf0c623a18c6d


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

