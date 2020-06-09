Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58E01F4236
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbgFIR3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:29:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35646 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgFIR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:28:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 059HShte084619;
        Tue, 9 Jun 2020 12:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591723723;
        bh=CWRXTsHonJSQ205yZjr89Tx4+V4iEmu2dhTZoOTcIHc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vL9f9Lw5qkzUGnm3JhtJCpxNC8MDgcC4LuT34OQnCZRBuyZmcW5VCBrF5qkIvkW46
         PC+BsYwKL1D2DPlfYumo3fF7Lxk4mGCEIk+vLxuKNlTkD+Q4YnbQhI0h9++sTMlcXq
         ptLGcXFzIsRD4Ny5EkEfF6jo6nJXCpByew6dR7Tc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 059HShKd039882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jun 2020 12:28:43 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 12:28:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Jun 2020 12:28:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059HSgRI130335;
        Tue, 9 Jun 2020 12:28:42 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for tas2563
Date:   Tue, 9 Jun 2020 12:28:40 -0500
Message-ID: <20200609172841.22541-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609172841.22541-1-dmurphy@ti.com>
References: <20200609172841.22541-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property called firmware-name that will be the name of the
firmware that will reside in the file system or built into the kernel.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index c6168aa32954..874f91f32d7f 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -40,6 +40,10 @@ properties:
   '#sound-dai-cells':
     const: 1
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of the firmware to be loaded to the DSP. TAS2563 only.
+
 required:
   - compatible
   - reg
-- 
2.26.2

