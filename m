Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1E2B6FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKQUSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgKQUR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:17:58 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D1A221F1;
        Tue, 17 Nov 2020 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605644277;
        bh=6obH9wgf0CI4GdXTdHi0svSf0RAJjqk23/EE2KzNxRo=;
        h=From:To:Subject:Date:From;
        b=pz6tNKtCuaZlZRO1g4rit7dMv1XdfU3f4RZFdiX775zdaPfkuWw9k7Qfx/6Z8bOC1
         JNpDO1qi5sMOhXEixSlvNe5R6rYzPzj6Am1xwXCsRxeqS/4Wp5/UoCZxf8fVb1/YSW
         UOMsIUBDDWxQiGK7g39T9wNUqMWqmJyxfMn8RpPg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tony Prisk <linux@prisktech.co.nz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: vt8500: remove redundant white-spaces
Date:   Tue, 17 Nov 2020 21:17:52 +0100
Message-Id: <20201117201752.129766-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant white-spaces, no functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/vt8500.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/vt8500.yaml b/Documentation/devicetree/bindings/arm/vt8500.yaml
index 29ff399551ca..7b762bfc11e7 100644
--- a/Documentation/devicetree/bindings/arm/vt8500.yaml
+++ b/Documentation/devicetree/bindings/arm/vt8500.yaml
@@ -21,6 +21,5 @@ properties:
           - wm,wm8650
           - wm,wm8750
           - wm,wm8850
-          
-additionalProperties: true
 
+additionalProperties: true
-- 
2.25.1

