Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7E274AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgIVVGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgIVVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600808780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sr3T0ukk/W15C/CAPmiVoDX0sWYPsfGDtdGAlrgJm+c=;
        b=avh1bC7QujYvVsuf6piGAUgO+JMfbtj3hvKv1zmvzvry8I5zVfZSGmh+ZGO4M89b04ID+x
        c1FpGVKAgtKL3XMZbbA4q2ec6MpptNiJCN5UiwoMGTNGh9V0lYihb726FLZPMkoP8rULqg
        pJDBC91xU1ZNbd/V/+zX8NdbFCsi9JY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-owTXjB_mP5WW8xca94WYQQ-1; Tue, 22 Sep 2020 17:06:16 -0400
X-MC-Unique: owTXjB_mP5WW8xca94WYQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6351C1007464;
        Tue, 22 Sep 2020 21:06:15 +0000 (UTC)
Received: from Ruby.redhat.com (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 777FA5DE50;
        Tue, 22 Sep 2020 21:06:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in nv50_dp_mode_valid()
Date:   Tue, 22 Sep 2020 17:05:10 -0400
Message-Id: <20200922210510.156220-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I thought I had this correct (since it actually did reject modes
like I expected during testing), Ville Syrjala from Intel pointed out
that the logic here isn't correct. max_clock refers to the max symbol
rate supported by the encoder, so limiting clock to ds_clock using max()
doesn't make sense. Additionally, we want to check against 6bpc for the
time being since that's the minimum possible bpc here, not the reported
bpc from the connector. See:

https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html

For more info.

So, let's rewrite this using Ville's advice.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock limits for mode validation")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 7b640e05bd4cd..24c81e423d349 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector *connector,
 		   const struct drm_display_mode *mode,
 		   unsigned *out_clock)
 {
-	const unsigned min_clock = 25000;
-	unsigned max_clock, ds_clock, clock;
+	const unsigned int min_clock = 25000;
+	unsigned int max_clock, ds_clock, clock;
+	const u8 bpp = 18; /* 6 bpc */
 	enum drm_mode_status ret;
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
 		return MODE_NO_INTERLACE;
 
 	max_clock = outp->dp.link_nr * outp->dp.link_bw;
-	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
-						  outp->dp.downstream_ports);
-	if (ds_clock)
-		max_clock = min(max_clock, ds_clock);
-
-	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
-	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
-					    &clock);
+	clock = mode->clock * bpp / 8;
+	if (clock > max_clock)
+		return MODE_CLOCK_HIGH;
+
+	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp->dp.downstream_ports);
+	if (ds_clock && mode->clock > ds_clock)
+		return MODE_CLOCK_HIGH;
+
+	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock, &clock);
 	if (out_clock)
 		*out_clock = clock;
+
 	return ret;
 }
-- 
2.26.2

