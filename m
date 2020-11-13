Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F752B266C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKMVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:19:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42152 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgKMVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:18:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLIRla082649;
        Fri, 13 Nov 2020 15:18:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605302307;
        bh=H/YBy0D1xRXQyXu6CQyuteDri+FM48dUhUo4LeWgoUs=;
        h=From:To:CC:Subject:Date;
        b=mFwMZzviaMN/vipZYhoK9HOBnVpqaTrziKGTBKUpRMYrHYwXQwB4hnsrvhcpz43yl
         yPA9c+A2ZE8PT0IOgkuGbQc6uegil6yek4SDhVubS5rDo/AOP9AsiV4jbgVplAglQy
         nrDSjnM7H/0bbKL0g2F5dgBoGvMn7MEEQC7T1DxM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADLIRti118023
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 15:18:27 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 15:18:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 15:18:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLIQtq056929;
        Fri, 13 Nov 2020 15:18:27 -0600
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
Subject: [PATCH V4 0/5] arm64: dts: ti: Cleanup mix of "okay" and "disabled"
Date:   Fri, 13 Nov 2020 15:18:21 -0600
Message-ID: <20201113211826.13087-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

V4 changes:
- drops the fixes tags (as this is not strictly a stable fix)

Repost. older versions v3[3] v2[2] v1[1]

Summarising the blurb of the discussion[4] we have had, there are few
options one could take when dealing with SoC dtsi and board dts:

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
[2] https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-1-nm@ti.com/
[3] https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-1-nm@ti.com/
[4] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/
-- 
2.29.2

