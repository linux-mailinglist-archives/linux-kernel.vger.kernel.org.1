Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794812D7270
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437165AbgLKI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:59:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9166 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437267AbgLKI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:58:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Csl5h27xpz15YSc;
        Fri, 11 Dec 2020 16:56:56 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:57:22 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-graphics-maintainer@vmware.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] gpu: drm: vmwgfx: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:57:51 +0800
Message-ID: <20201211085751.3089-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e67e2e8f6e6f..537c48eff197 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2509,7 +2509,7 @@ static int vmw_cmd_dx_set_so_targets(struct vmw_private *dev_priv,
 
 		binding.bi.ctx = ctx_node->ctx;
 		binding.bi.res = res;
-		binding.bi.bt = vmw_ctx_binding_so_target,
+		binding.bi.bt = vmw_ctx_binding_so_target;
 		binding.offset = cmd->targets[i].offset;
 		binding.size = cmd->targets[i].sizeInBytes;
 		binding.slot = i;
-- 
2.22.0

