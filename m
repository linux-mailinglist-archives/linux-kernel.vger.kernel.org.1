Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F742B74ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgKRDnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:43:16 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:60332 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgKRDnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:43:15 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id D9ED74E1443;
        Wed, 18 Nov 2020 11:43:11 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ye Bin <yebin10@huawei.com>,
        Evan Quan <evan.quan@amd.com>, Andriy Gapon <avg@FreeBSD.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] amd/amdgpu: optimise CONFIG_X||CONFIG_X_MODULE to IS_ENABLED(X)
Date:   Tue, 17 Nov 2020 19:43:04 -0800
Message-Id: <20201118034306.103427-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTRgZGhpKTkIZQ0NLVkpNS05NTEtCQklKTktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6Ixw4AT8eLw9JIgovHksa
        ARhPCwFVSlVKTUtOTUxLQkJJTkJNVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSEhDTjcG
X-HM-Tid: 0a75d972f8d79376kuwsd9ed74e1443
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise CONFIG_<X> || CONFIG_<X>_MODULE to IS_ENABLED(<X>).
This change also fix check_patch.pl warning:
WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> ||
CONFIG_<FOO>_MODULE
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined
(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 165b02e267b0..f1980cd1f402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -64,7 +64,7 @@ struct amdgpu_atif {
 	struct amdgpu_atif_notifications notifications;
 	struct amdgpu_atif_functions functions;
 	struct amdgpu_atif_notification_cfg notification_cfg;
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 	struct backlight_device *bd;
 #endif
 	struct amdgpu_dm_backlight_caps backlight_caps;
@@ -447,7 +447,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 
 		if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 			if (atif->bd) {
 				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
 						 req.backlight_level);
@@ -806,7 +806,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	}
 	adev->atif = atif;
 
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 	if (atif->notifications.brightness_change) {
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
-- 
2.29.0

