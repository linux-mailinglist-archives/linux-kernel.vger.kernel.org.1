Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6388D20393D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 16:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgFVO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 10:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgFVO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4F0BC1BC;
        Mon, 22 Jun 2020 14:26:48 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Tai <james.tai@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: arm: realtek: Document RTD1319 and Realtek Pym Particles EVB
Date:   Sun, 21 Jun 2020 01:32:26 +0200
Message-Id: <20200620233227.31585-3-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620233227.31585-1-afaerber@suse.de>
References: <20200620233227.31585-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Tai <james.tai@realtek.com>

Define compatible strings for Realtek RTD1319 SoC and Realtek Pym Particles
EVB.

Signed-off-by: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3 -> v4:
 * Renamed compatible from pymparticle to pym-particles
 * Turned SoC comment into description
 
 v2 -> v3: Unchanged
 
 v1 -> v2:
 * Put string in alphabetical order
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index 0b388016bbcd..e36e87df3521 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -42,6 +42,12 @@ properties:
               - synology,ds418 # Synology DiskStation DS418
           - const: realtek,rtd1296
 
+      - description: RTD1319 SoC based boards
+        items:
+          - enum:
+              - realtek,pym-particles # Realtek Pym Particles EVB
+          - const: realtek,rtd1319
+
       - description: RTD1395 SoC based boards
         items:
           - enum:
-- 
2.26.2

