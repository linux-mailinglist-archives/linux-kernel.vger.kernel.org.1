Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A962E263A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgLXLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:19:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35668 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgLXLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:19:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBHJjJ076204;
        Thu, 24 Dec 2020 05:17:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808639;
        bh=X8lkmYvm2LZftzAI7MPmXYXTlNDPCOiWt9wiFwCLMFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s3WdSe+g8q4e8MUUczFGswhcSW4YYOEuehaKawKzB8TeTEImOzKn1fBn2ioFyItY0
         cFgeljLBvVsN2oVXHL+Kw92gAaU97pdJYDtDCjUSr5/Z/bGL01hxzjs60J0UfFBZXG
         4r05d+GvWqh3xP/A5tDHQYdZIMEAGWF4K9tXU8JQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBHJlw058539
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:19 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:19 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGE116630;
        Thu, 24 Dec 2020 05:17:15 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 08/15] phy: cadence: cadence-sierra: Explicitly request exclusive reset control
Date:   Thu, 24 Dec 2020 16:46:20 +0530
Message-ID: <20201224111627.32590-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Since the reset controls obtained in
Sierra is exclusively used by the Sierra device, use
exclusive reset control request API calls.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 935f165404e4..44c52a0842dc 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -514,14 +514,14 @@ static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 {
 	struct reset_control *rst;
 
-	rst = devm_reset_control_get(dev, "sierra_reset");
+	rst = devm_reset_control_get_exclusive(dev, "sierra_reset");
 	if (IS_ERR(rst)) {
 		dev_err(dev, "failed to get reset\n");
 		return PTR_ERR(rst);
 	}
 	sp->phy_rst = rst;
 
-	rst = devm_reset_control_get_optional(dev, "sierra_apb");
+	rst = devm_reset_control_get_optional_exclusive(dev, "sierra_apb");
 	if (IS_ERR(rst)) {
 		dev_err(dev, "failed to get apb reset\n");
 		return PTR_ERR(rst);
-- 
2.17.1

