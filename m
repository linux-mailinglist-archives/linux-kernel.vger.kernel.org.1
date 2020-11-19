Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4576D2B8EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKSJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:20:12 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45676 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgKSJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:20:02 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F369B402EA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605777602; bh=hyDFXASEhfxST1H7kFfa4QWjSoBbi7h4O++nhFdRe40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OsAzHtiRuNZFlq1une2guDIAq3jRMxlos4dgAJye4E6VQRHZagYNtlqGByMczzIXC
         vHbaF7gmtKrrKAOnbzT9jbGf++lByM6Z7fRy4CxXwq6d6uRw4q1T4PU2g0c+AjLeaQ
         S6Q6S+jpz2Po2QrtE2JnrCpO/eUDsX1MUZIbpHgLq9SGg1/GGvZdmFI7Ihx7X0v3SG
         r+IVEKwfJpzpfdOrDm5f8tZSbJujgis43EdriLsR8SHWEg3jnPHsqCu6jKUDshaiYU
         +ETzGktnwS7PqXVvJWYDOghUfWRiz2HFyB1Cku2gxdeKwVn5KDG4S9j87A5hAUuREP
         dT7UPrj+syGUw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B792EA0062;
        Thu, 19 Nov 2020 09:20:00 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Thu, 19 Nov 2020 10:19:42 +0100
Message-Id: <7bcb8e6cd57b54179beadde98ecc959c0428b7c2.1605777306.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Synopsys xData IP driver maintainer.

This driver aims to support Synopsys xData IP and is normally distributed
along with Synopsys PCIe EndPoint IP as a PCIe traffic generator (depends
of the use and licensing agreement).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..85713f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5018,6 +5018,13 @@ S:	Maintained
 F:	drivers/dma/dw-edma/
 F:	include/linux/dma/edma.h
 
+DESIGNWARE XDATA IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/misc-devices/dw-xdata-pcie.rst
+F:	drivers/misc/dw-xdata-pcie.c
+
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
-- 
2.7.4

