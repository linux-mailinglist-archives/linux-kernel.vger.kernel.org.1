Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2F1B876C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgDYPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:40:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68363C09B04B;
        Sat, 25 Apr 2020 08:40:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so15160516wrw.7;
        Sat, 25 Apr 2020 08:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4tS2YGMao2bjz+V8i9WcC4XNAp8kWn2u9wEJt79QoxQ=;
        b=dF1k9liH3vfLfnCQ38X3ZEdw/ILSueU4pIU8vSkFjXiNbaOk0AOr7z6fV5KjjUhI3G
         tGmJbp7EWR2o+ivKlKnxVEms60/+1PQmdCuJUJlDSpU9c2UP4038Fr4cDhjIWw4hsMjq
         gGdRD3NqmVtvGDsdb+VQF2ruU1D78lBlNTBpCpWuJkYFqR1ymt5O3ng224ZDwlvUl/Pu
         zYlP3+58ZnvuRTo8pNHKJl/F+2SR0Rn7vy7iF49aV2kXRZOgiw6H75UuYXSq8Y9tj8t0
         TWGpif2nTKtPlcbYrCUGN7cDWU3ba0bEa/CNDdiiiO+0Ir9vBH11pGwugIFjUBrtpdH+
         iyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4tS2YGMao2bjz+V8i9WcC4XNAp8kWn2u9wEJt79QoxQ=;
        b=Hz3pWXG/EWOsGZ3OgYxis9GDdxeVduJUIqIMrCQuTEHPpUeMo0xNCkTzR82dB9W+5I
         g5or+3D8d+hDBktzGfdIcNYWKnM86tdPEufsnKl7vxfvsxGUOIs5+vBgWcicPNdt6Bu/
         CP09AZaLD3+Kqt3zMuvDxBy30eVx1yo+iORulP/qhAOcyuB1WFkz6rz5u6/zuU3tn7Lf
         bmRlN4NJyjT6JDJo/lrtnL4Fk1pD9Ms0R5LRizpdlFeSk1T5ahlRkN5k8/chpodWufZh
         if2V4sOLyl1XuAPicnFlfBkbqXCRDPkmgHgp7u9SmQFPrYbl0GszIPXWzwobgCnVWaUf
         6elQ==
X-Gm-Message-State: AGi0PuZbNm3HBwOG557DeSK6FajzZKBk5P3UMzLLNEYFRYHfQ7EoOWhx
        fB5sS4rz/Ei08nOi4Q5YGq8=
X-Google-Smtp-Source: APiQypJGoGaAzG+Bg3At6JDz4UC0pKLg+Q1gEBvlSnQRnBene5RUUzfezzxPjtbNthOJhfaLe9pXvA==
X-Received: by 2002:adf:ab5c:: with SMTP id r28mr17423144wrc.384.1587829245032;
        Sat, 25 Apr 2020 08:40:45 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c190sm7759143wme.4.2020.04.25.08.40.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 08:40:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: add power-domains #cooling-cells to arm,mali-bifrost.yaml
Date:   Sat, 25 Apr 2020 17:40:37 +0200
Message-Id: <20200425154037.21083-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: gpu@ff400000:
'#cooling-cells', 'power-domains'
do not match any of the regexes: 'pinctrl-[0-9]+'

With the conversion to yaml it also filters things
in a node that are used by other drivers like
'#cooling-cells' and 'power-domains'
for Rockchip px30 gpu nodes,
so add them to 'arm,mali-bifrost.yaml'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/
arm,mali-bifrost.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 0b229a7d4..b1844b9c2 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -43,9 +43,15 @@ properties:
 
   operating-points-v2: true
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 2
 
+  "#cooling-cells":
+    const: 2
+
 required:
   - compatible
   - reg
-- 
2.11.0

