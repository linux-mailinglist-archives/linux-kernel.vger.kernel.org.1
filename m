Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E642747CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVRyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgIVRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600797259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NohBF9hAWZCXDLKEK08Sf9Lg0kRzkT+pBxKOk6E4yU=;
        b=gZGfFp3cbWB6hgpH3f9/573X1BkLHbvicYjWYPua45TYQQo6dcfVhpObksaCtsnfr7Ow6x
        7e30mS/sr78KZIuLAlXMEFF3T8Knrwu6flV0m9ui7uy1TQG4xGCxJwlFSXB1AItAq/TZSV
        3M1aZS0F5YkbtrnxJxwF28PxusW4cAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-MMf9XHsBOvmwtziY-7XyDQ-1; Tue, 22 Sep 2020 13:54:15 -0400
X-MC-Unique: MMf9XHsBOvmwtziY-7XyDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6344781CBF1;
        Tue, 22 Sep 2020 17:54:13 +0000 (UTC)
Received: from Ruby.redhat.com (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4939C7368D;
        Tue, 22 Sep 2020 17:54:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH 2/2] drm/dp: fix a kernel-doc issue at drm_edid.c
Date:   Tue, 22 Sep 2020 13:53:57 -0400
Message-Id: <20200922175357.42998-3-lyude@redhat.com>
In-Reply-To: <20200922175357.42998-1-lyude@redhat.com>
References: <20200922175357.42998-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The name of the argument is different, causing those warnings:

	./drivers/gpu/drm/drm_edid.c:3754: warning: Function parameter or member 'video_code' not described in 'drm_display_mode_from_cea_vic'
	./drivers/gpu/drm/drm_edid.c:3754: warning: Excess function parameter 'vic' description in 'drm_display_mode_from_cea_vic'

Fixes: 7af655bce275 ("drm/dp: Add drm_dp_downstream_mode()")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a82f37d44258..631125b46e04 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3741,7 +3741,7 @@ drm_add_cmdb_modes(struct drm_connector *connector, u8 svd)
 /**
  * drm_display_mode_from_cea_vic() - return a mode for CEA VIC
  * @dev: DRM device
- * @vic: CEA VIC of the mode
+ * @video_code: CEA VIC of the mode
  *
  * Creates a new mode matching the specified CEA VIC.
  *
-- 
2.26.2

