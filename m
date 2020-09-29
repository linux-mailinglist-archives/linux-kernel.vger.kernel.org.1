Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7E27DC17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgI2Wbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgI2Wby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:31:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601418713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3EvNa7CARVdvxvcgx4Z06Gs+9k22STMCzS8+0wBp20=;
        b=EKpHblTleXB4ip0L+tkK/pBguSwIvOkm5TgO74rnfgZk6a7x4T5Idx99iip81wT7fM+sOU
        M8ROwQPikPnkuEESY5VHEjZV1AJTcggE6EajFw4G0VHrGpToWObvzX0WU8dKUH7lXqq/Ec
        kXoj3HrLBwsc2viRTGox3gz0PLF7I1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-wyDZfFjxNqaEGA3Qg41bcQ-1; Tue, 29 Sep 2020 18:31:45 -0400
X-MC-Unique: wyDZfFjxNqaEGA3Qg41bcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A7A186841D;
        Tue, 29 Sep 2020 22:31:44 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-121-117.rdu2.redhat.com [10.10.121.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B75B55775;
        Tue, 29 Sep 2020 22:31:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/nouveau/kms/nv50-: Fix clock checking algorithm in nv50_dp_mode_valid()
Date:   Tue, 29 Sep 2020 18:31:32 -0400
Message-Id: <20200929223132.333453-2-lyude@redhat.com>
In-Reply-To: <20200929223132.333453-1-lyude@redhat.com>
References: <20200929223132.333453-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I thought I had this correct (since it actually did reject modes
like I expected during testing), Ville Syrjala from Intel pointed out
that the logic here isn't correct. max_clock refers to the max data rate
supported by the DP encoder. So, limiting it to the output of ds_clock (which
refers to the maximum dotclock of the downstream DP device) doesn't make any
sense. Additionally, since we're using the connector's bpc as the canonical BPC
we should use this in mode_valid until we support dynamically setting the bpp
based on bandwidth constraints.

https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html

For more info.

So, let's rewrite this using Ville's advice.

v2:
* Ville pointed out I mixed up the dotclock and the link rate. So fix that...
* ...and also rename all the variables in this function to be more appropriately
  labeled so I stop mixing them up.
* Reuse the bpp from the connector for now until we have dynamic bpp selection.
* Use use DIV_ROUND_UP for calculating the mode rate like i915 does, which we
  should also have been doing from the start

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock limits for mode validation")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 93e3751ad7f1..040ed88d362d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -231,8 +231,9 @@ nv50_dp_mode_valid(struct drm_connector *connector,
 		   const struct drm_display_mode *mode,
 		   unsigned *out_clock)
 {
-	const unsigned min_clock = 25000;
-	unsigned max_clock, ds_clock, clock = mode->clock;
+	const unsigned int min_clock = 25000;
+	unsigned int max_rate, mode_rate, ds_max_dotclock, clock = mode->clock;
+	const u8 bpp = connector->display_info.bpc * 3;
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
 		return MODE_NO_INTERLACE;
@@ -240,17 +241,17 @@ nv50_dp_mode_valid(struct drm_connector *connector,
 	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) == DRM_MODE_FLAG_3D_FRAME_PACKING)
 		clock *= 2;
 
-	max_clock = outp->dp.link_nr * outp->dp.link_bw;
-	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
-						  outp->dp.downstream_ports);
-	if (ds_clock)
-		max_clock = min(max_clock, ds_clock);
+	max_rate = outp->dp.link_nr * outp->dp.link_bw;
+	mode_rate = DIV_ROUND_UP(clock * bpp, 8);
+	if (mode_rate > max_rate)
+		return MODE_CLOCK_HIGH;
+
+	ds_max_dotclock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp->dp.downstream_ports);
+	if (ds_max_dotclock && clock > ds_max_dotclock)
+		return MODE_CLOCK_HIGH;
 
-	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
 	if (clock < min_clock)
 		return MODE_CLOCK_LOW;
-	if (clock > max_clock)
-		return MODE_CLOCK_HIGH;
 
 	if (out_clock)
 		*out_clock = clock;
-- 
2.26.2

