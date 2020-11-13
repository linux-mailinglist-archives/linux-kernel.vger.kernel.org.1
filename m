Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA62B1A70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKMMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:02:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53199 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgKMMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:02:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kdXlZ-0005bg-Pk; Fri, 13 Nov 2020 12:01:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/kmb: fix array out-of-bounds writes to kmb->plane_status[]
Date:   Fri, 13 Nov 2020 12:01:21 +0000
Message-Id: <20201113120121.33212-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Writes to elements in the kmb->plane_status array in function
kmb_plane_atomic_disable are overrunning the array when plane_id is
more than 1 because currently the array is KMB_MAX_PLANES elements
in size and this is currently #defined as 1.  Fix this by defining
KMB_MAX_PLANES to 4.

Addresses-Coverity: ("Out-of-bounds write")
Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/kmb/kmb_plane.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.h b/drivers/gpu/drm/kmb/kmb_plane.h
index 486490f7a3ec..6f43a7ae3de6 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.h
+++ b/drivers/gpu/drm/kmb/kmb_plane.h
@@ -43,7 +43,7 @@ enum layer_id {
 	/* KMB_MAX_PLANES */
 };
 
-#define KMB_MAX_PLANES 1
+#define KMB_MAX_PLANES 4
 
 enum sub_plane_id {
 	Y_PLANE,
-- 
2.28.0

