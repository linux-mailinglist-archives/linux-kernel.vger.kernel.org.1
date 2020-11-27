Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7612C686A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgK0PEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:04:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36150 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgK0PEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:04:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ARF4Akg027347;
        Fri, 27 Nov 2020 09:04:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606489450;
        bh=u0w408qjZ9bnyZfmajcIyWVIWlHhutRgdIos8Ye9HkQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tw4LdPnVT6SE2SHBPASz8yLDIja/GOHTOi8zv/LKYGqQ5e44gY6W1U0AVLx8moLBl
         gpWRVJc886w6yRpMN2iS4ZJXTv4woERpWZd6aiURA6fp/GzbJ4xw110XCLDVhEn/DY
         K2SXGXJKKgRfY5NdhxHON1adB9BY4ZSIqpLYHqtQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ARF4Amv019086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 09:04:10 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 27
 Nov 2020 09:04:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 27 Nov 2020 09:04:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ARF4AQl091968;
        Fri, 27 Nov 2020 09:04:10 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j7200-som/cpb: Correct i2c bus representations
Date:   Fri, 27 Nov 2020 09:04:08 -0600
Message-ID: <160648942066.9765.8770096338187819245.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120073533.24486-1-peter.ujfalusi@ti.com>
References: <20201120073533.24486-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 09:35:31 +0200, Peter Ujfalusi wrote:
> Changes since v1:
> - Added REviewed-by from Vignesh
> - Comment block to explain main_i2c1 connection to CPB
> 
> The main_i2c0 missed the ioexpander present on the SOM itself to control muxes
> to route signals to CPB connectors.
> 
> [...]

Hi Peter Ujfalusi,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j7200-som-p0: main_i2c0 have an ioexpander on the SOM
      commit: b6633d778675a58fba1d7f795169da212a76231d
[2/2] arm64: dts: ti: k3-j7200-common-proc-board: Correct the name of io expander on main_i2c1
      commit: 2eefbf5f862ed98a043917fa54c7a79a56ec08f6


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

