Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5227E950
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgI3NSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:18:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54104 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3NSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:18:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDICOZ119204;
        Wed, 30 Sep 2020 08:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601471892;
        bh=g3P+tTvRBhBJ0CqML1eeeCRB2CNFF8mL6TWF/a+RuYY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r/iZui1Uao/T0zSrfNupfdtdwPlPxLaKcCMwA3EfcC8gN574tSresLkOSVv+u8ary
         Od8NCCQ9vX8wa2urAlf1aFrWZVYiyAKv0gsQMQZm08vGCefNxPgTMbCO/XaB0YS39V
         gHq8BD4bP+bzGdQZ3kfHSjkp15oY11whsKaBbaFA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UDICEn072783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 08:18:12 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:18:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:18:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDICZj087889;
        Wed, 30 Sep 2020 08:18:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>, <nsekhar@ti.com>
Subject: Re: [PATCH v5 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Date:   Wed, 30 Sep 2020 08:18:11 -0500
Message-ID: <160147173534.23544.3459300161168133887.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122032.23481-1-rogerq@ti.com>
References: <20200930122032.23481-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 15:20:26 +0300, Roger Quadros wrote:
> This series adds USB2.0 support for the J7200 EVM.
> 
> Series is based on top of: linux-next next-20200930
> 
> cheers,
> -roger
> 
> [...]

Hi Roger Quadros,

I have applied the following to branch ti-k3-dts-next on [1] along with
ti-k3-dt-fixes-for-v5.9.

Thank you!

[1/6] dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
      commit: ba90e0c92666979298a2c42ca396ac56d00cf33e
[2/6] arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
      commit: 1509295295c03c570bd65c3e393b334c188218cd
[3/6] arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
      commit: 9a09e6e9cfcf5424e78636e9b9585de5c07407bc
[4/6] arm64: dts: ti: k3-j7200-main: Add USB controller
      commit: 6197d7139d128d3391a94bfad467ffe349a869a6
[5/6] arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane function
      commit: e38a45b0192c4562e610c9c81e4c742b48fa69f0
[6/6] arm64: dts: ti: k3-j7200-common-proc-board: Add USB support
      commit: bbcb0522ae0cea0f2561e7dad243f8a3d5ab5559


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

