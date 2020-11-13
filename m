Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A52B289F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKMWht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:37:49 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56112 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgKMWhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:37:34 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2C384047F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605307053; bh=IUbpBnemFjcPLXeZcS1UdiQeqGMTspGXKuMWboW3oZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=UDs+bUMmC0080y5kSMVrn03qUFXUwlIV0ccP+ylE/eVQGScwKAYG3ZZooUdC0Ojls
         QnkhIQt3olcqqfGcE56Q777i6v1/nMa4j+j4Aizv6F2OolxWbyIGHAWdTIOFgK63MP
         TgI21IgCX2ajrx40wc9a3Xe+h/wgypseE4RBC+zyysi9+WBA+NdV6Yb1hp5VbWdE6X
         yACO+bYS6bH8wwrGcjrW0NDiVmMm2lmObhjNdicl9EKPrDfrPsWmHQ3EbCp1mXFjqK
         +u0tFCU4yPvitluUmei8HbCry0yBYWx9Ren2ojVmB9pca/W5NPDHhy7BZbaTCE0dI2
         bd8toLUdS10YA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B03FAA0062;
        Fri, 13 Nov 2020 22:37:31 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Fri, 13 Nov 2020 23:37:16 +0100
Message-Id: <5760fcec45ae5ed63b80546eb060754fc4d137da.1605306931.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
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
index 8671573..8856f6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4983,6 +4983,13 @@ S:	Maintained
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

