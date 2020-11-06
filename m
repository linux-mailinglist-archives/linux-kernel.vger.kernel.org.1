Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8482A9F80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgKFVuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgKFVuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE27C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so2767268wrf.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjA8v4JLA0wt0cf7/uKVTogVLZnV31tTyBrzOli6fTM=;
        b=Oia3Jh4+Z4jZyw1RDFWjabOewBGewQgIFa2hSMdeANo/YNjwRKSyyHR/LmjPTFtqt1
         s1PWVzmYK/yiFcYzVOiScC7s9flKEXDvrwkM8+oFQquVQSrvMGl3gMbuKiDFQZsoSMb0
         rVNafzN6YaSO41UutCfcOGF7aLMiRl5tBPvTD3hz392MP3sMQmLcsT4BykIuFqirx8xj
         L0xAzBNZGRx/MvGtnG1EMg+6rETJR5G94Dl9+sR3bxebp6rscL2fgQ57Y0TR5TU2S0dL
         hBmeBZSxQW/agwFMc4PH6qo9+jx7lpTW+LKLienKAzuco0zomsAXcRe7G/4pzTNyydrt
         sa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjA8v4JLA0wt0cf7/uKVTogVLZnV31tTyBrzOli6fTM=;
        b=MwVbtnw8iiawdg2Mbe41tmBHuZNC65/7Cv4Vp3rVHBdeLoMgtZQQiWQCb8I1C/dBEq
         /5VR9tSXs6Wh/6ocqhU2y1DhY/bRWFRNqGzl29p6x55SyUzMimBRQo2X8m69r88Vfo26
         E3CFewZ7T3V9t6PYywwp/JUAVOwMcbM6P+srynMteSQIdxx4bgjzQeImu8b/tlSIImxj
         lgheTZgTcwHD9WvqLeXtI3vWPmOnjgrTXDzdWWT94qY3UeaflrA+r06E6l+NE1FnHtEd
         +Cr1aBxjuNFMj8xek0YbXZKQzsDuPnPkL+ARYPbKQEVlWOUrg7lNHBSr9xwFdhgAKwQ9
         lRhQ==
X-Gm-Message-State: AOAM532tGDDATgAi0jthPKSH+upbDCewMCoHKPSRCCaUo3Yz6w4eNbet
        vMVQEXahqtgeYCgXRwuikFVn4w==
X-Google-Smtp-Source: ABdhPJz+gy7qopMT/b5AA8BVa5aWxWSV04A6Br6J+M2a8ma5BFJoYvg7Jj40fv8t9h+032uRRuXJ8g==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr5035604wre.40.1604699409717;
        Fri, 06 Nov 2020 13:50:09 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/19] drm/radeon/radeon_drv: Move prototypes to a shared headerfile
Date:   Fri,  6 Nov 2020 21:49:43 +0000
Message-Id: <20201106214949.2042120-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 62 | void radeon_driver_unload_kms(struct drm_device *dev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:105:5: warning: no previous prototype for ‘radeon_driver_load_kms’ [-Wmissing-prototypes]
 105 | int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 | ^~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:619:6: warning: no previous prototype for ‘radeon_driver_lastclose_kms’ [-Wmissing-prototypes]
 619 | void radeon_driver_lastclose_kms(struct drm_device *dev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:634:5: warning: no previous prototype for ‘radeon_driver_open_kms’ [-Wmissing-prototypes]
 634 | int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 | ^~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_kms.c:705:6: warning: no previous prototype for ‘radeon_driver_postclose_kms’ [-Wmissing-prototypes]
 705 | void radeon_driver_postclose_kms(struct drm_device *dev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 6 ------
 drivers/gpu/drm/radeon/radeon_drv.h | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index bb7b33e535f81..e0d664e9e2feb 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -112,12 +112,6 @@
 #define KMS_DRIVER_MAJOR	2
 #define KMS_DRIVER_MINOR	50
 #define KMS_DRIVER_PATCHLEVEL	0
-int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags);
-void radeon_driver_unload_kms(struct drm_device *dev);
-void radeon_driver_lastclose_kms(struct drm_device *dev);
-int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
-void radeon_driver_postclose_kms(struct drm_device *dev,
-				 struct drm_file *file_priv);
 int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 		       bool fbcon, bool freeze);
 int radeon_resume_kms(struct drm_device *dev, bool resume, bool fbcon);
diff --git a/drivers/gpu/drm/radeon/radeon_drv.h b/drivers/gpu/drm/radeon/radeon_drv.h
index 173deb4634146..ac7970919c4d3 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.h
+++ b/drivers/gpu/drm/radeon/radeon_drv.h
@@ -118,4 +118,11 @@
 long radeon_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg);
 
+int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags);
+void radeon_driver_unload_kms(struct drm_device *dev);
+void radeon_driver_lastclose_kms(struct drm_device *dev);
+int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
+void radeon_driver_postclose_kms(struct drm_device *dev,
+				 struct drm_file *file_priv);
+
 #endif				/* __RADEON_DRV_H__ */
-- 
2.25.1

