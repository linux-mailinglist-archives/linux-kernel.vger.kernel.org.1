Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B829F4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgJ2TON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:14:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53242 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgJ2TN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:13:57 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27B8A4016B;
        Thu, 29 Oct 2020 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603998837; bh=0rVwuyqqmx8FWyOPWwDqbXhtlRqHIWAhYO56UXLbc8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=U4ffMrT07UvrXxFs3CAEdwmiL2lChKCNm1H4CKNg467L9Vgewq1G1ObUqoJYv+lcP
         a5j4JcpXS+o+HZe3x7ArXlzr946xVUcB0pGdEoMS6nY8wV3tl7MvgFLL8+I2naqDUw
         kH3MNJ6KOrCRFmCWhA3UhzpjRuJJ1KY2NqBWKNChcDGaTwZQmx/9sNAh/KSxnK8q64
         owC6piEN6rTpsq0BvNvJOLEmZT+x1i3gMvGFHR9a9S05LcvxN1E9LGqHc9C1d1T28B
         PHcKmOlEEKvuxB5plW0CgO2YIVc9UgGSDtnqgFRmvgtSiRxggczFVuMlEZb3BmOAUt
         sHkRmQVoiMTMA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id EB885A01F1;
        Thu, 29 Oct 2020 19:13:55 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] misc: Add Synopsys DesignWare xData IP driver to Kconfig
Date:   Thu, 29 Oct 2020 20:13:38 +0100
Message-Id: <7c21c5b65e8bcf8272a5ba1e72f473eff635e13e.1603998630.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Kconfig.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ce136d6..851b460 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,6 +423,16 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config DW_XDATA_PCIE
+	depends on PCI
+	tristate "Synopsys DesignWare xData PCIe driver"
+	help
+	  This driver allows controlling Synopsys DesignWare PCIe traffic
+	  generator IP also known as xData, present in Synopsys Designware
+	  PCIe Endpoint prototype.
+
+	  If unsure, say N.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
-- 
2.7.4

