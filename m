Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E486929F4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJ2TN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:13:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45708 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgJ2TN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:13:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AACEBC00AB;
        Thu, 29 Oct 2020 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603998835; bh=0DWq5jcTtdHUwk0lbGhb4NNysmCj/e/PGeWS1JSpIqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HdROXA1p9BEEfrF0qcCSOF/t+RyhdTHml8ydgvhu+5EFDguxes3DDaTW+yKHAABRy
         Hsuy4AGn3DH6LJ+Eaj0pJmmJA6FVc4bDaR5BSeQ+76xabIETkU+aINIc5mO3ihb8jm
         MwXacA9t6LCScUfxHtbSGneLu7xOB99sU5tF+1+5wYUsKEPLe4xFElfyYWGix2/Ayq
         VQF4ETXu49dWXnLY55ZxEGf1BzxaeNRPsrecfueJubtL5sk8PFtLYFMKZeBFZUSz5H
         ddHxZBrLp9ThBfSqWC+VuFUk0m7H8w0b2rJWiS1l2uxKBpPmXFFPr+moHRRpxo4JZd
         rzdKfiHOFn9vA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6C7B9A01F0;
        Thu, 29 Oct 2020 19:13:54 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Thu, 29 Oct 2020 20:13:37 +0100
Message-Id: <6c5a577be47a69883aee7e52fcd7ef2364f360be.1603998630.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
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

