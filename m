Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC55245655
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgHPHNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 03:13:52 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35662 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgHPHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:13:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D5D2EFB03;
        Sun, 16 Aug 2020 09:13:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qke4M50PDNVY; Sun, 16 Aug 2020 09:13:45 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id DC491457CD; Sun, 16 Aug 2020 09:13:43 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: panel: rocktech,jh057n00900: Add myself as maintainer
Date:   Sun, 16 Aug 2020 09:13:43 +0200
Message-Id: <9427a9c0e6aaf9fb375f7ecee6691ba491149d52.1597561897.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597561897.git.agx@sigxcpu.org>
References: <cover.1597561897.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I maintained the txt based bindings before yaml conversion and care
about the driver.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index c97e89707342e..09b5eb7542f8a 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -8,6 +8,7 @@ title: Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
 
 maintainers:
   - Ondrej Jirman <megi@xff.cz>
+  - Guido Gŭnther <agx@sigxcpu.org>
 
 description:
   Rocktech JH057N00900 is a 720x1440 TFT LCD panel
-- 
2.26.2

