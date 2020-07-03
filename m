Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485121398F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 07:47:30 -0400
Received: from vps.xff.cz ([195.181.215.36]:41248 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGCLrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593776843; bh=iqz2SX82vQtetbFnEof7dGer5tzzE9ATX0yvgwgpk/8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oU2ClTHlglcyU0j9mnqoG61AxuvwV+hEBrZf17i4C585S4K6RsH+soW4phZpuqwcr
         g0U7u/DGfuukhjmXS+XWu+kCuV5+QTh6gDfeXJ01MY5q8TxylKE1bc4geaRXE8mO3e
         CnJEIhcNm+dsDN4IVza9q5+HxsPgMhzo7Wd0MUsI=
From:   Ondrej Jirman <megous@megous.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-binding: display: Allow a single port node on rocktech,jh057n00900
Date:   Fri,  3 Jul 2020 13:47:17 +0200
Message-Id: <20200703114717.2140832-3-megous@megous.com>
In-Reply-To: <20200703114717.2140832-1-megous@megous.com>
References: <20200703114717.2140832-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display has one port. Allow it in the binding.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index a6985cd947fb..d5733ef30954 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -24,6 +24,7 @@ properties:
         # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
       - xingbangda,xbd599
 
+  port: true
   reg:
     maxItems: 1
     description: DSI virtual channel
-- 
2.27.0

