Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059192B8849
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgKRXS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:18:59 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40902 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgKRXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:18:59 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D9B76C00BF;
        Wed, 18 Nov 2020 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605741538; bh=l8jYpxVPZqbhmqWqAoCVIcy60I2O10KGualyqBU1XR0=;
        h=From:To:Cc:Subject:Date:From;
        b=jvSHCY26OydhI9R8LdOudbMk1Ly2wrdyg5YNRfpH6lGKKsC6hJ/myNwLJ/W+0zi7H
         lh34YF4FsqXPzYvCrE55KQiSrdKR/TWSxz8Jznuyk72JRTpEPNVfgo4AtO+UmMzZWg
         K0Z3s/kggIMbm65JNAZX5RxQ4lp4+Vv7rXFl7zSBU1p+CuJqNnIwcbLfsuk/a+1FKr
         galGumOBMBg6pSGSbwNbCn3hi4wFZfJzYe73GsKnXqRAfoNh9eQR0FkYGaTGW/i7q0
         FksMRSb9Ro/AFhTnUJHuKp8V2e7f1THiaBrLfVJMKUOlAtEL+axZOsqfLaIkeOWXt+
         46gZMtwh3x7fA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8EA3BA005C;
        Wed, 18 Nov 2020 23:18:56 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix typo on the DesignWare IP reset bindings documentation
Date:   Thu, 19 Nov 2020 00:18:39 +0100
Message-Id: <89719d8d40048e9b7baa0cd984b5bb108d056de4.1605741519.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a loose "i" character is present on the current
documentation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/devicetree/bindings/reset/snps,dw-reset.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
index f94f911..0c241d4 100644
--- a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
+++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
@@ -23,7 +23,7 @@ example:
 		#reset-cells = <1>;
 	};
 
-	dw_rst_2: reset-controller@1000 {i
+	dw_rst_2: reset-controller@1000 {
 		compatible = "snps,dw-low-reset";
 		reg = <0x1000 0x8>;
 		#reset-cells = <1>;
-- 
2.7.4

