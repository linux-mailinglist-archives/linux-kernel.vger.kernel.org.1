Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320CD2C04EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgKWLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:51:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60136 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgKWLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:51:01 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ANBosDR041891;
        Mon, 23 Nov 2020 05:50:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606132254;
        bh=VGIzpMrZgaVOU8vwKntpuM8mPh2ladWjWcviAOLo8NA=;
        h=From:To:CC:Subject:Date;
        b=iSPi+IDPGvRnU3mg5yqyyMDAkiELa6gqYrQ919IGqffsYDNqyUC8PULHHgoc6ruSA
         QXoHSiS7D7A5gPjICv6X5Wj+Rn3FTi2/6sM8MlsLzOmDEoNLkYiUO73POmh4pySPCZ
         Z1iNupLPn5becJae5GMeic2sGbPJTThkObp2bP7s=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ANBosY1115028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 05:50:54 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 23
 Nov 2020 05:50:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 23 Nov 2020 05:50:54 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ANBoq2A004858;
        Mon, 23 Nov 2020 05:50:52 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <peter.chen@nxp.com>, <pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch class"
Date:   Mon, 23 Nov 2020 13:50:51 +0200
Message-ID: <20201123115051.30047-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 50642709f6590fe40afa6d22c32f23f5b842aed5.

This commit breaks hardware based role switching on TI platforms.
cdns->role_sw is always going to be non-zero as it is a pointer
to the usb_role_switch instance. Some other means needs to be used
if hardware based role switching is not required by the platform.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index a0f73d4711ae..4c1445cf2ad0 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -280,10 +280,6 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
 	enum usb_role real_role, current_role;
 	int ret = 0;
 
-	/* Depends on role switch class */
-	if (cdns->role_sw)
-		return 0;
-
 	pm_runtime_get_sync(cdns->dev);
 
 	current_role = cdns->role;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

