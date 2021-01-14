Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F592F5C20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbhANIHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbhANIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB99823A56;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=3L3VSinaQV9/6wu4p400uD1amdFzsglY2QC0uVTTqUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2lFIy8ETL8fZ9yUfZ3GD9Med6hNEOB9E9l/8pU6hADeHiU0u9D27nczLHKgnywG8
         hRz6LQ51tA79iHTO056IdFECyy/O3U+jmalvlbifS1Pk6zZb8UIDNPK1Bc/p8Z9pqL
         L0ZRGASxvkNcLuEJX2jDiBJYOW/mt5PRigHoyt6RaXPy3VZOVMDvMd3UA4WCmDyz5i
         QkMSs8CuevceyizAEqO+cyicQPhbnxq2TN5kNSab06SEtrloyrvf0gnZO+VyOdPhwb
         Tb9ENkCey+xFc3b7w3IVWiF50puzBhYcQ/OmibnpauIXLujdPlnj7YQVEpfmMTpK/H
         v06KihDjIFqGQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ72-GG; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/16] drm: drm_crc: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:51 +0100
Message-Id: <2439fb6713e9b2aa27a81f3269a4b0e8e7dfcd36.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup:

	../include/drm/drm_crtc.h:1257: warning: expecting prototype for drm_crtc_alloc_with_planes(). Prototype was for drmm_crtc_alloc_with_planes() instead

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/drm/drm_crtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 540e2e43ec93..13eeba2a750a 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1232,7 +1232,7 @@ void *__drmm_crtc_alloc_with_planes(struct drm_device *dev,
 				    const char *name, ...);
 
 /**
- * drm_crtc_alloc_with_planes - Allocate and initialize a new CRTC object with
+ * drmm_crtc_alloc_with_planes - Allocate and initialize a new CRTC object with
  *    specified primary and cursor planes.
  * @dev: DRM device
  * @type: the type of the struct which contains struct &drm_crtc
-- 
2.29.2

