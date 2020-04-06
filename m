Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DC1A00B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDFWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 18:13:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgDFWNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7FAESrU1cyyiP4ssSlJ0zFYn42hCfuVnZNataCYmDk=;
        b=eeEIAlYXVCpbE1IWHbRhBkdMmamj51mUV69RIYAPqbsZEdUUJprxPdty4pm8TcaH5dIg4K
        GFZrUlpgNX2c0ts6/HiSDA+/4WFadfo7LZCB01s0zNxTvDIIBIQMA+IKr5kYtYxvcq2uy1
        pGz2xPTgUB/lMFgeqIyInwKqQxbkeWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-jJmSxJ7mMIaTv0zYg4PmEQ-1; Mon, 06 Apr 2020 18:13:11 -0400
X-MC-Unique: jJmSxJ7mMIaTv0zYg4PmEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 874AF801A0D;
        Mon,  6 Apr 2020 22:13:09 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-12.rdu2.redhat.com [10.10.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BEA4608E1;
        Mon,  6 Apr 2020 22:13:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/dp_mst: Print errors on ACT timeouts
Date:   Mon,  6 Apr 2020 18:12:53 -0400
Message-Id: <20200406221253.1307209-5-lyude@redhat.com>
In-Reply-To: <20200406221253.1307209-1-lyude@redhat.com>
References: <20200406221253.1307209-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although it's not unexpected for drm_dp_check_act_status() to fail due
to DPCD read failures (as the hub may have just been unplugged
suddenly), timeouts are a bit more worrying as they either mean we need
a longer timeout value, or we aren't setting up payload allocations
properly. So, let's start printing errors on timeouts.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index ce61964baa7c..0cbeb0f5c834 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4499,10 +4499,14 @@ int drm_dp_check_act_status(struct drm_dp_mst_top=
ology_mgr *mgr)
 				 status & DP_PAYLOAD_ACT_HANDLED || status < 0,
 				 100, timeout_ms * USEC_PER_MSEC);
 	if (ret < 0 && status >=3D 0) {
-		DRM_DEBUG_KMS("Failed to get ACT bit %d after %dms\n",
-			      status, timeout_ms);
+		DRM_ERROR("Failed to get ACT after %dms, last status: %02x\n",
+			  timeout_ms, status);
 		return -EINVAL;
 	} else if (status < 0) {
+		/*
+		 * Failure here isn't unexpected - the hub may have
+		 * just been unplugged
+		 */
 		DRM_DEBUG_KMS("Failed to read payload table status: %d\n",
 			      status);
 		return status;
--=20
2.25.1

