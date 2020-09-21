Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3B272F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgIUQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:56:10 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39498 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbgIUQz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:55:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1781DFB04;
        Mon, 21 Sep 2020 18:55:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wd294yyf5vT4; Mon, 21 Sep 2020 18:55:56 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0A872457CE; Mon, 21 Sep 2020 18:55:52 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/3] drm/panel: mantix: Don't dereference NULL mode
Date:   Mon, 21 Sep 2020 18:55:50 +0200
Message-Id: <c80b4cfd4da5cf27cc6e0d213ddabf0aebd054bb.1600707235.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600707235.git.agx@sigxcpu.org>
References: <cover.1600707235.git.agx@sigxcpu.org>
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
2.26.2

