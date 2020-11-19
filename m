Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574D72B8E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKSJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:20:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60928 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgKSJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:20:02 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EDC55C00CC;
        Thu, 19 Nov 2020 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605777601; bh=yQXTviJknZ5FlGaxSYCjZ/hNgtq2OqKm0e8kQb983OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JlMFpcFORIWLwV2T9OXucHv60OODN0saua2i/MZEgoF6Wlm6GGeNRAhPuj6589KJH
         7dw2L/YKoMV1oEYAKKL9YLWY6wVy77TN2VXy1aAP885JXhCuTl+Q+I9gnYW1uh7NVH
         gBhM596GfqZocnq4mhDt6uFwgIPN8rHjRiQJrlLRRzKJ4o90JaMikZwO8YtwtrGXKG
         won1K7gNXgdZDkYFss+lkmDFWcYIxyHlSmWGsA7jlfp7gGkBwwKxfFyfP+61DyWX02
         vsdR2nqN9AeqG2ZyjGTWuIksiKsYOdsXvtdeSX8mQXAT3ESA7M2UzuZEAiKtzeDYIg
         J7B2jwuIy55hw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 10E04A005D;
        Thu, 19 Nov 2020 09:19:59 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] misc: Add Synopsys DesignWare xData IP driver to Kconfig
Date:   Thu, 19 Nov 2020 10:19:40 +0100
Message-Id: <09cda3d8d4c67926dd1247f01d5b456ee3e8bc1e.1605777306.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Kconfig.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index d5ce808..3d73f5c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,6 +423,17 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config DW_XDATA_PCIE
+	depends on PCI
+	tristate "Synopsys DesignWare xData PCIe driver"
+	default	n
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

