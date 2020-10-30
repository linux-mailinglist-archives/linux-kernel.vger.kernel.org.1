Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE329FC21
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgJ3DW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJ3DWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:22:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB922C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:22:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y14so4049519pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qBvjZd1NQE+Opu2oXBohKdYFGkxmEuNNU11hjYVYnCQ=;
        b=Mj33b48h76F1dSMxppcMSK6G6p3jotJKxzTrYojGUxfEpvhTrFPdTY+HPZoV2gq4oJ
         h+0vUFVO+e7BWDVQgOVC+R2T284CGbNoAAo+6ZYFsnOjZml55tKAFQ78cH3A15oJEZVG
         mrujRZtGJyCFgMx3FPZyX51iESlyui7nGtxqcddwonAsLZgt8dav4aFYBqgk71eEFUzL
         n2dOdvx+xZU5afm/QgSBfDbLIW7cbGz77YROOkiUFUc9acef+jknLNCe4n+Fc/2MIj3L
         iq760Cb4WVXRxzHf61KnVYP4HVfscx/HGeX/hkGimxhD2UZcbmv6WlkH5dxV34/JJVP3
         LIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qBvjZd1NQE+Opu2oXBohKdYFGkxmEuNNU11hjYVYnCQ=;
        b=Y5lIL7YIuTRMA44w079Pm3y3I/fKZ870g7xEP7aG5nnSrLMAIv8jQzWkQk7/WSQHQA
         zGIPgOO4pW9ckCzZr/b6snrEaCQlSq+fAMExLre5JagOVapYkzCPyc0OW1/vFDXyG3w+
         3oiGPGZXpO/LIfNq3Cur/MGlIVdEX1el8bIfq/HXYvQyGkWmHzLJwRU0r/1izvfpjfAV
         jLielWT6xML6nBldIjQvZ0Db6jkMRHgkJuXckp/Z6s9h+si/YUt1eXSB5IlDoysk8RvC
         6lVmxQ3vhZStyI4EIyyrQl5mOAJ+DnRg+IP1f2qsdkiWq2dqhazq4zTr1sk1TJexPcTl
         nG5A==
X-Gm-Message-State: AOAM532qi31sEmCYEZ2PlDOr8hiwmoe1KUZlJKXQho89Jk6/HOB0wUeY
        5PRggWDM+fsId1ULXqTx5X3dudy8KI4=
X-Google-Smtp-Source: ABdhPJyrvqLEAX4zvr4eTeY6PHbOJQStYG9uu59XSfJnfnWLOEyPgXFp1yJk3y8FgbIJaX3YgghUYw==
X-Received: by 2002:a63:ec57:: with SMTP id r23mr374312pgj.257.1604028172484;
        Thu, 29 Oct 2020 20:22:52 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id 92sm1313206pjv.32.2020.10.29.20.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:22:51 -0700 (PDT)
Date:   Fri, 30 Oct 2020 08:52:45 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH] drm/amdgpu: use DEFINE_DEBUGFS_ATTRIBUTE with
 debugfs_create_file_unsafe()
Message-ID: <20201030032245.GA274478@my--box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
function in place of the debugfs_create_file() function will make the
file operation struct "reset" aware of the file's lifetime. Additional
details here: https://lists.archive.carbon60.com/linux/kernel/2369498

Issue reported by Coccinelle script:
scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Please Note: This is a Outreachy project task patch.

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2d125b8b15ee..f076b1ba7319 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
-			amdgpu_debugfs_ib_preempt, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
+			 amdgpu_debugfs_ib_preempt, "%llu\n");
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
-			amdgpu_debugfs_sclk_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
+			 amdgpu_debugfs_sclk_set, "%llu\n");
 
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	int r, i;
 
 	adev->debugfs_preempt =
-		debugfs_create_file("amdgpu_preempt_ib", 0600,
-				    adev_to_drm(adev)->primary->debugfs_root, adev,
-				    &fops_ib_preempt);
+		debugfs_create_file_unsafe("amdgpu_preempt_ib", 0600,
+					   adev_to_drm(adev)->primary->debugfs_root, adev,
+					   &fops_ib_preempt);
 	if (!(adev->debugfs_preempt)) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
 		return -EIO;
 	}
 
 	adev->smu.debugfs_sclk =
-		debugfs_create_file("amdgpu_force_sclk", 0200,
-				    adev_to_drm(adev)->primary->debugfs_root, adev,
-				    &fops_sclk_set);
+		debugfs_create_file_unsafe("amdgpu_force_sclk", 0200,
+					   adev_to_drm(adev)->primary->debugfs_root, adev,
+					   &fops_sclk_set);
 	if (!(adev->smu.debugfs_sclk)) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
 		return -EIO;
-- 
2.25.1

