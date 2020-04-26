Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86AF1B9064
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDZNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 09:12:55 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:51384 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgDZNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:12:55 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id B18E64825F7;
        Sun, 26 Apr 2020 21:12:52 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/radeon: cleanup coding style a bit
Date:   Sun, 26 Apr 2020 06:12:44 -0700
Message-Id: <20200426131244.22293-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVLS0pCQkJDTk5LT0pOWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCo6Ojo6Kjg6NElCPhUIM01K
        GjIwC0lVSlVKTkNMQktNTExJQkJLVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSkJKSzcG
X-HM-Tid: 0a71b69e7faf93bakuwsb18e64825f7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe no need to check ws before kmalloc, kmalloc will check
itself, kmalloc`s logic is if ptr is NULL, kmalloc will just
return

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/radeon/atom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
index 2c27627b6659..f15b20da5315 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -1211,8 +1211,7 @@ static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32
 	SDEBUG("<<\n");
 
 free:
-	if (ws)
-		kfree(ectx.ws);
+	kfree(ectx.ws);
 	return ret;
 }
 
-- 
2.26.2

