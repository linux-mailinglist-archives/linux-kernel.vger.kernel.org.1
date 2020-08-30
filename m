Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D10256CE0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgH3Iku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 04:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgH3Ik1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:40:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00ED42098B;
        Sun, 30 Aug 2020 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598776827;
        bh=iVnbx/8zJDJAHpnSzwHRy7B6EAjnTdNP5Hu69AOZWHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=hsSQA+S0i0BwQ0zTP3zkgxz++NxVOEC6kbBnHAKAxR9Y/w5jlfqv5rhTGm25Tf7qD
         LbkjwBfXt5ypCPl/+0iMSvuwj5m8JktnELWv8dcB7Ol/rU8pKbDiWmvEshw2L7rqSA
         JH7ddFYPyRluZ+QBYZvD9oYFKGdUwFpJKT8rD2NA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: gpu: arm,mali-utgard: Use unevaluatedProperties
Date:   Sun, 30 Aug 2020 10:40:21 +0200
Message-Id: <20200830084021.18572-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional properties or nodes actually might appear (e.g. operating
points table) so use unevaluatedProperties to fix dtbs_check warnings
like:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: gpu@13000000:
    'opp_table' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 6226d31ec4b7..021690391bea 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -119,7 +119,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
   - if:
-- 
2.17.1

