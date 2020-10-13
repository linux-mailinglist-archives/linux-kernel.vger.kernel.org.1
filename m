Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4017628CBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgJMKdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:33:06 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45966 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgJMKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:32:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1FA8DFB05;
        Tue, 13 Oct 2020 12:32:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HVnsScNImAzv; Tue, 13 Oct 2020 12:32:50 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8CEE6402EC; Tue, 13 Oct 2020 12:32:48 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/panel: mantix: Don't dereference NULL mode
Date:   Tue, 13 Oct 2020 12:32:46 +0200
Message-Id: <659158549f3c6cc1c71ceed0943e760e861c1206.1602584953.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602584953.git.agx@sigxcpu.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't dereference mode which was just NULL checked.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 3482e28e30fc..4a7fbf64bb7a 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -204,7 +204,7 @@ static int mantix_get_modes(struct drm_panel *panel,
 	if (!mode) {
 		dev_err(ctx->dev, "Failed to add mode %ux%u@%u\n",
 			default_mode.hdisplay, default_mode.vdisplay,
-			drm_mode_vrefresh(mode));
+			drm_mode_vrefresh(&default_mode));
 		return -ENOMEM;
 	}
 
-- 
2.28.0

