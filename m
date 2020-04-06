Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67D719F3CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgDFKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 06:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDFKqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:46:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5F1206F8;
        Mon,  6 Apr 2020 10:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586169972;
        bh=D6gBRmYTc+zgGLpuMuzRFYrYH7t/9Cv2c9BLVW0I8ow=;
        h=From:To:Cc:Subject:Date:From;
        b=Lky6uMxo8GOtvEwgYMihpkD9LH/hRP9Cu73Mr4//sukdV5kERMpAUiMBLp527kAr1
         SCVVZXY3OAMZiLKAzABBf6qHURcCRwtP+Hp/rUPfvKA85LbbzFQsS284bcJBGxtoqQ
         5K1K9Q27SLoFXuR7eiGBrkFZpmAdG2ZLuXfFahMg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH] dt-bindings: memory-controllers: exynos-srom: Remove unneeded type for reg-io-width
Date:   Mon,  6 Apr 2020 12:45:54 +0200
Message-Id: <20200406104554.29773-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'reg-io-width' property is an enum so there is no need to specify its
type.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/memory-controllers/exynos-srom.yaml   | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
index cdfe3f7f0ea9..1250087b4ee6 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
@@ -51,9 +51,7 @@ patternProperties:
         maxItems: 1
 
       reg-io-width:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [1, 2]
+        enum: [1, 2]
         description:
           Data width in bytes (1 or 2). If omitted, default of 1 is used.
 
-- 
2.17.1

