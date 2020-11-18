Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8062B7CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKRLkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:40:31 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:32218 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKRLka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:40:30 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 4AB874E237B;
        Wed, 18 Nov 2020 19:40:27 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bernard Zhao <bernard@vivo.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] drm/via: fix assignment in if condition
Date:   Wed, 18 Nov 2020 03:40:19 -0800
Message-Id: <20201118114021.105502-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHkpOHxpIShoZGUNCVkpNS05NQkJNSUxPSk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Lww*GT8eIw4KEUwuME9L
        EToKCUJVSlVKTUtOTUJCTUlMTEJPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUhKSDcG
X-HM-Tid: 0a75db27e9779376kuws4ab874e237b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix check_patch.pl warning:
ERROR: do not use assignment in if condition
+                       if ((HALCYON_HEADER2 == (cmd = *buf)) &&

ERROR: do not use assignment in if condition
+                       if (HALCYON_HEADER2 == (cmd = *buf))

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/via/via_verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/via/via_verifier.c b/drivers/gpu/drm/via/via_verifier.c
index 8d8135f424ef..3d6e3a70f318 100644
--- a/drivers/gpu/drm/via/via_verifier.c
+++ b/drivers/gpu/drm/via/via_verifier.c
@@ -1001,8 +1001,8 @@ via_verify_command_stream(const uint32_t * buf, unsigned int size,
 			state = via_check_vheader6(&buf, buf_end);
 			break;
 		case state_command:
-			if ((HALCYON_HEADER2 == (cmd = *buf)) &&
-			    supported_3d)
+			cmd = *buf;
+			if ((cmd == HALCYON_HEADER2) && supported_3d)
 				state = state_header2;
 			else if ((cmd & HALCYON_HEADER1MASK) == HALCYON_HEADER1)
 				state = state_header1;
@@ -1064,7 +1064,8 @@ via_parse_command_stream(struct drm_device *dev, const uint32_t *buf,
 			state = via_parse_vheader6(dev_priv, &buf, buf_end);
 			break;
 		case state_command:
-			if (HALCYON_HEADER2 == (cmd = *buf))
+			cmd = *buf;
+			if (cmd == HALCYON_HEADER2)
 				state = state_header2;
 			else if ((cmd & HALCYON_HEADER1MASK) == HALCYON_HEADER1)
 				state = state_header1;
-- 
2.29.0

