Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F12C03AC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgKWKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:49:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55150 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKWKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:49:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ANAnauO062166;
        Mon, 23 Nov 2020 04:49:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606128576;
        bh=doxgCA0KKX7am9PImJvHoj3LukpJfzg33PGccXuEGq0=;
        h=From:To:CC:Subject:Date;
        b=DXwH3L8qePkyPs69vDlSaIo0ZjaFKeTTDMfG/PV9oC1uhSF+BgWP7CnZ04oCZtmEs
         diy6hYWmlV77r300iC2IeJAIEWmah5gvOW3puZpg/3AvjLgiCBwbz7z6PxXMka6DQh
         Rp8ELwidahXbBBZoDTMv22ARq04lfJ9Hbih+vtQU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ANAna9n115464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 04:49:36 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 23
 Nov 2020 04:49:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 23 Nov 2020 04:49:36 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ANAnXQq028102;
        Mon, 23 Nov 2020 04:49:34 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <peter.chen@nxp.com>, <pawell@cadence.com>
CC:     <balbi@kernel.org>, <nm@ti.com>, <nsekhar@ti.com>,
        <a-govindraju@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: cdns3: fix NULL pointer dereference on no platform data
Date:   Mon, 23 Nov 2020 12:49:31 +0200
Message-ID: <20201123104931.2653-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms (e.g. TI) will not have any platform data which will
lead to NULL pointer dereference if we don't check for NULL pdata.

Fixes: a284b7fd1b8f ("usb: cdns3: add quirk for enable runtime pm by default")
Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c | 2 +-
 drivers/usb/cdns3/host.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 54d841aa626f..0f08aebce86d 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -559,7 +559,7 @@ static int cdns3_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(dev, true);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-	if (!(cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
+	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
 		pm_runtime_forbid(dev);
 
 	/*
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 08103785a17a..ec89f2e5430f 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -59,7 +59,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
 		goto err1;
 	}
 
-	if (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)
+	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
 		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	ret = platform_device_add_data(xhci, cdns->xhci_plat_data,
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

