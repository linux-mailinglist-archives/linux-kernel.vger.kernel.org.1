Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA61256CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgH3Iv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 04:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgH3Iv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:51:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A5D2076D;
        Sun, 30 Aug 2020 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598777488;
        bh=cJJKKn0KWYEeosBcpJwjk0KxB7eK2kfIzMkL82RSWMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=VQuoEWdiIIlqFvN/BuV2IrV52KJnkbm8fiKdnll7PJIOJEed4Wt6T9vweO+lJUcLv
         VNVdxrs2c/7LPebUN965slduXMMQ1Yjgiega16cIsnQSpMfC7a14r6gy/Pnjb4Quiz
         MTEacy6neMXjoXfZTbjaTvHYdqyEjB5bOBzHrZGk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: gpu: arm,mali-utgard: Correct Maxime's email
Date:   Sun, 30 Aug 2020 10:51:22 +0200
Message-Id: <20200830085122.20826-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the address of Maxime Ripard as one in @free-electrons.com does
not work.

Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 021690391bea..869ef648644e 100644
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

