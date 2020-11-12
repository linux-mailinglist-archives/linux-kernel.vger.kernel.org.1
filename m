Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3853C2B0CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKLSgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:36:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40442 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKLSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:35:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACIZg6b043383;
        Thu, 12 Nov 2020 12:35:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605206142;
        bh=L+/f7LbYwAqShIZzPwGgs/3FGHnnQPTqggOn1xmq7wM=;
        h=From:To:CC:Subject:Date;
        b=DKapKsBV4liJggTTzIPyD0bW2DW/O5v1H02NmCu8Ba0d1+vtWzztweDpja9vm19gX
         W+YPUJv/F1xvcu7q8nHtnNA8WPzYVERZHePWcQN31P1qgJh7sT5Rf+8UGuo5dSecRV
         KIlDIuwiEu0dpPKBPf76tAZZWI5yxLEDUwbTltC0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACIZgxW090290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 12:35:42 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 12:35:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 12:35:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACIZfe1128879;
        Thu, 12 Nov 2020 12:35:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 0/5] arm64: dts: ti: Cleanup mix of "okay" and "disabled"
Date:   Thu, 12 Nov 2020 12:35:33 -0600
Message-ID: <20201112183538.6805-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2[3]:
- Rebase on top of ti-k3-dts-next (no functional changes)
- picked up reviewed-by and acks from folks.

Since we have all the required acks and reviews, I will apply this
series tomorrow morning since this can cause churn for other folks.

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
[3] https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-1-nm@ti.com/
-- 
2.29.2

