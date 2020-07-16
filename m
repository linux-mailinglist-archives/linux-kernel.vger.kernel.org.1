Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D1222862
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgGPQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 12:39:18 -0400
Received: from crapouillou.net ([89.234.176.41]:50204 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917536; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5sqYsXXxr5NrmJ4crCbojNwhQtRT7BbgfQatl4FgMY=;
        b=wf97L92uRROnVzQDLZBhNUccU6SzS1medwFlSC+nHiGzDQq0ojxvTFxep8khGa7VzrNNuo
        a63LHulL8Zv35Yew7SRyQ4Vin3whzhoJMXR2gDBxGcsS5UBotbAuKDcCdn1dW2UzNVDCOI
        UtG9LGtwx4zbf9oDHz78kLFydb7fymQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 04/12] drm/ingenic: Rename ingenic-drm.c to ingenic-drm-drv.c
Date:   Thu, 16 Jul 2020 18:38:38 +0200
Message-Id: <20200716163846.174790-4-paul@crapouillou.net>
In-Reply-To: <20200716163846.174790-1-paul@crapouillou.net>
References: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Full rename without any modification, except to the Makefile.

Renaming ingenic-drm.c to ingenic-drm-drv.c allow to decouple the module
name from the source file name in the Makefile. This will be useful
later when more source files are added.

v2: New patch
v3: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/ingenic/Makefile                             | 1 +
 drivers/gpu/drm/ingenic/{ingenic-drm.c => ingenic-drm-drv.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/gpu/drm/ingenic/{ingenic-drm.c => ingenic-drm-drv.c} (100%)

diff --git a/drivers/gpu/drm/ingenic/Makefile b/drivers/gpu/drm/ingenic/Makefile
index 11cac42ce0bb..9875628dd8bc 100644
--- a/drivers/gpu/drm/ingenic/Makefile
+++ b/drivers/gpu/drm/ingenic/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_DRM_INGENIC) += ingenic-drm.o
+ingenic-drm-y += ingenic-drm-drv.o
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
similarity index 100%
rename from drivers/gpu/drm/ingenic/ingenic-drm.c
rename to drivers/gpu/drm/ingenic/ingenic-drm-drv.c
-- 
2.27.0

