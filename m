Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8941ABA78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440516AbgDPHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:55:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440221AbgDPHyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:54:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E075AE5C;
        Thu, 16 Apr 2020 07:54:31 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix regression by audio component transition
Date:   Thu, 16 Apr 2020 09:54:28 +0200
Message-Id: <20200416075428.25521-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 742db30c4ee6 ("drm/nouveau: Add HD-audio component
notifier support"), the nouveau driver notifies and pokes the HD-audio
HPD and ELD via audio component, but this seems broken.  The culprit
is the naive assumption that crtc->index corresponds to the HDA pin.
Actually this rather corresponds to the MST dev_id (alias "pipe" in
the audio component framework) while the actual port number is given
from the output ior id number.

This patch corrects the assignment of port and dev_id arguments in the
audio component ops to recover from the HDMI/DP audio regression.

Fixes: 742db30c4ee6 ("drm/nouveau: Add HD-audio component notifier support")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207223
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index a3dc2ba19fb2..3a9fd565079d 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -481,15 +481,16 @@ nv50_dac_create(struct drm_connector *connector, struct dcb_output *dcbe)
  * audio component binding for ELD notification
  */
 static void
-nv50_audio_component_eld_notify(struct drm_audio_component *acomp, int port)
+nv50_audio_component_eld_notify(struct drm_audio_component *acomp, int port,
+				int dev_id)
 {
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
 		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
-						 port, -1);
+						 port, dev_id);
 }
 
 static int
-nv50_audio_component_get_eld(struct device *kdev, int port, int pipe,
+nv50_audio_component_get_eld(struct device *kdev, int port, int dev_id,
 			     bool *enabled, unsigned char *buf, int max_bytes)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(kdev);
@@ -505,7 +506,8 @@ nv50_audio_component_get_eld(struct device *kdev, int port, int pipe,
 		nv_encoder = nouveau_encoder(encoder);
 		nv_connector = nouveau_encoder_connector_get(nv_encoder);
 		nv_crtc = nouveau_crtc(encoder->crtc);
-		if (!nv_connector || !nv_crtc || nv_crtc->index != port)
+		if (!nv_connector || !nv_crtc || nv_encoder->or != port ||
+		    nv_crtc->index != dev_id)
 			continue;
 		*enabled = drm_detect_monitor_audio(nv_connector->edid);
 		if (*enabled) {
@@ -599,7 +601,8 @@ nv50_audio_disable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc)
 
 	nvif_mthd(&disp->disp->object, 0, &args, sizeof(args));
 
-	nv50_audio_component_eld_notify(drm->audio.component, nv_crtc->index);
+	nv50_audio_component_eld_notify(drm->audio.component, nv_encoder->or,
+					nv_crtc->index);
 }
 
 static void
@@ -633,7 +636,8 @@ nv50_audio_enable(struct drm_encoder *encoder, struct drm_display_mode *mode)
 	nvif_mthd(&disp->disp->object, 0, &args,
 		  sizeof(args.base) + drm_eld_size(args.data));
 
-	nv50_audio_component_eld_notify(drm->audio.component, nv_crtc->index);
+	nv50_audio_component_eld_notify(drm->audio.component, nv_encoder->or,
+					nv_crtc->index);
 }
 
 /******************************************************************************
-- 
2.16.4

