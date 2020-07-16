Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48663222877
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgGPQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 12:40:20 -0400
Received: from crapouillou.net ([89.234.176.41]:51112 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGPQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917544; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5iTDDHQyEb4zkyQoUbJA+tx7mC8YNxp6XZKLJIN9pw=;
        b=NtasCnXvQ1rmDDaTmUS5R67d7dJWAUpTF1mgCvX5b42nXRvUzfNnbFrzeqC+J1+hpYGHZy
        iodlLaR7GqqlTIh+4usabNNNRYLGNBiTHlDPBsvZ2eOLTxJKmDwd6YHGMWB5xuuQEUW3Xl
        D81KPuEVYh0Gg9yJykZV3Rvtat1Q3cI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 12/12] drm/ingenic: Bump driver to version 1.1
Date:   Thu, 16 Jul 2020 18:38:46 +0200
Message-Id: <20200716163846.174790-12-paul@crapouillou.net>
In-Reply-To: <20200716163846.174790-1-paul@crapouillou.net>
References: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump version to 1.1 and set date to 2020-07-16.

v3: New patch

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 443c5a30396d..304fc9923229 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -599,9 +599,9 @@ static struct drm_driver ingenic_drm_driver_data = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
 	.name			= "ingenic-drm",
 	.desc			= "DRM module for Ingenic SoCs",
-	.date			= "20190422",
+	.date			= "20200716",
 	.major			= 1,
-	.minor			= 0,
+	.minor			= 1,
 	.patchlevel		= 0,
 
 	.fops			= &ingenic_drm_fops,
-- 
2.27.0

