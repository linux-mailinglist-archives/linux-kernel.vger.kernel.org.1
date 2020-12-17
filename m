Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43B2DD1EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgLQNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:09:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50506 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLQNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:09:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BHD7OEr033001;
        Thu, 17 Dec 2020 07:07:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608210444;
        bh=D/VSBZvzb9Viejgx4Q5CUUYcQEROnJho5fEm8VMYcl4=;
        h=From:To:CC:Subject:Date;
        b=i4O6uQB42oJIjshZdEZLbUkmBkLaL1d/7IQ/ZUneWAUdojsscY8G14nK1Yd7RuBWa
         T1ZIhvVG3Y3nsB0tIMrqV5+Yr3Yz8Up2+piOx7fbBhvgk/kv+StdDa2rjhZ4wlIJzl
         FvijnYLAkKNKJMgfVXq9b3I0+quAfVuSSnMsj9cs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BHD7Ohq089115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 07:07:24 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Dec 2020 07:07:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Dec 2020 07:07:24 -0600
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BHD7MRM046199;
        Thu, 17 Dec 2020 07:07:22 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH] MAINTAINERS: Update my email address and maintainer level status
Date:   Thu, 17 Dec 2020 15:07:21 +0200
Message-ID: <20201217130721.23555-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My employment with TI is ending tomorrow, so update the email address
entry in the maintainers file. Also, I don't expect to spend that much
time with maintaining TI code anymore, so downgrade the status level to
odd fixes only on areas where I remain as the main contact point for
now, and move myself as secondary contact point where someone else has
taken over the maintainership.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tero Kristo <kristo@kernel.org>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f59ebd1eda3d..c362d8d9d316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2615,8 +2615,8 @@ S:	Maintained
 F:	drivers/power/reset/keystone-reset.c
 
 ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
-M:	Tero Kristo <t-kristo@ti.com>
 M:	Nishanth Menon <nm@ti.com>
+M:	Tero Kristo <kristo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -6465,9 +6465,9 @@ S:	Maintained
 F:	drivers/edac/skx_*.[ch]
 
 EDAC-TI
-M:	Tero Kristo <t-kristo@ti.com>
+M:	Tero Kristo <kristo@kernel.org>
 L:	linux-edac@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/edac/ti_edac.c
 
 EDIROL UA-101/UA-1000 DRIVER
@@ -17503,7 +17503,7 @@ F:	drivers/iio/dac/ti-dac7612.c
 
 TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TISCI) PROTOCOL DRIVER
 M:	Nishanth Menon <nm@ti.com>
-M:	Tero Kristo <t-kristo@ti.com>
+M:	Tero Kristo <kristo@kernel.org>
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
@@ -17647,9 +17647,9 @@ S:	Maintained
 F:	drivers/clk/clk-cdce706.c
 
 TI CLOCK DRIVER
-M:	Tero Kristo <t-kristo@ti.com>
+M:	Tero Kristo <kristo@kernel.org>
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/clk/ti/
 F:	include/linux/clk/ti.h
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
