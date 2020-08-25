Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29F82520FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHYTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 15:50:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbgHYTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598385054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcFp48n/aLMtpSE/1lSAUTj8bSRshm4WBYhHn9wvw8Q=;
        b=ANJ0Qn3PmL0NlNapvHPjp+n1m76bZoRA/4/bYjTRhnXAbXCgC3YrLE1Iad5Jti6TNrfb1Z
        Ajue8Jfs8nVFheWEfy+DMsAtrH+Jzg/54omC6gp7hYjSneOHk6Iny0KfrZrI97qMWiuqTv
        5yRWH4g6hgj0pFbo3JVJR8drnyS+gvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-yZX0uUUeN62Z5EUaxlUvSQ-1; Tue, 25 Aug 2020 15:50:53 -0400
X-MC-Unique: yZX0uUUeN62Z5EUaxlUvSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 526001014E00;
        Tue, 25 Aug 2020 19:50:51 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-227.rdu2.redhat.com [10.10.120.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC5975D9D3;
        Tue, 25 Aug 2020 19:50:49 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 05/20] drm/nouveau/kms: Don't clear DP_MST_CTRL DPCD in nv50_mstm_new()
Date:   Tue, 25 Aug 2020 15:50:12 -0400
Message-Id: <20200825195027.74681-6-lyude@redhat.com>
In-Reply-To: <20200825195027.74681-1-lyude@redhat.com>
References: <20200825195027.74681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fa3cdf8d0b09 ("drm/nouveau: Reset MST branching unit before
enabling") we've been clearing DP_MST_CTRL before we start enabling MST.
Since then clearing DP_MST_CTRL in nv50_mstm_new() has been unnecessary
and redundant, so let's remove it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e7874877da858..c4d138f0ca054 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1535,17 +1535,6 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 	struct drm_device *dev = outp->base.base.dev;
 	struct nv50_mstm *mstm;
 	int ret;
-	u8 dpcd;
-
-	/* This is a workaround for some monitors not functioning
-	 * correctly in MST mode on initial module load.  I think
-	 * some bad interaction with the VBIOS may be responsible.
-	 *
-	 * A good ol' off and on again seems to work here ;)
-	 */
-	ret = drm_dp_dpcd_readb(aux, DP_DPCD_REV, &dpcd);
-	if (ret >= 0 && dpcd >= 0x12)
-		drm_dp_dpcd_writeb(aux, DP_MSTM_CTRL, 0);
 
 	if (!(mstm = *pmstm = kzalloc(sizeof(*mstm), GFP_KERNEL)))
 		return -ENOMEM;
-- 
2.26.2

