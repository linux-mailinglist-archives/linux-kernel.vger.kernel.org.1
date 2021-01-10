Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759932F077F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAJOEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:04:20 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4CC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:03:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 15so10862620pgx.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIyCJKDhvNH8KI19OBGyEbU3SM6tfKfgJa5ae5NSM3Y=;
        b=HiJTD2W/u13EYRPuUkdlp3Y73fn6Bh8nXPbDXnvEaQmGT6bXU4a/PG7pFS0qPB/BSw
         9610tVvZ3iZQxR7NRAVM9GwQNM2qfHFM3Ywpx031urwBFP4vZT4H5n2eWY/yjAmzP41r
         3bZU9TCvX9Krw0+YmccQIym54Ddw/by7k/KMZ2rD3B3YgAMUo0ux53uYEN0wxoZ3IWH9
         UfHHcefHteYKSVWRwVGtBCu0CaU/ufAqBphu/n4L9qoxl5aLzGG7xRv2flceXpUVPX6t
         i5F+4I3E1/JMj66AdLt2uUngpbnCDrpAxjeodO2V6eGLk/H9LA3CFO6SAJrFx5lgvuP3
         y52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIyCJKDhvNH8KI19OBGyEbU3SM6tfKfgJa5ae5NSM3Y=;
        b=jXTQ8mWKhHogckdVYJIF+xshLqdXiq5IbTxr2uklF3vWQF7mzFE4rofjKBOBVe422H
         TBv7+eDRsTsXIoILdTag+71Nni33E7byyAonQgJh3O6eb541U9PbznywZhxKlFylhTMT
         r8DjCxXF0yVLl5Qe7sZe7OCIejUU0L8n34g1l7Rl0uPhAxbjyz3/xbrpNd5qJ7s1RhaK
         Y9oGYXEbDh4MviCHphldQl2Rg8MhiM09LojDfjbVQUcV350NCsjT+SXN+E1KchdNDQU1
         259lpV6fmxAiu4utlrG6LfHisHeDXiB0G1Jlksv/3pS9DJPn4yBGmiB/b/G/4NjyCje4
         2q9g==
X-Gm-Message-State: AOAM531kVIDKGx5PnC+QXay6kCAmVPhIYu8AcbQjZXs0m0AnGmGb5owb
        s8sA01jM9ST3J8QjWI5Xe7E=
X-Google-Smtp-Source: ABdhPJzrgetujynFxasAmcAIGagbghX9wHgU78QQR/6fP5va0gSXKjd/AwmjOl8EXhBdAAJ2LSzZNA==
X-Received: by 2002:a62:7c4a:0:b029:19d:b7bc:2c51 with SMTP id x71-20020a627c4a0000b029019db7bc2c51mr12744282pfc.30.1610287419616;
        Sun, 10 Jan 2021 06:03:39 -0800 (PST)
Received: from adolin ([49.207.199.194])
        by smtp.gmail.com with ESMTPSA id 193sm16096035pfz.36.2021.01.10.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:03:39 -0800 (PST)
Date:   Sun, 10 Jan 2021 19:33:34 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] drm/vkms: Add vkms_config type
Message-ID: <a090ad29b826185df30f80c66932dd2173d7b060.1610200411.git.sylphrenadin@gmail.com>
References: <cover.1610200411.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610200411.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, data for the device instance is held by vkms_device.
Add a separate type, vkms_config to contain configuration details
for the device and various modes to be later used by configfs.
This config data stays constant once the device is created.

Accordingly, add vkms_create and vkms_destroy to initialize/destroy
device through configfs. Currently, they are being called from vkms_init
and vkms_exit, but will be evoked from configfs later on. When configfs
is added, device configuration will be tracked by configfs and only vkms
device lifetime will be handled by vkms_init and vkms_exit functions.

Modify usage of enable_cursor feature to reflect the changes in
relevant files.

Co-developed-by: Daniel Vetter <danvet.vetter@ffwl.ch>
Signed-off-by: Daniel Vetter <danvet.vetter@ffwl.ch>
Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 40 ++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_drv.h    | 12 +++++++--
 drivers/gpu/drm/vkms/vkms_output.c |  4 +--
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index aef29393b811..6b33975a5cb2 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -34,9 +34,9 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-static struct vkms_device *vkms_device;
+static struct vkms_config *default_config;
 
-bool enable_cursor = true;
+static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
@@ -122,10 +122,11 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	return vkms_output_init(vkmsdev, 0);
 }
 
-static int __init vkms_init(void)
+static int vkms_create(struct vkms_config *config)
 {
 	int ret;
 	struct platform_device *pdev;
+	struct vkms_device *vkms_device;
 
 	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
 	if (IS_ERR(pdev))
@@ -143,6 +144,8 @@ static int __init vkms_init(void)
 		goto out_devres;
 	}
 	vkms_device->platform = pdev;
+	vkms_device->config = config;
+	config->dev = vkms_device;
 
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
@@ -179,21 +182,42 @@ static int __init vkms_init(void)
 	return ret;
 }
 
-static void __exit vkms_exit(void)
+static int __init vkms_init(void)
+{
+	struct vkms_config *config = kmalloc(sizeof(*config), GFP_KERNEL);
+
+	default_config = config;
+
+	config->cursor = enable_cursor;
+
+	return vkms_create(config);
+}
+
+static void vkms_destroy(struct vkms_config *config)
 {
 	struct platform_device *pdev;
 
-	if (!vkms_device) {
+	if (!config->dev) {
 		DRM_INFO("vkms_device is NULL.\n");
 		return;
 	}
 
-	pdev = vkms_device->platform;
+	pdev = config->dev->platform;
 
-	drm_dev_unregister(&vkms_device->drm);
-	drm_atomic_helper_shutdown(&vkms_device->drm);
+	drm_dev_unregister(&config->dev->drm);
+	drm_atomic_helper_shutdown(&config->dev->drm);
 	devres_release_group(&pdev->dev, NULL);
 	platform_device_unregister(pdev);
+
+	config->dev = NULL;
+}
+
+static void __exit vkms_exit(void)
+{
+	if (default_config->dev)
+		vkms_destroy(default_config);
+
+	kfree(default_config);
 }
 
 module_init(vkms_init);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 5ed91ff08cb3..6a27bd8875f2 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -19,8 +19,6 @@
 #define XRES_MAX  8192
 #define YRES_MAX  8192
 
-extern bool enable_cursor;
-
 struct vkms_composer {
 	struct drm_framebuffer fb;
 	struct drm_rect src, dst;
@@ -82,10 +80,19 @@ struct vkms_output {
 	spinlock_t composer_lock;
 };
 
+struct vkms_device;
+
+struct vkms_config {
+	bool cursor;
+	/* only set when instantiated */
+	struct vkms_device *dev;
+};
+
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
 	struct vkms_output output;
+	const struct vkms_config *config;
 };
 
 #define drm_crtc_to_vkms_output(target) \
@@ -124,3 +131,4 @@ void vkms_set_composer(struct vkms_output *out, bool enabled);
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
 
 #endif /* _VKMS_DRV_H_ */
+
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 4a1848b0318f..8f3ffb28b9d1 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -46,7 +46,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
-	if (enable_cursor) {
+	if (vkmsdev->config->cursor) {
 		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
 		if (IS_ERR(cursor)) {
 			ret = PTR_ERR(cursor);
@@ -98,7 +98,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	drm_crtc_cleanup(crtc);
 
 err_crtc:
-	if (enable_cursor)
+	if (vkmsdev->config->cursor)
 		drm_plane_cleanup(cursor);
 
 err_cursor:
-- 
2.25.1

