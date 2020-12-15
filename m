Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190BF2DAF29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgLOOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbgLOOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CA11H/hjEhbgy7tnphG2KLHb+jmHcRmnL5DLgtJD9b0=;
        b=FKq3QcrWNk9WY7t7ZvZCohaGGoozCCzYonO0hE8GfrcTO9/jo/yk8uiUb7E0EbS3P5hQbr
        qDQIb9ZbOTnRzN12Rse/jfTbznJTD9LRyOrvW3ySEsq9jgyQtgSjZE9qEUaS/x1J+e4/xd
        pPnxnde8ujXur2LGCxAWR01Ke9Udy8E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-o-FmcXgtN9Ghb-ZG-xPydQ-1; Tue, 15 Dec 2020 09:38:45 -0500
X-MC-Unique: o-FmcXgtN9Ghb-ZG-xPydQ-1
Received: by mail-qv1-f71.google.com with SMTP id y4so8504738qvk.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CA11H/hjEhbgy7tnphG2KLHb+jmHcRmnL5DLgtJD9b0=;
        b=ioYvURwUOs9BLpTWApztPSsYyL88uhiq4bwLW02RWKeCwVZU3qeOqDu0GkQTxjmIjB
         +OqhPnjJrTNBslVslnczBWDe2FXizwUO2v6S7osGa1eCaroJBdNEYDxWh43p2Nkt/DyB
         DaZQwgIye6Xus9+N7dJOt+WORwkcBWoCs55cIAYq/oL2PHZSwyn3EjDT6i3/BpJnoGxM
         2qDn7irIq90phylPPq9rjVYBRkEcUWF8ZuOYZKhIQzswzGMPzcyZ7M9wkt84E8WQtKfI
         ec+3tiqGoHs/C1+AupHaSYx4HxjdV+RHBLMD3WbReoJvAS/lu5k58ABTppE7D9VA0i9z
         Ct/Q==
X-Gm-Message-State: AOAM530ZCllDt+zB6m1pXiaRtPLloR8xJIp248CimhxJPidlLZT5pWop
        uqri+hkCoQxbhA+1c7c8UC/UfNTWYVDEA4gXd0Hi3RSLN7E0B5l+T6XN2ReIl8zs013c7TnEkW0
        Kt6znt9wAS6W/p4HHB3ckd+g5
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr38380271qtv.56.1608043124634;
        Tue, 15 Dec 2020 06:38:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv/jCdfHqYOSQUF3qGweRu3h36fTJyA9ZrWvPOpg/YPfe7jHGmISC3hdRzS09ANHjuNAsAYg==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr38380257qtv.56.1608043124444;
        Tue, 15 Dec 2020 06:38:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m10sm16456643qtg.52.2020.12.15.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:38:43 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, lee.jones@linaro.org,
        Felix.Kuehling@amd.com, nirmoy.das@amd.com, sonny.jiang@amd.com,
        xinhui.pan@amd.com, colin.king@canonical.com, James.Zhu@amd.com,
        leo.liu@amd.com, thong.thai@amd.com, vegopala@amd.com,
        boyuan.zhang@amd.com, Monk.Liu@amd.com, mh12gx2825@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:38:35 -0800
Message-Id: <20201215143835.1874487-1-trix@redhat.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 7c5b60e53482..8b989670ed66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -240,7 +240,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu\n",
+		DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
 			version_major, version_minor, family_id);
 
 		/*
@@ -267,7 +267,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		dec_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
 		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 24) & 0x3f;
 		enc_major = (le32_to_cpu(hdr->ucode_version) >> 30) & 0x3;
-		DRM_INFO("Found UVD firmware ENC: %hu.%hu DEC: .%hu Family ID: %hu\n",
+		DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
 			enc_major, enc_minor, dec_minor, family_id);
 
 		adev->uvd.max_handles = AMDGPU_MAX_UVD_HANDLES;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 4861f8ddc1b5..ea6a62f67e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -179,7 +179,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 	version_major = (ucode_version >> 20) & 0xfff;
 	version_minor = (ucode_version >> 8) & 0xfff;
 	binary_id = ucode_version & 0xff;
-	DRM_INFO("Found VCE firmware Version: %hhd.%hhd Binary ID: %hhd\n",
+	DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
 		version_major, version_minor, binary_id);
 	adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
 				(binary_id << 8));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 1e756186e3f8..99b82f3c2617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -181,7 +181,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		enc_major = fw_check;
 		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
 		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
-		DRM_INFO("Found VCN firmware Version ENC: %hu.%hu DEC: %hu VEP: %hu Revision: %hu\n",
+		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
 			enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
 		unsigned int version_major, version_minor, family_id;
@@ -189,7 +189,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found VCN firmware Version: %hu.%hu Family ID: %hu\n",
+		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
 			version_major, version_minor, family_id);
 	}
 
-- 
2.27.0

