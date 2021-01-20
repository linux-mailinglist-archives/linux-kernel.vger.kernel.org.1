Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1802FCFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbhATLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388967AbhATLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611141171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaVChp93kjUJQWwYa3RlWVeIqb0T8DfMi5AmI52Gajo=;
        b=N+UFv8Pu9XYI8GXx5GAmOW9tw1OQ1FuZHhg+j1UpiKdnTw+yR5R44v9a9ckbgiTOEkR5+2
        b3pMqaHzsfyrqk0rIqQRpf5prHIW96ayzgyq8gkHGnoZ3dfYOnmwIoKeK++TO31uyYsva+
        lMON9lL+f+NAtX2ZrO4TJXOio2NDswk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-N87hfp_KMSCq_xAMu9VlJQ-1; Wed, 20 Jan 2021 06:12:49 -0500
X-MC-Unique: N87hfp_KMSCq_xAMu9VlJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED901806661;
        Wed, 20 Jan 2021 11:12:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12A50709A4;
        Wed, 20 Jan 2021 11:12:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E4A3218000B6; Wed, 20 Jan 2021 12:12:40 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] drm/qxl: use drmm_mode_config_init
Date:   Wed, 20 Jan 2021 12:12:37 +0100
Message-Id: <20210120111240.2509679-2-kraxel@redhat.com>
In-Reply-To: <20210120111240.2509679-1-kraxel@redhat.com>
References: <20210120111240.2509679-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 012bce0cdb65..38d6b596094d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1195,7 +1195,9 @@ int qxl_modeset_init(struct qxl_device *qdev)
 	int i;
 	int ret;
 
-	drm_mode_config_init(&qdev->ddev);
+	ret = drmm_mode_config_init(&qdev->ddev);
+	if (ret)
+		return ret;
 
 	ret = qxl_create_monitors_object(qdev);
 	if (ret)
@@ -1228,5 +1230,4 @@ int qxl_modeset_init(struct qxl_device *qdev)
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
 	qxl_destroy_monitors_object(qdev);
-	drm_mode_config_cleanup(&qdev->ddev);
 }
-- 
2.29.2

