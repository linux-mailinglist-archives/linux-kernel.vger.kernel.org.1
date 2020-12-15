Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89322DAF39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgLOOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729150AbgLOOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kaTetupLyuYrqzsX7UwEN39ZooQ2px2nX3T94IUgkoc=;
        b=PAAb3gxWAm0bhp+k0Dwaucy8ComIi7C4cVoOuV0bxpzhlrqHygnEBh9FYo5Bc9A2JNEAIt
        U6mBLd/MiMUI6DxgiGp6Xq328TyCIIMX1r7gvfT1eyj1IAJncuRQucAFgkBjso+88DxmmR
        Z6KcQdZX5lvniKP3FBAo6A4Id0X9ODM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-8Ap9ZSOlMrq0fdV2XYzcKw-1; Tue, 15 Dec 2020 09:42:41 -0500
X-MC-Unique: 8Ap9ZSOlMrq0fdV2XYzcKw-1
Received: by mail-qk1-f200.google.com with SMTP id n137so10296386qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kaTetupLyuYrqzsX7UwEN39ZooQ2px2nX3T94IUgkoc=;
        b=h5sCulG6Xa3WkWxUw+9wePg4vxtd6+GjGIUCsZfaS2+zEwr6I9xaqhCs31FBxh0UOY
         APmP1y3mCFVcMQ1GQz258gnMsG32CinamepJGrDl34clhNfOHsiwj05ZN0VSog2Gqech
         92XIw+pvw0d5tkL40n7FKII0TVx5WASFlVMm7ylgldT3GFsF82RVTMEjmjmzVKJgBg6z
         UB836b9ztuP53EIDEIKnLdZIDkm5G0AQH5SEOpiMCgC+Ehc8IxIgyegaRj0iwxW8+RcP
         nz6aAPJhXdXzgFm7wf7653ZBtwFwN09BpQghfu0hLn1a4+CPWpZlpcqVkhsp9aH+5Dfw
         v4OA==
X-Gm-Message-State: AOAM532JH6MsCdvOWyiyh4fz7sutzIyDGzQgDkz9HUoYi8pTZtPN91WF
        LgYkPo6zWM2nhMxcwcR7UXH/XTWA/pF5VhNnn1ReYIl1uD/ZoYQrrRX99D/88/TDfpa5D9Mxl3e
        xVp9VsITAMOoSVsUZOssXoANW
X-Received: by 2002:ac8:5c13:: with SMTP id i19mr38740568qti.250.1608043353967;
        Tue, 15 Dec 2020 06:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfIuT11JaKaKkZRsbteafZAH9wJ/RUSSqFrn3oRILtxKd8WAilaGcx6jRbNvgnaQ2aFZrBFw==
X-Received: by 2002:ac8:5c13:: with SMTP id i19mr38740349qti.250.1608043349158;
        Tue, 15 Dec 2020 06:42:29 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 193sm5726550qkj.105.2020.12.15.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:42:28 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:42:23 -0800
Message-Id: <20201215144223.1881097-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_uvd.c | 2 +-
 drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 57fb3eb3a4b4..39c1c339be7b 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -155,7 +155,7 @@ int radeon_uvd_init(struct radeon_device *rdev)
 			family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 			version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 			version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-			DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu\n",
+			DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
 				 version_major, version_minor, family_id);
 
 			/*
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 5e8006444704..a450497368b2 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -122,7 +122,7 @@ int radeon_vce_init(struct radeon_device *rdev)
 	if (sscanf(c, "%2u]", &rdev->vce.fb_version) != 1)
 		return -EINVAL;
 
-	DRM_INFO("Found VCE firmware/feedback version %hhd.%hhd.%hhd / %d!\n",
+	DRM_INFO("Found VCE firmware/feedback version %d.%d.%d / %d!\n",
 		 start, mid, end, rdev->vce.fb_version);
 
 	rdev->vce.fw_version = (start << 24) | (mid << 16) | (end << 8);
-- 
2.27.0

