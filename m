Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72D2F1EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390779AbhAKTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAKTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:08:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21282C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:07:28 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q7so281127pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOtHKCqSIIbw45nUFGf2GcagWIsamTSzMZ9NY2lE63Y=;
        b=QA/r9pk09CYjlN1etbOW3cmpLq5LzBa4BGbgG2TjnJt+nyU/RFv6XA9poFv3A9TC2N
         ypebHO1ziosYXM+Vy4TtAvaAKn9R42qLd3wX0A5RIu2FPDQ8VSjUxp9FvuZ7L0KlxKh8
         gXRxNwuKpdJUaJEdFcXchSGQlUBix9mSZpJX+KkBg5mYs9JAuxA4FQpPulPNJpKZM/Uy
         gZZ43UmM2RTkSD5lWNiStd/sr5BBsAb/9AoSMVd8PI7445Owq0TfFsfgxlonssGJue3m
         dKoj3z9jTC+05Q0d2m1BHUgRo8L4YsMr5QaxD43K7edreB+mDrXAlOs/ym4DjoIbqEYP
         kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOtHKCqSIIbw45nUFGf2GcagWIsamTSzMZ9NY2lE63Y=;
        b=f6qHxo6tVH9+4gIesL59GyhmLupVj5e5p6yIbxm9OnZm3+MlvsyXRhR1vKq1O38Zol
         XwQimxqHmko6IoyWRVw3apr+mb3b6c05MAbMoe2ocpooYgszf7lnf9BoaMM53MrMaMZ6
         EX1pkge/B/mm2evqIDLRYn9tp0EfOsIzMMhU2E/K2pr56P7O4TaDk/+idJDYOw0E+hUh
         0CRRuyxJKWdVCShB16MWQC/DGPl24QGOHJzTYZv9i9QcaqM5Ge6QsMA1ZrLdcU/SzQt+
         9lBF7QQwj9P6D7tBT4p1oKqejxPaaAM4b9ZxzX6ToblmOinSyPjG1poH4XP7O4rNJVqV
         QlSA==
X-Gm-Message-State: AOAM53180RmiPKslIsrlBCKx93m8rRgyFleS45yfAD94OdOZhoNwfNn8
        08yHywaa71fZGMs7bb+LubM=
X-Google-Smtp-Source: ABdhPJzi7w97zNdB3e9w5Z8338tC7498TpmxKB6MOQFE7DbhapSKa8KJXpbq8uJUjokaBh4kk/8Nkg==
X-Received: by 2002:a63:574b:: with SMTP id h11mr946746pgm.25.1610392047778;
        Mon, 11 Jan 2021 11:07:27 -0800 (PST)
Received: from adolin ([49.207.206.164])
        by smtp.gmail.com with ESMTPSA id iq3sm129577pjb.57.2021.01.11.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:07:27 -0800 (PST)
Date:   Tue, 12 Jan 2021 00:37:22 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/3] drm/vkms: Add support for writeback module
Message-ID: <15802da4f1cdfed2b728c3d35731732f161dd073.1610391685.git.sylphrenadin@gmail.com>
References: <cover.1610391685.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610391685.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enable_writeback feature to vkms_config as a module.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 5 +++++
 drivers/gpu/drm/vkms/vkms_drv.h    | 1 +
 drivers/gpu/drm/vkms/vkms_output.c | 9 ++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 6b33975a5cb2..708f7f54001d 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -40,6 +40,10 @@ static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
+static bool enable_writeback = true;
+module_param_named(enable_writeback, enable_writeback, bool, 0444);
+MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector support");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_release(struct drm_device *dev)
@@ -189,6 +193,7 @@ static int __init vkms_init(void)
 	default_config = config;
 
 	config->cursor = enable_cursor;
+	config->writeback = enable_writeback;
 
 	return vkms_create(config);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 6a27bd8875f2..b9b4e2bc11c0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -83,6 +83,7 @@ struct vkms_output {
 struct vkms_device;
 
 struct vkms_config {
+	bool writeback;
 	bool cursor;
 	/* only set when instantiated */
 	struct vkms_device *dev;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 8f3ffb28b9d1..f5f6f15c362c 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -41,6 +41,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct drm_crtc *crtc = &output->crtc;
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
+	int writeback;
 
 	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
@@ -80,9 +81,11 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
-	ret = vkms_enable_writeback_connector(vkmsdev);
-	if (ret)
-		DRM_ERROR("Failed to init writeback connector\n");
+	if (vkmsdev->config->writeback) {
+		writeback = vkms_enable_writeback_connector(vkmsdev);
+		if (writeback)
+			DRM_ERROR("Failed to init writeback connector\n");
+	}
 
 	drm_mode_config_reset(dev);
 
-- 
2.25.1

