Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFC125C936
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgICTOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 15:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgICTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:14:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D41214D8;
        Thu,  3 Sep 2020 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160490;
        bh=lXKQONHU131LLANPalwdk6k0iSEqtYKE3hqj1CGpK0g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Xk18qlWMCPHtVfcaNrNYGbagNOgMhFcdme81aScQ+F99M/aonwWllr0lXFFm9NHsK
         b5P5vWxZVUomJmiKLTGrR8qlz/ylkuxg1wK8ygWJjsG3xgu8UH3OPrAM8ohVXmfOZ7
         qIfUO2NA9y6TXj9fdfy7JrC1PJ5aC4oBRBDncAxE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: gpu: arm,mali-utgard: Correct Maxime's email
Date:   Thu,  3 Sep 2020 21:14:35 +0200
Message-Id: <20200903191438.12781-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903191438.12781-1-krzk@kernel.org>
References: <20200903191438.12781-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the address of Maxime Ripard as one in @free-electrons.com does
not work.

Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Maxime Ripard <mripard@kernel.org>

---

Changes since v1:
1. Add Ack
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 30d421e6ba38..eceaa176bd57 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -8,7 +8,7 @@ title: ARM Mali Utgard GPU
 
 maintainers:
   - Rob Herring <robh@kernel.org>
-  - Maxime Ripard <maxime.ripard@free-electrons.com>
+  - Maxime Ripard <mripard@kernel.org>
   - Heiko Stuebner <heiko@sntech.de>
 
 properties:
-- 
2.17.1

