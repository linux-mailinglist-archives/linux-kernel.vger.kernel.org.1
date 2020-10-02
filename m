Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0B2817AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgJBQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388111AbgJBQSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:18:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DE82085B;
        Fri,  2 Oct 2020 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601655523;
        bh=XtQcpi2VsVyiIP8B3XIaQmsvW+R88K4mS6OhwtQt/S8=;
        h=From:To:Cc:Subject:Date:From;
        b=WutDyYK8dYKN87q583WzQFFzY1G7oR10QzePiIqLkHFIFub359xKJzjlA8A+AXacs
         pfMFCqdfCyBjSymg5Kc7eHj+twVJGA7HFnm4nqMWFABPD2WHideySK3QkzDMoG7fpq
         R8Cfy6ZD3ip3aFioVrFR6+E4Ns+RpfBvzOGC+YTE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND v3] dt-bindings: mailbox: fsl,mu: Add missing power-domains
Date:   Fri,  2 Oct 2020 18:18:37 +0200
Message-Id: <20201002161837.5784-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quite common property - power-domains - to fix dtbs_check warnings
like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
    mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

---

Hi Rob,

You previously reviewed this patch. Can you pick it up to your tree?

Best regards,
Krzysztof

Changes since v2:
1. Set maxItems to power domains to 1

Changes since v1:
1. Add missing properties instead of unevaluatedProperties
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 7ed096360be2..15cef82cd356 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -72,6 +72,9 @@ properties:
     description: boolean, if present, means it is for side B MU.
     type: boolean
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.17.1

