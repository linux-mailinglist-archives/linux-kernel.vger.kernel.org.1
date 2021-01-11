Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA52F1805
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbhAKOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:23:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46732 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732824AbhAKOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:23:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10BEMPp4034887;
        Mon, 11 Jan 2021 08:22:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610374945;
        bh=DME9XORExNjNrwApyDZ4ui75afAeH4B61CwZ4kIZ+po=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=myIpT0hvXZCQ+pjVHUShP0V6uLWvNnMGLwf4uLqhQLiMY9JU8tNrNtGGWZCuTgbO3
         OrgaJ7svo2ISXqIiBBSgaFnLFW+aTfPF6GL1fXOXz7rWWZTu0OQSEHHBSy3aQ786J2
         PHMuChmQavRsjXvdQH3lexXZd1Rq5QZnpaPm4v10=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10BEMPVI031018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 08:22:25 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 Jan 2021 08:22:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 Jan 2021 08:22:25 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10BEMOMV019519;
        Mon, 11 Jan 2021 08:22:25 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] PCI: J7200/J721E PCIe bindings
Date:   Mon, 11 Jan 2021 08:22:24 -0600
Message-ID: <161037479685.21603.17479522264383929681.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210105151421.23237-1-kishon@ti.com>
References: <20210105151421.23237-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 20:44:15 +0530, Kishon Vijay Abraham I wrote:
> Patch series adds DT nodes in order to get PCIe working in J7200.
> Also includes couple of fixes for J721e.
> 
> v1 of the patch series can be found @ [1]
> v2 of the patch series can be found @ [2]
> v3 of the patch series can be found @ [3]
> 
> [...]

Hi Kishon Vijay Abraham I,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
      commit: 0e3cfb868137cf7ced91d7dc709961000c0dae29
[2/6] arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for pcieX_ctrl
      commit: edb96779f3bcbe348f82b458077de0fb96118233
[3/6] arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
      commit: 4c1b22a953d9f8af4d5c2f238fb74dc190d92f04
[4/6] arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
      commit: 3276d9f53cf660f8ed60d98918170670d0ca6e54
[5/6] arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
      commit: 429c0259f17f4fdf9c0beb5423b0c8f6c2ea2e8c
[6/6] arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
      commit: 3a6319df506f1a821abad2c71a580a2f7b78a304


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

