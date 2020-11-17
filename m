Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5532B6FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbgKQULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:11:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731550AbgKQULN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:11:13 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90CCE20707;
        Tue, 17 Nov 2020 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605643872;
        bh=kd498cQy0aWOM6FRzhtjAo8fKl+E/C/qy8XzkjCs9xI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FulGZF9aN8t429qk9TWwMRFXPSPXS4LzX33w8wwi7b6AwwUpKiuxfdCfV7YKXM6uC
         MrRT61bw15neh0juDLuKFKXC/4pO3wXLmj8y30wtFNSDBon9bo+YkxEMpIOPlDmvEn
         UiGG1Z/OmB51qCyVXf2n0PpY9g1ZYjpCz4W3FNKo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: arm: samsung: document S3C6410-based boards binding
Date:   Tue, 17 Nov 2020 21:11:04 +0100
Message-Id: <20201117201106.128813-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117201106.128813-1-krzk@kernel.org>
References: <20201117201106.128813-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the FriendlyARM Mini6410 and Samsung SMDK6410 boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 332b07b7f4fb..eaec2a6c08a9 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -20,6 +20,13 @@ properties:
               - samsung,smdk2416                # Samsung SMDK2416
           - const: samsung,s3c2416
 
+      - description: S3C6410 based boards
+        items:
+          - enum:
+              - friendlyarm,mini6410            # FriendlyARM Mini6410
+              - samsung,smdk6410                # Samsung SMDK6410
+          - const: samsung,s3c6410
+
       - description: S5PV210 based boards
         items:
           - enum:
-- 
2.25.1

