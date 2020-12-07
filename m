Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962392D09D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgLGEtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 23:49:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9388 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgLGEtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:49:49 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cq9n02f5mz79Sy;
        Mon,  7 Dec 2020 12:48:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 12:48:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] dt-bindings: display: eliminate yamllint warnings
Date:   Mon, 7 Dec 2020 12:48:30 +0800
Message-ID: <20201207044830.1551-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201207044830.1551-1-thunder.leizhen@huawei.com>
References: <20201207044830.1551-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following yamllint warnings:
./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
:52:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
:42:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
:45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)

./Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
:21:6: [warning] wrong indentation: expected 6 but found 5 (indentation)

./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
:25:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../devicetree/bindings/display/bridge/analogix,anx7625.yaml          | 4 ++--
 .../devicetree/bindings/display/bridge/intel,keembay-dsi.yaml         | 4 ++--
 Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml   | 4 ++--
 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 60585a4fc22bc9f..9392b5502a3293c 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -49,8 +49,8 @@ properties:
           Video port for panel or connector.
 
     required:
-        - port@0
-        - port@1
+      - port@0
+      - port@1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
index ab5be26252240ea..35c9dfd866501a0 100644
--- a/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
@@ -39,10 +39,10 @@ properties:
 
     properties:
       '#address-cells':
-       const: 1
+        const: 1
 
       '#size-cells':
-       const: 0
+        const: 0
 
       port@0:
         type: object
diff --git a/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml b/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
index 40caa61188098c2..a222b52d8b8ff6b 100644
--- a/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
+++ b/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
@@ -18,8 +18,8 @@ description: |
 properties:
   compatible:
     items:
-     - const: intel,keembay-msscam
-     - const: syscon
+      - const: intel,keembay-msscam
+      - const: syscon
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index d2170de6b72302f..2f5df1d235aea8a 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -22,7 +22,7 @@ properties:
   compatible:
     items:
       - enum:
-         - tianma,fhd-video
+          - tianma,fhd-video
       - const: novatek,nt36672a
     description: This indicates the panel manufacturer of the panel that is
       in turn using the NT36672A panel driver. This compatible string
-- 
1.8.3


