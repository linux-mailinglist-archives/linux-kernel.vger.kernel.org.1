Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429562AFF07
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgKLFdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:33:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57352 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgKLBtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:49:53 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1ncR5087191;
        Wed, 11 Nov 2020 19:49:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605145778;
        bh=lRqbBvd7Jzj28LeXSmW/JNQRPNjf90HOGlYgPPE1PEI=;
        h=From:To:CC:Subject:Date;
        b=x5BkalG81lgnKA+WO89TXoJWztLzdod7qIqGT+W0Wx1yuiG04Dx97W/9oZIzCQoQE
         Z5V1hi7O/2Uuve5fnJpnIe2mXwrFszlhmRgtryGopMSHLoLtlNjrwnaAkctCgY6Akn
         BuASwLDNO/RGn9YhX4JIT07S0KRzPUc1i3Lp9iGg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC1ncdF103271
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 19:49:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 19:49:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 19:49:38 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC1nc8w028660;
        Wed, 11 Nov 2020 19:49:38 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/5] arm64: dts: ti: Cleanup mix of "okay" and "disabled" usage
Date:   Wed, 11 Nov 2020 19:49:24 -0600
Message-ID: <20201112014929.25227-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1[1]:
- Picked up Reviews from Tomi
- Added patch #5 for moving uart used by firmware to 'reserved'
  state (thanks Peter for pointing it out)
- Updated commit message of #1, #2 to add information about the
  limitation as well (thanks Peter for your inputs).

This is hopefully a conclusion of the thread we had
(online[2] and offline). There are few options one could take when
dealing with SoC dtsi and board dts

a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
   to prevent messy board files, when more boards are added per SoC, we
   optimize and disable commonly un-used nodes in board-common.dtsi
b. SoC dtsi disables all hardware dependent nodes by default and board
   dts files enable nodes based on a need basis.
c. Subjectively pick and choose which nodes we will disable by default
   in SoC dtsi and over the years we can optimize things and change
   default state depending on the need.

While there are pros and cons on each of these approaches, the right
thing to do will be to stick with device tree default standards and
work within those established rules. So, we choose to go with option
(a).

NOTE: There is a known risk of "omission" that new board dts
developers might miss reviewing both the board schematics in addition
to all the dt nodes of the SoC when setting appropriate nodes status
to "disable" or "reserved" in the board dts. This can expose issues in
drivers which may not anticipate an incomplete node(example: missing
appropriate board properties) being in "okay" state. These cases are
considered as bugs and need to be fixed in the drivers as and when
identified.

The dtb changes are limited to be functionaly equivalent similar to what
was published with v1.

dtb-> dts decompiled
a) As of v5.10-rc1:
   am654: https://pastebin.ubuntu.com/p/G4P5vghpV3/
   j721e: https://pastebin.ubuntu.com/p/HWXmTwD6m8/
   j7200: https://pastebin.ubuntu.com/p/SsG6JtPzR9/

b) with this series applied:
   am654: https://pastebin.ubuntu.com/p/pGdpbPQvyd/
   j721e: https://pastebin.ubuntu.com/p/PWcNMdtj5J/
   j7200: https://pastebin.ubuntu.com/p/NFxpNtyNr9/

Boot test logs(base v5.10-rc1):
am654: https://pastebin.ubuntu.com/p/pNngXcWy23/
j721e: https://pastebin.ubuntu.com/p/xjbXkHb7Gv/
j7200: https://pastebin.ubuntu.com/p/dn7MgfJJ2j/

Nishanth Menon (5):
  arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
  arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
  arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay"
    for crypto
  arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to
    "okay" for USB
  arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as
    "reserved"

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  9 ----
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 26 ++++++----
 .../dts/ti/k3-j7200-common-proc-board.dts     |  4 +-
 .../dts/ti/k3-j721e-common-proc-board.dts     | 50 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 28 -----------
 5 files changed, 67 insertions(+), 50 deletions(-)

[1] https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-1-nm@ti.com/
[2] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/
-- 
2.29.2

