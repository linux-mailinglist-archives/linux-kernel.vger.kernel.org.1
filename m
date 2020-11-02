Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30052A2338
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgKBDHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:07:45 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:50023 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgKBDHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:07:45 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id DF9D3482ACC;
        Mon,  2 Nov 2020 11:07:42 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] gpu/drm: delete same check in if condition
Date:   Sun,  1 Nov 2020 19:07:36 -0800
Message-Id: <20201102030736.3833-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSk5KSU9MSx5NT0JKVkpNS09JQ01PTUhLQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6Qzo5Fj8YNyEUMywDEiw5
        DSpPCTVVSlVKTUtPSUNNT01ITkpMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUpCTko3Bg++
X-HM-Tid: 0a7586ecbc3693bakuwsdf9d3482acc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function drm_bridge_connector_get_modes_edid, drm_edid_is_valid
will check weather (!edid), no need to check again in the if
branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/drm_bridge_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index a58cbde59c34..791379816837 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -241,7 +241,7 @@ static int drm_bridge_connector_get_modes_edid(struct drm_connector *connector,
 		goto no_edid;
 
 	edid = bridge->funcs->get_edid(bridge, connector);
-	if (!edid || !drm_edid_is_valid(edid)) {
+	if (!drm_edid_is_valid(edid)) {
 		kfree(edid);
 		goto no_edid;
 	}
-- 
2.29.0

