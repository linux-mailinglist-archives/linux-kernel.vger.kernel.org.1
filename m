Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B552B7C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgKRLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:13:40 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:31969 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgKRLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:13:39 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 276954E1771;
        Wed, 18 Nov 2020 19:13:34 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/vmwgfx: use min_t to replace min
Date:   Wed, 18 Nov 2020 03:13:27 -0800
Message-Id: <20201118111327.105071-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0tMHk0dQx5CQhhNVkpNS05NQkNLSk9PT0tVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6MSo5Tz8tLw4vPxMYVh4O
        PzIaFC9VSlVKTUtOTUJDS0pOS0tLVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSUtDSjcG
X-HM-Tid: 0a75db0f4c5b9376kuws276954e1771
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
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c
index 83c0d5a3e4fd..b8f6fe1a71e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c
@@ -72,7 +72,7 @@ static int vmw_gmr2_bind(struct vmw_private *dev_priv,
 		SVGA_REMAP_GMR2_PPN64 : SVGA_REMAP_GMR2_PPN32;
 
 	while (num_pages > 0) {
-		unsigned long nr = min(num_pages, (unsigned long)VMW_PPN_PER_REMAP);
+		unsigned long nr = min_t((unsigned long), num_pages, VMW_PPN_PER_REMAP);
 
 		remap_cmd.offsetPages = remap_pos;
 		remap_cmd.numPages = nr;
-- 
2.29.0

