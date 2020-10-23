Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBCC2974A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbgJWQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbgJWQdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F227221F9;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=HaCfxqyru0DdcvC8IaqpPspuh924AuGj1WtdVq8zJZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4u0q4IZh/fVnK0DQVa8udilBLYSvmcPcVj9YoqkpECy4Q26duLXO1rS9QT8e13j2
         nSc+IYl2c3Gn0gwt3LzZb1Vf+2Z0Ww4LZjptK0MtlpeaLbMxEqhX1ZKmRohBYy9w+K
         onztKpMQAA+Qh61vlEWPpi+2XtgCepQoxxuRVo+Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002Avj-1O; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bernard Zhao <bernard@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob He <jacob.he@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH v3 11/56] drm/amdgpu: fix some kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:58 +0200
Message-Id: <ffc1f2d59fd5005f365eb5d178a2d890112bb6bb.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 include/uapi/drm/amdgpu_drm.h                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index df110afa97bf..a5f73a267fe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2166,7 +2166,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 
 
 /**
- * amdgpu_vm_bo_insert_mapping - insert a new mapping
+ * amdgpu_vm_bo_insert_map - insert a new mapping
  *
  * @adev: amdgpu_device pointer
  * @bo_va: bo_va to store the address
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 0c6b7c5ecfec..795bad307497 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -528,7 +528,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
+ * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
  *
  * @adev: amdgpu device pointer
  * @sgt: sg table to free
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c5ff2b275fcd..791a1d597d2a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -667,7 +667,7 @@ struct drm_amdgpu_cs_chunk_data {
 	};
 };
 
-/**
+/*
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
  */
-- 
2.26.2

