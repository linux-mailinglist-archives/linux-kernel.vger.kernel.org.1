Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADE26D104
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIQCOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 22:14:24 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:15083 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:14:23 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:14:23 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id D1D7F4E15CF;
        Thu, 17 Sep 2020 10:04:41 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drm: fix spelling error in comments
Date:   Thu, 17 Sep 2020 10:04:32 +0800
Message-Id: <1600308275-32094-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUMYTB5KTx9KHU0aVkpNS0tIS0NJQ0lJQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6Nhw*Fj8tNBQsPTEUUTcf
        ITkaCRZVSlVKTUtLSEtDSUNJTExIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKTEhONwY+
X-HM-Tid: 0a7499ce83409376kuwsd1d7f4e15cf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the comment typo: "manger" -> "manager".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/drm/drm_mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mm.h b/include/drm/drm_mm.h
index a01bc6f..9b4292f
--- a/include/drm/drm_mm.h
+++ b/include/drm/drm_mm.h
@@ -338,7 +338,7 @@ static inline u64 drm_mm_hole_node_end(const struct drm_mm_node *hole_node)
 
 /**
  * drm_mm_nodes - list of nodes under the drm_mm range manager
- * @mm: the struct drm_mm range manger
+ * @mm: the struct drm_mm range manager
  *
  * As the drm_mm range manager hides its node_list deep with its
  * structure, extracting it looks painful and repetitive. This is
-- 
2.7.4

