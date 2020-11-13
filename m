Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F902B289D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKMWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:37:38 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50062 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgKMWhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:37:33 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D2737C0C1C;
        Fri, 13 Nov 2020 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605307052; bh=Bc9OkcSUqEez5HOcrmqb+oDl9o6/bmo8serqw795crA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=H/NBLlux7NRZuAC1zS8U9n7y8HG+GALcpYPnjYOsBP62HcmXL2cpaNzPMY7nNdI0N
         Pd4fjmAx9TZ2S14mlZCxyXK1gy9406xmGEh9rQHBvDROAz40gnhMxR++RZ0hZV7/qd
         7kIqesvMwRE9UAhjHSLZCxA0EIygjp/uYbk3bH8MkvYnRQpRhQQOSzVHk+o1nP67IP
         gexPlYmaGrAYD3PQ7OfFjSbWDtbPAmCjLdS0d6H8NvuoZrpqJ9XatwipLq3nC1RDd2
         gKKX8qzG04MdXtupMpiCj1YU2Zzeb5W3c4kwgHDzhr5RF/zpZahC7T4RoZZnE/3OE0
         K16Euey+5gqWQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 70A74A005E;
        Fri, 13 Nov 2020 22:37:30 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] misc: Add Synopsys DesignWare xData IP driver to Kconfig
Date:   Fri, 13 Nov 2020 23:37:14 +0100
Message-Id: <ac28185714e8e86de5f380e3f8f59e4a3afec061.1605306931.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
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
index ce136d6..edb1363 100644
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

