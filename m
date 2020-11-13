Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773B22B1B93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:07:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47100 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:07:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADD7gxd037452;
        Fri, 13 Nov 2020 07:07:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605272862;
        bh=MZetkdzy5NmLs2nrSR/vKGdfaKIi0DPhzBlVb4gpGV4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cVpW0neSdB/sxkbCH7z9C81T3P389tA0w99C51hrrjX7p2gsa8fvXrZmFdVPODLg4
         e+3Ct9ov9NJG6ped8uzYkaMhBPPCuqMAqlx9Dt/NSpsX0NSkFcpOv8KQ35QlSpiipd
         jdZmLdsV11pkmgM6SHaYoWi4KbZBWyD80HWDmjlA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADD7gDp041638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 07:07:42 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 07:07:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 07:07:41 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADD7feZ045904;
        Fri, 13 Nov 2020 07:07:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3 0/5] arm64: dts: ti: Cleanup mix of "okay" and "disabled"
Date:   Fri, 13 Nov 2020 07:07:40 -0600
Message-ID: <160527282700.18648.6417116883997393632.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112183538.6805-1-nm@ti.com>
References: <20201112183538.6805-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 12:35:33 -0600, Nishanth Menon wrote:
> Changes since v2[3]:
> - Rebase on top of ti-k3-dts-next (no functional changes)
> - picked up reviewed-by and acks from folks.
> 
> Since we have all the required acks and reviews, I will apply this
> series tomorrow morning since this can cause churn for other folks.
> 
> [...]

Hi,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
      commit: 957c8a49d2ed0d9ed710c8643d43912b64a3708a
[2/5] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
      commit: f388cb320905e0908429ce5ce8b14b5fadb6a1ea
[3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay" for crypto
      commit: 2fcb0ff200d0c9b0c5cab541cc8f8444d937e9ca
[4/5] arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to "okay" for USB
      commit: 399e08d521a34ca8180c8eaeaf181176ace85b47
[5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as "reserved"
      commit: cf2e8c96b52984319c27f1e0b68fbef712df9bb9


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

