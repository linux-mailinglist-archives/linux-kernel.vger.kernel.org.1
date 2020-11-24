Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026312C2E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390848AbgKXR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:26:54 -0500
Received: from softboy.mntmn.com ([91.250.115.15]:34578 "EHLO
        softboy.mntmn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390713AbgKXR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:26:53 -0500
From:   "Lukas F. Hartmann" <lukas@mntre.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com 36201720F46
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntre.com;
        s=mntremail; t=1606238811;
        bh=8Jj0AmtAGplo7ayDkJLt5zNooDVeNlxY0dyEat7B+hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJybrgiQY6dVhmKoAHKjQNVaAUk5xQcXofGN8wo76PACdPU5MXCIY7sgFhNuEkkTl
         JWqi8XUvwMh9cQvhlyKXgBqPdY6jzRPXxHtddHAxxsgnbeJswm3lghMnotx/4oIZCM
         72D5fFKCaMuaEnXi6zAyr1yNmIGMyhq53RbgerLlkQMtDgX3ZHJPTK7iUjTpEXubU6
         BBmcW1iFG2DaO35/wu1fCUpq8csQA6H0d1WzjsUC6cCxJC2AFPIoxBOP2+JhO/gFBI
         eMxhgA6NDWKJqnTkhbEV6DGnseFLwvKsNvNVZNx3vXfjprq+N2Ym1oZF15MxjiSC+A
         XbtaM0OKyzJ6w==
To:     lukas@mntre.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: display/panel: add Innolux N125HCE-GN1
Date:   Tue, 24 Nov 2020 18:26:06 +0100
Message-Id: <20201124172604.981746-2-lukas@mntre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124172604.981746-1-lukas@mntre.com>
References: <20201124172604.981746-1-lukas@mntre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Innolux N125HCE-GN1 display is used in the MNT Reform 2.0 laptop,
attached via eDP to a SN65DSI86 MIPI-DSI to eDP bridge. This patch
contains the DT binding for "innolux,n125hce-gn1".

Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index edb53ab0d..03b3e0b9d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -160,6 +160,8 @@ properties:
         # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
       - innolux,n116bge
         # InnoLux 15.6" WXGA TFT LCD panel
+      - innolux,n125hce-gn1
+        # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
-- 
2.28.0

