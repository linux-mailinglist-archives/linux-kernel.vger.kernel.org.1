Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5725211D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHYTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 15:51:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbgHYTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598385079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gTAM7TDlgZMdWHt2r6XU0KzwhLUE1MvpqOoSpb17cM=;
        b=fQmZ/23USaUz++oFdBfCHfiIBgy94NDWH8o1OghN9TvynIpv4kAc3EAVYRl2BHx6EhKkJb
        NcH1643hL+VkPuSv0Kk6NbE+G0Ogc3lJVjs8qlhfElIkRemrkQ7W+0oYDnQOyIujNccHGG
        Cfw2+gaFUPEbmoMFxyAEfbJnXscCxNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-OLY4AcPcP1W_beuMdy0gmw-1; Tue, 25 Aug 2020 15:51:17 -0400
X-MC-Unique: OLY4AcPcP1W_beuMdy0gmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19CEF18551A2;
        Tue, 25 Aug 2020 19:51:16 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-227.rdu2.redhat.com [10.10.120.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAC25D9D3;
        Tue, 25 Aug 2020 19:51:15 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 10/20] drm/nouveau/kms: Use new drm_dp_has_mst() helper for checking MST caps
Date:   Tue, 25 Aug 2020 15:50:17 -0400
Message-Id: <20200825195027.74681-11-lyude@redhat.com>
In-Reply-To: <20200825195027.74681-1-lyude@redhat.com>
References: <20200825195027.74681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 032afc73e2a33..201c0b4335563 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -44,7 +44,6 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
 	struct nv50_mstm *mstm = NULL;
 	int ret;
 	u8 *dpcd = outp->dp.dpcd;
-	u8 tmp;
 
 	ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
 	if (ret == DP_RECEIVER_CAP_SIZE && dpcd[DP_DPCD_REV]) {
@@ -56,19 +55,10 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
 		return connector_status_disconnected;
 	}
 
-	if (nouveau_mst)
+	if (nouveau_mst) {
 		mstm = outp->dp.mstm;
-
-	if (mstm) {
-		if (dpcd[DP_DPCD_REV] >= DP_DPCD_REV_12) {
-			ret = drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &tmp);
-			if (ret < 0)
-				return connector_status_disconnected;
-
-			mstm->can_mst = !!(tmp & DP_MST_CAP);
-		} else {
-			mstm->can_mst = false;
-		}
+		if (mstm)
+			mstm->can_mst = drm_dp_has_mst(aux, dpcd);
 	}
 
 	return connector_status_connected;
-- 
2.26.2

