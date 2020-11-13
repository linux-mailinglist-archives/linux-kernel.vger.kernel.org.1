Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF82B289E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMWhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:37:45 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50064 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgKMWhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:37:33 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BD4BEC0C1A;
        Fri, 13 Nov 2020 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605307052; bh=0DWq5jcTtdHUwk0lbGhb4NNysmCj/e/PGeWS1JSpIqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=h1d0xCJU41NCnbK4nT1qiW3GVBSskVk9qfDoLmWWh6nDVvXAv6Widk2SK1Hla/GG6
         QJgEOqHBzNjj23YbdPB4hw6lDwMCTlnpTvsAdQJ2U9Me6M36muTRbNgHz+JsH4swvw
         hZcIBKx3ocWGpiKReJ7fI4XCmwQphzmca2d4IaR+vsq6VBqOKf+HD5CvHHpupitVYI
         GnF+12PT4mvF01rdAHJBVhSJI/vjXW037gQUaYhG8eNwcCk7VQpcVn/bW2OnOgHX9k
         inKbrUsBqC4WPOjv+p3CaqQl3mG9JdaeS5Dqe2QsPoWUA98PF+Faj87+LtpiTCtnyB
         hoIqxHT1XQv4g==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id DDD44A0063;
        Fri, 13 Nov 2020 22:37:29 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Fri, 13 Nov 2020 23:37:13 +0100
Message-Id: <088ec307eed9ab676b5d98f1fac7a36f1970439d.1605306931.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Makefile.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01a..88a83f0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -50,6 +50,7 @@ obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-- 
2.7.4

