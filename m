Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01369297465
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461334AbgJWQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465614AbgJWQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:47 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0995824650;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=7iRzQ9FtMsadAedSe/m2uOK3R6zBKK4pf/UOJjIXzSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9bVYwE0o0a8LN7uh4+1n3trMwTK0TzBs5XIDE/GHyJ+yYLMS2ykoVUYaDMcPT9YT
         bn0sDLBPPJU1FlzBSfN6ERJkpzpFLjUlpMDygHLcHPy+nfKAXR40qmpeeTAPCmHpX6
         jwaLVhKBQKlbFBGv2a6tubPlWT4lYOwiJ3Qp5j0U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002AvU-Oy; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/56] drm: drm_print.h: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:51 +0200
Message-Id: <4db302f77c0cc05b34cfb7ec51b5aef258b94b99.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel-doc markup should start with the identifier on its
first line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/drm/drm_print.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 1c9417430d08..f32d179e139d 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -338,7 +338,7 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 		 const char *format, ...);
 
 /**
- * Error output.
+ * DRM_DEV_ERROR() - Error output.
  *
  * @dev: device pointer
  * @fmt: printf() like format string.
@@ -347,10 +347,12 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
 
 /**
- * Rate limited error output.  Like DRM_ERROR() but won't flood the log.
+ * DRM_DEV_ERROR_RATELIMITED() - Rate limited error output.
  *
  * @dev: device pointer
  * @fmt: printf() like format string.
+ *
+ * Like DRM_ERROR() but won't flood the log.
  */
 #define DRM_DEV_ERROR_RATELIMITED(dev, fmt, ...)			\
 ({									\
@@ -375,15 +377,27 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 })
 
 /**
- * Debug output.
+ * DRM_DEV_DEBUG() - Debug output for generic drm code
  *
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
 #define DRM_DEV_DEBUG(dev, fmt, ...)					\
 	drm_dev_dbg(dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
+/**
+ * DRM_DEV_DEBUG_DRIVER() - Debug output for vendor specific part of the driver
+ *
+ * @dev: device pointer
+ * @fmt: printf() like format string.
+ */
 #define DRM_DEV_DEBUG_DRIVER(dev, fmt, ...)				\
 	drm_dev_dbg(dev, DRM_UT_DRIVER,	fmt, ##__VA_ARGS__)
+/**
+ * DRM_DEV_DEBUG_KMS() - Debug output for modesetting code
+ *
+ * @dev: device pointer
+ * @fmt: printf() like format string.
+ */
 #define DRM_DEV_DEBUG_KMS(dev, fmt, ...)				\
 	drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
 
-- 
2.26.2

