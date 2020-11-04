Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C27F2A70BA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgKDWoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:44:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35478 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgKDWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:44:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4Mi1VU123264;
        Wed, 4 Nov 2020 16:44:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604529841;
        bh=ZmoEyVktKbh5GUrM+dQB0O/xJyQiUCY1m2L+8gQI39M=;
        h=From:To:CC:Subject:Date;
        b=PWWM8Rt5ywhmSgKIy8+07dL3d1elcVC0PUuEybqtskWSLwfOHAEhB3QJvqnr+ioWf
         cv7AMYLNRAX1WKOQvRFwFZjUe9RhTIRBNeQY//nqHy/44sA611hQRCCwBkaCvzF4bY
         iDtRMeLPZErFL/rhDAUsAt3ayYje7sjICyyS5h6o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4Mi1wp056057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 16:44:01 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 16:44:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 16:44:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4Mi0K3124654;
        Wed, 4 Nov 2020 16:44:00 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: Cleanup mix of "okay" and "disabled" usage
Date:   Wed, 4 Nov 2020 16:43:52 -0600
Message-ID: <20201104224356.18040-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is hopefully a conclusion of the thread we had (online[1] and
offline). There are few options one could take when dealing with SoC
dtsi and board dts:

a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
   to prevent messy board files, when more boards are added per SoC, we
   optimize and disable commonly un-used nodes in board-common.dtsi
b. SoC dtsi disables all hardware dependent nodes by default and board
   dts files enable nodes based on a need basis.
c. Subjectively pick and choose which nodes we will disable by default
   in SoC dtsi and over the years we can optimize things and change
   default state depending on the need.

What we have today is a bit of a mix of seemingly random set of
choices, however, predominantly following (a) and a few intermittent
cases of (b) and (c). While there are pros and cons on each of these
approaches, the right thing to do will be to stick with device tree
default (aka device tree standards) and work within those established
rules. So, lets cleanup and follow what the vast majority of SoC
platforms are doing and which also happens to be the path of least churn
for TI dts nodes as well.

Functionally the dtb output is same ->
a) As of v5.10-rc1:
   am654: https://pastebin.ubuntu.com/p/G4P5vghpV3/
   j7200: https://pastebin.ubuntu.com/p/SsG6JtPzR9/
   j721e: https://pastebin.ubuntu.com/p/HWXmTwD6m8/

b) with this series applied:
   am654: https://pastebin.ubuntu.com/p/h7MmHPQpRx/
   j7200: https://pastebin.ubuntu.com/p/VXjQHhQNgn/
   j721e: https://pastebin.ubuntu.com/p/2JMgftd4Xx/

The actual diff between the two versions being: https://pastebin.ubuntu.com/p/4rwy5qRY84/
Which is equivalent as per device tree standards, but uses lesser
redundant strings.

Thanks Tony, for sticking to the guns and providing us clear guidance
on this topic.

[1] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/

Nishanth Menon (4):
  arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
  arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
  arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay"
    for crypto
  arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to
    "okay" for USB

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  9 ----
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 24 ++++++----
 .../dts/ti/k3-j721e-common-proc-board.dts     | 48 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 28 -----------
 4 files changed, 63 insertions(+), 46 deletions(-)

-- 
2.29.2

