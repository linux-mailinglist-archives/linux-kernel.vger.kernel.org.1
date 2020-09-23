Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2759275B18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIWPDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:03:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26CE21D43;
        Wed, 23 Sep 2020 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600873426;
        bh=NmjyRuAxvtdWAj04lYTLQfo1b8Qh6W6kEE1f2h0HW+k=;
        h=From:To:Cc:Subject:Date:From;
        b=eorfEbY1xMRYpOIrEhpf6cBRc22zXxRyBHEClwTY8XLQC+zY6aCC0+BgqNDZsDcdS
         FLoJAuBSZDWEk/oU9rPdscqvuSeHiyI+skQVA3W4AFGza8+g9hZ8xhm+DvebqJjW6U
         iu3e3Tp7ztDo6LMyeKqpXGtuG84gipqaLKhiEdg4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] dt-bindings: gpu: samsung-rotator: Add missing properties
Date:   Wed, 23 Sep 2020 17:03:39 +0200
Message-Id: <20200923150339.12497-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (iommus, power-domains) to fix
dtbs_check warnings like:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rotator@12810000:
    'iommus', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Add maxItems to power domains and iommus

Changes since v1:
1. Add properties instead of using unevaluated
---
 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
index 665c6e3b31d3..62486f55177d 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -22,6 +22,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
   clocks:
     maxItems: 1
 
-- 
2.17.1

