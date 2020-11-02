Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC522A2C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKBOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:18:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50319 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBOQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:16:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kZadj-0002eD-1h; Mon, 02 Nov 2020 14:16:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: fix spelling mistake: "Successed" -> "Succeeded"
Date:   Mon,  2 Nov 2020 14:16:54 +0000
Message-Id: <20201102141654.699468-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a deb_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 28a5c0d21b71..c99c2180785f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -296,7 +296,7 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 		if (drm_mm_reserve_node(mm, &rsv->mm_node))
 			continue;
 
-		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Successed\n",
+		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->mm_node.start, rsv->mm_node.size);
 
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
-- 
2.27.0

