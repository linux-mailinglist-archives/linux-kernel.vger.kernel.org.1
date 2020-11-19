Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678192B8E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgKSJUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:20:04 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45672 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726732AbgKSJT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:19:59 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 806B540338;
        Thu, 19 Nov 2020 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605777599; bh=edcXyPrdp8R9RXRFViAqqPMvR+va6Qr0GQL20fU0Ss0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=E4rg76oZS2mxOcaeqhceOZYzY47PSjyzmo42j2WmrlxM4VBcQ+CfszmHaI9s08az3
         pjzoNPBEDpsg+aZKCU8EqyvxpehhSvd572OuoiAwCseMpIzsuea37vV23Pp9gKvXl4
         fxMioEZoLWzHSmStruh7xfUWyvdk7D8cMfhmg8fu1rJkpOCh8/LaBdjb2u1sdv7K0J
         Lw4VjpjHhdAK/TMLhDsqXT5qlWEokiWp5o4ELHtVmv7R6Rkt/PMdkqTbvEs3g8njeR
         KXvwNxE4DMEYmOsRcHtqDOcaf4lhKSyZ7C6n1t9UlYNhKvJR9vKVZfM3OKZu2httYS
         ax8LCgcvnRjJQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 41F5CA005E;
        Thu, 19 Nov 2020 09:19:58 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Thu, 19 Nov 2020 10:19:39 +0100
Message-Id: <7e3629eefe00add85cf6cd9587c9dd893ae4f247.1605777306.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
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
index 2521359..26a27d2 100644
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

