Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FD2EADD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbhAEPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAEPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:00:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE5C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 07:00:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z12so1838002pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=n7TlG8NN8jqja9Y8WW/SFKAXx/PSZJP7n6gKEltVpFU=;
        b=eXHexYoCXgtAr+oro3RAi4gfVhK320MQZQrx7m30ZY0OxfQbvA00LFGYpOSQIOp6Zp
         3JGi19GS54y/X/0a3KrwCKvSFWREaeD6E4R8M1aNXeHoB8hFtsLvQN6eb4VyiLfBvSu1
         5UhFSCux5CuChplhG08+F1MTLE017f5ZigwMf4Rf1Oor/jJ3v7Ls4h3ET+Ks2ZAjLum0
         NQh9vAiiyR0JyWVTN3fw6hTl/jb/oo2G3Q4SMrxjG4Z4nl31Rz2nWlfDovAYXQmNmwEf
         xPoENgIUqO6eyVhZsjW3/8TI8VbH3eLl5MLsYSl4wH//StMZqSS+aguARmnipFZ2k+ye
         CSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=n7TlG8NN8jqja9Y8WW/SFKAXx/PSZJP7n6gKEltVpFU=;
        b=osA/hCarGai4bLVQQGS0D7cDvFVuL1krXcstNYXEXsxcBWv/f12QJ2GVSpXGWQdtGg
         mURO3TidlV6fl8wTCU8f/Tdd4859rNWeGvGIAsZV0DX/TTlwHjdxRyC0MWMqvAuFwW/g
         XjKd/fcwAtE7cV2uUwD/KjOuN9nWFu+90Q21VGzmz0NWLxZCyGPgTjEvGN+aGyxHay+z
         u3BJclMhbPTpoZrIQoHEn/VTVye5DUz1wwsCuBufTLu+w/n9PpiBrkGvNWiQfDCY1Cwy
         hbm2/79Yn7qpf+QL5N8oNKMZK0/a5CZTF7Ns1UtFM1FZkWEwGEwG1CnIvIWWEgB6qbMz
         AxVQ==
X-Gm-Message-State: AOAM532NSeYEiWhK5NCzKJT6/lXHvHtH9K8oOmJ2fuYWTUJ+lxPpiFLC
        j5vrUAXyYsgRYkUTU2YYi0s=
X-Google-Smtp-Source: ABdhPJzt2J2xbYGa8V2kGsXoiPVNPLpxYJEqiOjOODtDuZUQdq7tB1tHlFrmXSkPHwXwOMX7QndZgw==
X-Received: by 2002:a17:90a:e60d:: with SMTP id j13mr4560199pjy.52.1609858804291;
        Tue, 05 Jan 2021 07:00:04 -0800 (PST)
Received: from adolin ([49.207.206.190])
        by smtp.gmail.com with ESMTPSA id nm6sm2956012pjb.25.2021.01.05.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 07:00:03 -0800 (PST)
Date:   Tue, 5 Jan 2021 20:29:58 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] drm/vkms: Decouple config data for configfs
Message-ID: <20210105145958.r5q553i6ji7fru6l@adolin>
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
is added, device configuration will be tracked by configfs and only vkms
device lifetime will be handled by vkms_init and vkms_exit functions.

Modify usage of enable_cursor feature to reflect the changes in
relevant files.

Add enable_writeback_connector feature to vkms_config type.

Co-developed-by: Daniel Vetter <danvet.vetter@ffwl.ch>
Signed-off-by: Daniel Vetter <danvet.vetter@ffwl.ch>
Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in v2:
- add Co-developed-by tag

Changes in v3:
- correct usage of Co-developed by tag(Melissa)
- add enable_writeback_feature(Melissa)
- modify commit message(Melissa)
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 45 ++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_drv.h    | 12 ++++++--
 drivers/gpu/drm/vkms/vkms_output.c | 13 +++++----
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index aef29393b811..fab964900dce 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -34,12 +34,16 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-static struct vkms_device *vkms_device;
+static struct vkms_config *default_config;
 
-bool enable_cursor = true;
+static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
+static bool enable_writeback_connector = true;
+module_param_named(enable_writeback_connector, enable_writeback_connector, bool, 0444);
+MODULE_PARM_DESC(enable_writeback_connector, "Enable/Disable writeback connector support");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_release(struct drm_device *dev)
@@ -122,10 +126,11 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
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
@@ -143,6 +148,8 @@ static int __init vkms_init(void)
 		goto out_devres;
 	}
 	vkms_device->platform = pdev;
+	vkms_device->config = config;
+	config->dev = vkms_device;
 
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
@@ -179,21 +186,43 @@ static int __init vkms_init(void)
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
+	config->writeback = enable_writeback_connector;
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
index 5ed91ff08cb3..caa1fafb6ca7 100644
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
@@ -82,10 +80,18 @@ struct vkms_output {
 	spinlock_t composer_lock;
 };
 
+struct vkms_device;
+struct vkms_config {
+	bool writeback;
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
@@ -123,4 +129,4 @@ void vkms_set_composer(struct vkms_output *out, bool enabled);
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
 
-#endif /* _VKMS_DRV_H_ */
+#endif /* _VKMS_DRV_H_ */
\ No newline at end of file
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 4a1848b0318f..f5f6f15c362c 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -41,12 +41,13 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct drm_crtc *crtc = &output->crtc;
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
+	int writeback;
 
 	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
-	if (enable_cursor) {
+	if (vkmsdev->config->cursor) {
 		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
 		if (IS_ERR(cursor)) {
 			ret = PTR_ERR(cursor);
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
 
@@ -98,7 +101,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	drm_crtc_cleanup(crtc);
 
 err_crtc:
-	if (enable_cursor)
+	if (vkmsdev->config->cursor)
 		drm_plane_cleanup(cursor);
 
 err_cursor:
-- 
2.25.1

