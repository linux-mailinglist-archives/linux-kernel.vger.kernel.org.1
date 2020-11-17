Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AC82B6FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgKQULN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKQULL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:11:11 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8829204EC;
        Tue, 17 Nov 2020 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605643871;
        bh=8HWyKvGDgZHotW6gzkecqpL2zTAPO0Z8/+rsf/h4zUw=;
        h=From:To:Subject:Date:From;
        b=e/RtBqy35hhyVrdBRG5zjsUCzTW1nBiY4eqG6lyQbUdyh2n4DIMg0iiRigOZIeS3y
         4gG1acJ1KYJPo5N7NUAOpoo/KrjzrrohFmyURwXOx9F2RKqdcT6Ju8I+sQxaKlajGp
         CSAHxbrHtpj01+c+9rM366pRNyiHKKgjRiI+0Fr8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: samsung: document SMDK2416 board binding
Date:   Tue, 17 Nov 2020 21:11:03 +0100
Message-Id: <20201117201106.128813-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the SMDK2416 board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 272508010b02..332b07b7f4fb 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -14,6 +14,12 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - description: S3C2416 based boards
+        items:
+          - enum:
+              - samsung,smdk2416                # Samsung SMDK2416
+          - const: samsung,s3c2416
+
       - description: S5PV210 based boards
         items:
           - enum:
-- 
2.25.1

