Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A813B2FB233
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbhASGzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:55:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55718 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389541AbhASF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:29:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10J5SHn6107404;
        Mon, 18 Jan 2021 23:28:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611034097;
        bh=P84E62N8TVeB4W4nzlsbIsQbTAOSl6XX6QtuJ8sPF9M=;
        h=From:To:CC:Subject:Date;
        b=k+NwWc/pxVDwWTWvYNWmOTm33sBitSarHwMdHXv4gafocHmzzeMFC9JXvNmWvMZqW
         uoEv/COT77ceYQHS2OHoefyNCQBSn+1LmvdoYkhocmyaq8q1tOdJcwVjBqiwYPMPUH
         U3TeSHGdwHUkuzH1kov6eoao8Q8ouNOJL0zxBTp0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10J5SHX1063201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jan 2021 23:28:17 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 Jan 2021 23:28:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 Jan 2021 23:28:16 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10J5SCS8011267;
        Mon, 18 Jan 2021 23:28:12 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: cdns3: Add support for TI's AM64 SoC
Date:   Tue, 19 Jan 2021 10:58:10 +0530
Message-ID: <20210119052810.20457-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USB controller present on the AM64x SoC.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 90e246601537..eccb1c766bba 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -214,6 +214,7 @@ static int cdns_ti_remove(struct platform_device *pdev)
 
 static const struct of_device_id cdns_ti_of_match[] = {
 	{ .compatible = "ti,j721e-usb", },
+	{ .compatible = "ti,am64-usb", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, cdns_ti_of_match);
-- 
2.17.1

