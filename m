Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4692B894F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKSBL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:11:56 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:22424 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgKSBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:11:56 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id EE3DD4E1403;
        Thu, 19 Nov 2020 09:11:52 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm/vmwgfx: use min_t to replace min
Date:   Wed, 18 Nov 2020 17:11:46 -0800
Message-Id: <20201119011146.107587-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTk5NQhhJQktMTxhCVkpNS05MT0NISkhKQ0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Fio5FT8dSg5NMAwiNQg6
        PEoaCx9VSlVKTUtOTE9DSEpITUhPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSUhPTTcG
X-HM-Tid: 0a75de0ecc1f9376kuwsee3dd4e1403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use min_t to replace min, min_t is a bit fast because min use
twice typeof.
This patch also fix check_patch.pl warning:
WARNING: min() should probably be min_t(unsigned long, num_pages,
VMW_PPN_PER_REMAP)
+unsigned long nr = min(num_pages, (unsigned long)
VMW_PPN_PER_REMAP);

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes since V1:
*fix compile error reported by kernel test robot

Link for V1:
*https://lore.kernel.org/patchwork/patch/1340996/
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c
index 83c0d5a3e4fd..525d5e1227e8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c
@@ -72,7 +72,7 @@ static int vmw_gmr2_bind(struct vmw_private *dev_priv,
 		SVGA_REMAP_GMR2_PPN64 : SVGA_REMAP_GMR2_PPN32;
 
 	while (num_pages > 0) {
-		unsigned long nr = min(num_pages, (unsigned long)VMW_PPN_PER_REMAP);
+		unsigned long nr = min_t(unsigned long, num_pages, VMW_PPN_PER_REMAP);
 
 		remap_cmd.offsetPages = remap_pos;
 		remap_cmd.numPages = nr;
-- 
2.29.0

