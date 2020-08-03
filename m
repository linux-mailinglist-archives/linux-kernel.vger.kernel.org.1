Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D636E239DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 05:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHCDqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 23:46:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgHCDqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:46:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 89B10F024055EBB9AACB;
        Mon,  3 Aug 2020 11:45:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 11:45:52 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jingxiangfeng@huawei.com>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/nouveau/acr: fix a coding style in nvkm_acr_lsfw_load_bl_inst_data_sig()
Date:   Mon, 3 Aug 2020 11:48:27 +0800
Message-ID: <20200803034827.100685-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch performs the following changes:
1. remove a redundant parentheses around the  nvkm_acr_lsfw_add() calls
2. do assignment before this if condition, it is more readable

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
index 07d1830126ab..5f6006418472 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
@@ -191,7 +191,8 @@ nvkm_acr_lsfw_load_bl_inst_data_sig(struct nvkm_subdev *subdev,
 	u32 *bldata;
 	int ret;
 
-	if (IS_ERR((lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id))))
+	lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id);
+	if (IS_ERR(lsfw))
 		return PTR_ERR(lsfw);
 
 	ret = nvkm_firmware_load_name(subdev, path, "bl", ver, &bl);
-- 
2.17.1

