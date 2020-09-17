Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4948A26E5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIQUAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgIQUAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:00:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C7421D7F;
        Thu, 17 Sep 2020 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600371748;
        bh=wQHjDZC0ekxu/nOFQiHuthajbxoZfgJzYmR5G57q94Y=;
        h=From:To:Cc:Subject:Date:From;
        b=rCuEO9JoJtj7mInSFfuc0oOHXSHHDdCcPbGX6IuXIq9aDPFjWCo/6gGw0k9MYIs9O
         vBgtRvMWVcWZDjKLYbzf0t7VeHqBjLyvk0k/g6DjqqLcvwSd9FZVlF8w/6RZ4U+h2c
         wjyAkBXQTljOn/Zl3PGWIMgTfNhqCXZzgM51cfJc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] dt-bindings: mailbox: fsl,mu: Add missing power-domains
Date:   Thu, 17 Sep 2020 21:42:20 +0200
Message-Id: <20200917194220.6625-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quite common property - power-domains - to fix dtbs_check warnings
like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
    mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

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

