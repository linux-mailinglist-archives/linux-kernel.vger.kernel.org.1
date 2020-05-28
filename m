Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5A1E6467
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgE1OsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:48:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56870 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgE1OsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:48:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SElEkQ065813;
        Thu, 28 May 2020 09:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590677234;
        bh=CwsQyU0kGD7NKy6DRPmze5/2bojdN83sfQuVVs2kAlw=;
        h=From:To:CC:Subject:Date;
        b=fj2mj9If70OikaVh3UgLkqEuc8IfCIg4Q1JfcGqO0Xi5Sp786sjeg7apqi3GZZDD6
         NQDrViI4Gm2x9gNUpKOvUrtNiFS59qpcQm5G7P2fC/jaf/GgLWMP2RDHX4BVO16qsk
         u6glrZNzpuKwO+DGg3HMVmCGefjXR3xnKPwHVCBY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SElEs3082844;
        Thu, 28 May 2020 09:47:14 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 09:47:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 09:47:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SElCKp108735;
        Thu, 28 May 2020 09:47:13 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] dt-bindings: sound: tlv320adcx140: Fix dt-binding-check issue
Date:   Thu, 28 May 2020 09:47:11 -0500
Message-ID: <20200528144711.18065-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dt-binding-check issue

ti,gpi-config:0:0: 4 is greater than the maximum of 1
ti,gpi-config:0:1: 5 is greater than the maximum of 1
ti,gpi-config:0:2: 6 is greater than the maximum of 1
ti,gpi-config:0:3: 7 is greater than the maximum of 1

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index e8a69b1c7ca9..306ac3d006dc 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -109,7 +109,7 @@ properties:
       - minItems: 1
         maxItems: 4
         items:
-          maximum: 1
+          maximum: 7
         default: [0, 0, 0, 0]
 
 required:
-- 
2.26.2

