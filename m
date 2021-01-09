Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D42EFFD9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAINa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:30:56 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:54805 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAINar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:30:47 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 19D7A1F569;
        Sat,  9 Jan 2021 14:29:45 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, sumit.semwal@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 4/7] dt-bindings: regulator: qcom-labibb: Document soft start properties
Date:   Sat,  9 Jan 2021 14:29:18 +0100
Message-Id: <20210109132921.140932-5-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109132921.140932-1-angelogioacchino.delregno@somainline.org>
References: <20210109132921.140932-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document properties to configure soft start and discharge resistor
for LAB and IBB respectively.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/regulator/qcom-labibb-regulator.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
index 53853ec20fe2..1cdaff66fdb9 100644
--- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
@@ -22,6 +22,10 @@ properties:
     type: object
 
     properties:
+      qcom,soft-start-us:
+        description: Regulator soft start time in microseconds.
+        enum: [200, 400, 600, 800]
+        default: 200
 
       interrupts:
         maxItems: 1
@@ -35,6 +39,10 @@ properties:
     type: object
 
     properties:
+      qcom,discharge-resistor-kohms:
+        description: Discharge resistor value in KiloOhms.
+        enum: [300, 64, 32, 16]
+        default: 300
 
       interrupts:
         maxItems: 1
-- 
2.29.2

