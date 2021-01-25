Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3E3037C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbhAZIVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 03:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbhAYSm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:42:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8421B22B3F;
        Mon, 25 Jan 2021 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611600079;
        bh=5WUoD5zwsd4RXHHGhCQkpJlGUZLtx2s2ZRLAwnOOOLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOhkNBC+D0fYkV+aNm7TOg9iSkDMyA+2QUueY5Yy0ZJ6lU3VptAiuz6a3zrCjkjOD
         gDocoAbc1MnH/hfHmGi14V7YBQL44yRs7PKW0VQG8pFciam1rkItUHCKnX/8E9Og+7
         uQv4xhIwnEvnEFAzgyIqGXdatiURunYufznuMMGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/58] drm/nouveau/mmu: fix vram heap sizing
Date:   Mon, 25 Jan 2021 19:39:23 +0100
Message-Id: <20210125183157.652797542@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125183156.702907356@linuxfoundation.org>
References: <20210125183156.702907356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit add42781ad76c5ae65127bf13852a4c6b2f08849 ]

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
index ee11ccaf0563c..cb51e248cb41b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
@@ -316,9 +316,9 @@ nvkm_mmu_vram(struct nvkm_mmu *mmu)
 {
 	struct nvkm_device *device = mmu->subdev.device;
 	struct nvkm_mm *mm = &device->fb->ram->vram;
-	const u32 sizeN = nvkm_mm_heap_size(mm, NVKM_RAM_MM_NORMAL);
-	const u32 sizeU = nvkm_mm_heap_size(mm, NVKM_RAM_MM_NOMAP);
-	const u32 sizeM = nvkm_mm_heap_size(mm, NVKM_RAM_MM_MIXED);
+	const u64 sizeN = nvkm_mm_heap_size(mm, NVKM_RAM_MM_NORMAL);
+	const u64 sizeU = nvkm_mm_heap_size(mm, NVKM_RAM_MM_NOMAP);
+	const u64 sizeM = nvkm_mm_heap_size(mm, NVKM_RAM_MM_MIXED);
 	u8 type = NVKM_MEM_KIND * !!mmu->func->kind;
 	u8 heap = NVKM_MEM_VRAM;
 	int heapM, heapN, heapU;
-- 
2.27.0



