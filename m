Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4325D25B08E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIBQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:00:33 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2042072A;
        Wed,  2 Sep 2020 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599062433;
        bh=fKssNxEpGlEeBwAJ6aSQrLneqbFsntwOpiEKOEP4OVo=;
        h=From:To:Subject:Date:From;
        b=yU3KFPShOWBRqkV7u6Ory9Vzxd+pQ0OJ9CDFFBBx2tI2VCw6Ki/c30eGtFaTdZStz
         IEKRjzyatUsz87JCnWfZET2ogEppZE+1VnV5b/BIx4+QlZz68SIBUO/9vjEUVrQeN0
         vgpCsNDQwWg7r8Un7KXMlZ5KWvdR9wNpLFTwLRl0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: aries-wm8994: Match compatibles with enum
Date:   Wed,  2 Sep 2020 18:00:25 +0200
Message-Id: <20200902160025.20922-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common pattern for enumerating compatibles is enum, not oneOf.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/sound/samsung,aries-wm8994.yaml          | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
index 902a0b66628e..1c6947294825 100644
--- a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -11,12 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: samsung,aries-wm8994
-        description: With FM radio and modem master
-
-      - const: samsung,fascinate4g-wm8994
-        description: Without FM radio and modem slave
+    enum:
+      # With FM radio and modem master
+      - samsung,aries-wm8994
+      # Without FM radio and modem slave
+      - samsung,fascinate4g-wm8994
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.17.1

