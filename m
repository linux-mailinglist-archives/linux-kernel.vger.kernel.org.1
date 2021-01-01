Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA772E856C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAATdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 14:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbhAATc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 14:32:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6166CC061573
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 11:32:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v1so6430843pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 11:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RBVQjzvg2vAOr7EaTp5W0IS1YdquATj1m1nJKqT0atk=;
        b=Be5hZgP/Htvvz0wVqlTBQiP9aeu8JxSdkadB/INSbXXI9KlQl7gI49YJXzlavDZ2Gt
         UINa9x3BjnUifwPWca3cSj/TR/ZXBevkgs+3tc+irTA6oME4XS7Z4ZW3cagTwN6ktJbb
         4bTjn4+eUUqmKYFCV4a/ai6JdUDoCRVxrr2fWKhNeacmmCGLY4S14k81Dwrv4kVWGrD/
         MgMoV+iQ9Gm2OWpYVf4CoRzJBqX9lvj+VmsJTy2ltT7/4PRdEWhjaxd1o1R+XK2FEDGZ
         ueKyHHfL7AON2pu1gGiC4Fv1ayJLuZ9YsbcUvvVTDxZm2kb4KCLBpEjG6w12uI2hv01p
         BDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RBVQjzvg2vAOr7EaTp5W0IS1YdquATj1m1nJKqT0atk=;
        b=qky4Xb5FOV+4FqOAG/ruiQaAHLjj08zZPJbQBcdJ168dZy2VWAPEz30zqu+FrKLB1r
         dK/GZ1dcnVjtwwNOIbGXGEKmwZnz1Jdb1h+NlewWwzvl8ZyQMPiD5woFvsfMv/c+vCjc
         bUJFOHO+5LnLV+aUJ76/DH3Arz8WJuN2tMZpNXdV5k2wq7JKt/chqF58T4pJbnkgaU1I
         OTFw6/MsCoER96NdA2lTryWTUnHArWYeE7qoaKWZeCWPvgToBwMqL44Z2gUrwDckm9Q/
         KcoPPEbKGm7vZxH2QfXIjMG67Fp9Kge39KAwKlQtE1/yCEdCxCBSTrtHIZcIlMETSAHu
         /wCw==
X-Gm-Message-State: AOAM530BKZBuOgbwX0089n/4UsRsSl2kppQk5ylx79mtuOgIWi0naANu
        yD/xe6uTsZZy5yzgpg5TmQg=
X-Google-Smtp-Source: ABdhPJzQfhLQNusBa58WECbRacrHTh9tGRNhVSlSjBye+1n+V0kS87btsBe78lwi5Icja7u8ybAmYg==
X-Received: by 2002:a17:90a:300c:: with SMTP id g12mr19182828pjb.4.1609529538861;
        Fri, 01 Jan 2021 11:32:18 -0800 (PST)
Received: from adolin ([49.207.192.47])
        by smtp.gmail.com with ESMTPSA id z23sm40771132pfj.143.2021.01.01.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 11:32:18 -0800 (PST)
Date:   Sat, 2 Jan 2021 01:02:13 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Decouple config data for configfs
Message-ID: <20210101193213.2dq6o7m3kgxf6wt7@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
is added, device configuration- enabling/disabling features will
be tracked by configfs and only vkms device lifetime will be kept track of
by vkms_init and vkms_exit functions.

Modify usage of enable_cursor feature to reflect the changes in
relevant files.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 40 ++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_drv.h    | 11 +++++---
 drivers/gpu/drm/vkms/vkms_output.c |  4 +--
 3 files changed, 42 insertions(+), 13 deletions(-)

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
index 5ed91ff08cb3..2fa0c52f1dd8 100644
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
@@ -82,10 +80,17 @@ struct vkms_output {
 	spinlock_t composer_lock;
 };
 
+struct vkms_device;
+struct vkms_config {
+	bool cursor;
+	/* only set when instantiated */
+	struct vkms_device *dev;
+};
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
 	struct vkms_output output;
+	const struct vkms_config *config;
 };
 
 #define drm_crtc_to_vkms_output(target) \
@@ -123,4 +128,4 @@ void vkms_set_composer(struct vkms_output *out, bool enabled);
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
 
-#endif /* _VKMS_DRV_H_ */
+#endif /* _VKMS_DRV_H_ */
\ No newline at end of file
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

