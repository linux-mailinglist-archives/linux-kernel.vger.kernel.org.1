Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA84029FC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3D3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ3D3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:29:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:29:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so4068835pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kNFigGmlnT8RRi6z0sCPMt5Zg63u/lv6a6WCx8xI9/k=;
        b=mq0/8Qy7Ve6u00MU6iGI3ZON19U0Xh/nF42bdR7N8KoIOexf6e9uuP1lJ7aPL9gxUF
         /6hU8zFSrMi6wE7MgmKYzth/P3AAHrFx3hiCLQqn74BJsqXoEznfDAxOU5bUjLpHiriW
         +xvNTLfTgQB/aH1BCeDHWPLsRnuRkZqcguv6AiS45T+8S70dPK3t9d1Z5D89aEvbA36h
         SSN0kZRpx6bb/PIB4Mg9d0IvpLH3k8tMjtCqBHy9vjRtvysTEcMkFXvrsqVhBh/S1tVI
         a9I2R3URX8Eno+U2bihtbF7TL09mAfmAwplYxtkDUuWuhZ8HRtLZLiCIVNjSul1ss+1T
         towA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kNFigGmlnT8RRi6z0sCPMt5Zg63u/lv6a6WCx8xI9/k=;
        b=aw7vbBYtvpgxwzpvikegqNU6ZEmOKUsqvcjqwy01C8NPKtA+KhHdSonqyncr7muVFx
         SgKWNSm8ohmlbL2hVuNOe8WdLwyUXuoemJ4GYSGfhHPs7rSLzSs/YtXCHvfLkx3bBEFr
         DIZDoU3RGpcqpff/71NlDt1ev+V9Su7qypqcHxEgIIyaYk9tpUnyPcDV3KFp1Nf9jjiW
         AW+EMkLvnUcsARXnl/7Qdu+SDV7/y/2J72JJqkciMyC9yTKFte5N/a/3jhvE73H+2pSd
         idwLaNXvDI4jaIWshRcSeg1FNvbV6jv1jhQReVeaPTESWSemipPL9XcalsQ6zDr9QsXI
         y2qg==
X-Gm-Message-State: AOAM531ZXCmxtbL5LE86c1Jl3UIH6PBKCm9v8R4nkDg0pHjNqO2VkDu5
        ZFxh+mDFPWEw2MXTwoEnKOg=
X-Google-Smtp-Source: ABdhPJwIVMjw39qjT1TY0hYU+IjXwoIA0G3zsE2DQwL6bJLjQU34JC8Hiwe282UUBVpaiq3XeYJhvQ==
X-Received: by 2002:a63:c053:: with SMTP id z19mr393466pgi.418.1604028592566;
        Thu, 29 Oct 2020 20:29:52 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id b16sm220933pju.16.2020.10.29.20.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:29:52 -0700 (PDT)
Date:   Fri, 30 Oct 2020 08:59:45 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH] drm/i915/gvt: use DEFINE_DEBUGFS_ATTRIBUTE with
 debugfs_create_file_unsafe()
Message-ID: <20201030032945.GA274850@my--box>
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

 drivers/gpu/drm/i915/gvt/debugfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
index 62e6a14ad58e..18adfa2d5f5b 100644
--- a/drivers/gpu/drm/i915/gvt/debugfs.c
+++ b/drivers/gpu/drm/i915/gvt/debugfs.c
@@ -147,9 +147,8 @@ vgpu_scan_nonprivbb_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vgpu_scan_nonprivbb_fops,
-			vgpu_scan_nonprivbb_get, vgpu_scan_nonprivbb_set,
-			"0x%llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vgpu_scan_nonprivbb_fops, vgpu_scan_nonprivbb_get,
+			 vgpu_scan_nonprivbb_set, "0x%llx\n");
 
 /**
  * intel_gvt_debugfs_add_vgpu - register debugfs entries for a vGPU
@@ -165,8 +164,8 @@ void intel_gvt_debugfs_add_vgpu(struct intel_vgpu *vgpu)
 	debugfs_create_bool("active", 0444, vgpu->debugfs, &vgpu->active);
 	debugfs_create_file("mmio_diff", 0444, vgpu->debugfs, vgpu,
 			    &vgpu_mmio_diff_fops);
-	debugfs_create_file("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
-			    &vgpu_scan_nonprivbb_fops);
+	debugfs_create_file_unsafe("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
+				   &vgpu_scan_nonprivbb_fops);
 }
 
 /**
-- 
2.25.1

