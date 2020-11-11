Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4E2AF091
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgKKM1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:27:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14285 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgKKM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:27:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fabd89d0001>; Wed, 11 Nov 2020 04:27:09 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 12:27:14 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 12:27:11 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/2] ASoC: renesas,rsnd: Update audio graph references
Date:   Wed, 11 Nov 2020 17:56:53 +0530
Message-ID: <1605097613-25301-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605097629; bh=eVDvBYPuDeWHrQDKtdmXcW5F5gglOSR4F/k9ksEl7j0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=O4Qz5W7DhbuSZVZy+sTYm1ktW8XicISRp2huyTrfApNfq+i2f59tn6eKE7aEX9kvO
         gdzH+FJKLIiHSD9QHJIXKkmH2fayOkyGtsBwfhUeTo/zIwOjJhsq7NSxZlEnB8sdzU
         l1Gx+NranvrEn+hGlIewfnWjg8QTUrdwXwz+OQORS/cyHj0qr/JAtcY5753j9rKiVM
         45NsRLcSb4DgfcvQrfSAfeIOmgFODz6HetQh1AdCKrwUwJAZwY13mRlxFDvlfDQgd4
         5p7XUQbG6GZKCVFI7G7F29cOsN7mdDiJJDJcYqHUQe9nik9QLXqEDA0KOPupmR/8dm
         jaayB/XkRlgnw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since audio graph schema is refactored now update the related
references here.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 51f4dca..fc2ae22 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -112,12 +112,10 @@ properties:
         - pattern: '^clk_(a|b|c|i)$'
 
   port:
-    description: OF-Graph subnode
-    $ref: "audio-graph-card.yaml#/properties/port"
+    $ref: /schemas/sound/audio-graph.yaml#/properties/port
 
   ports:
-    description: multi OF-Graph subnode
-    $ref: "audio-graph-card.yaml#/properties/ports"
+    $ref: /schemas/graph.yaml#/properties/ports
 
 # use patternProperties to avoid naming "xxx,yyy" issue
 patternProperties:
-- 
2.7.4

