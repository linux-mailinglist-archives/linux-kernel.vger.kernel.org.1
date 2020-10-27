Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB729A863
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896178AbgJ0JwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896067AbgJ0Jvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:44 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0A52467D;
        Tue, 27 Oct 2020 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792302;
        bh=5vDvj3oyzh1Zm3XZyqT4S1ZktLUHAAkzgfhs/XvhF0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kbv2wrvY2jihYBFGLE/Yg2vUUrX9J+UvwwK/VyhCFicXCGFnq+GSYdX/esugtNTzl
         zX6G5mvSt5TB+EkFXs6iJjUWGuTWpT3NL5r/ueNsMC0QXe0VjWufFf2zG3JliuDKS9
         g8GrpxFmK1GH/pPBjsLqyj/CaawGPgt6WOnrBxSk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FFn-VV; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Dennis Li <Dennis.Li@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/32] amdgpu: fix a few kernel-doc markup issues
Date:   Tue, 27 Oct 2020 10:51:34 +0100
Message-Id: <e899f50404e94ac9a7c3267dd34f951c1a44fb2b.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel-doc markup can't be mixed with a random comment,
as it causes parsing problems.

While here, change an invalid kernel-doc markup into
a common comment.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 641c039150eb..5dbe93fe884c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -239,9 +239,11 @@ bool amdgpu_device_supports_baco(struct drm_device *dev)
 	return amdgpu_asic_supports_baco(adev);
 }
 
+/*
+ * VRAM access helper functions
+ */
+
 /**
- * VRAM access helper functions.
- *
  * amdgpu_device_vram_access - read/write a buffer in vram
  *
  * @adev: amdgpu_device pointer
@@ -4497,7 +4499,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 
-	/**
+	/*
 	 * Special case: RAS triggered and full reset isn't supported
 	 */
 	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
-- 
2.26.2

