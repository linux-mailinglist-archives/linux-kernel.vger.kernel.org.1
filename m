Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144DF2329A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgG3Bqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 21:46:43 -0400
Received: from crapouillou.net ([89.234.176.41]:45746 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3Bqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596073594; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xEUuTkj78lEWK4O56Tw/kmALvuCP1DLvcLRgltdNFE=;
        b=Btel6k6ieEyqOpWRjY9NIiHWwMHX5N+ApkW3CzMYSREZaC273j49OqXEht66guiZaEmcsV
        JENPSd0apS1KAabRFG2askFx1BD9zuJRa4rVS7yzrkSdLMT+VKInizC2FRHYdCq8OtSbpo
        SwFS8RZD2fg8Q/gzmebNSQ7W2jHEnYA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] drm/ingenic: ipu: Only restart manually on older SoCs
Date:   Thu, 30 Jul 2020 03:46:24 +0200
Message-Id: <20200730014626.83895-2-paul@crapouillou.net>
In-Reply-To: <20200730014626.83895-1-paul@crapouillou.net>
References: <20200730014626.83895-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On older SoCs, it is necessary to restart manually the IPU when a frame
is done processing. Doing so on newer SoCs (JZ4760/70) kinds of work
too, until the input or output resolutions or the framerate are too
high.

Make it work properly on newer SoCs by letting the LCD controller
trigger the IPU frame restart signal.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-ipu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 7a0a8bd865d3..7eae56fa92ea 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -35,6 +35,7 @@ struct soc_info {
 	const u32 *formats;
 	size_t num_formats;
 	bool has_bicubic;
+	bool manual_restart;
 
 	void (*set_coefs)(struct ingenic_ipu *ipu, unsigned int reg,
 			  unsigned int sharpness, bool downscale,
@@ -645,7 +646,8 @@ static irqreturn_t ingenic_ipu_irq_handler(int irq, void *arg)
 	unsigned int dummy;
 
 	/* dummy read allows CPU to reconfigure IPU */
-	regmap_read(ipu->map, JZ_REG_IPU_STATUS, &dummy);
+	if (ipu->soc_info->manual_restart)
+		regmap_read(ipu->map, JZ_REG_IPU_STATUS, &dummy);
 
 	/* ACK interrupt */
 	regmap_write(ipu->map, JZ_REG_IPU_STATUS, 0);
@@ -656,7 +658,8 @@ static irqreturn_t ingenic_ipu_irq_handler(int irq, void *arg)
 	regmap_write(ipu->map, JZ_REG_IPU_V_ADDR, ipu->addr_v);
 
 	/* Run IPU for the new frame */
-	regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_RUN);
+	if (ipu->soc_info->manual_restart)
+		regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_RUN);
 
 	drm_crtc_handle_vblank(crtc);
 
@@ -806,6 +809,7 @@ static const struct soc_info jz4725b_soc_info = {
 	.formats	= jz4725b_ipu_formats,
 	.num_formats	= ARRAY_SIZE(jz4725b_ipu_formats),
 	.has_bicubic	= false,
+	.manual_restart	= true,
 	.set_coefs	= jz4725b_set_coefs,
 };
 
@@ -831,6 +835,7 @@ static const struct soc_info jz4760_soc_info = {
 	.formats	= jz4760_ipu_formats,
 	.num_formats	= ARRAY_SIZE(jz4760_ipu_formats),
 	.has_bicubic	= true,
+	.manual_restart	= false,
 	.set_coefs	= jz4760_set_coefs,
 };
 
-- 
2.27.0

