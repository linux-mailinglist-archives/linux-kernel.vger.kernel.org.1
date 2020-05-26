Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B611C8009
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 04:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgEGCeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 22:34:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3873 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbgEGCeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:34:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C4A5C3702A39DD0C0203;
        Thu,  7 May 2020 10:34:03 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 10:33:56 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Samuel Zou" <zou_wei@huawei.com>
Subject: [PATCH -next] drm/ast: Make ast_primary_plane_helper_atomic_update static
Date:   Thu, 7 May 2020 10:40:06 +0800
Message-ID: <1588819206-11406-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/gpu/drm/ast/ast_mode.c:564:6: warning:
symbol 'ast_primary_plane_helper_atomic_update'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 7062bcd..4ddf770 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -561,8 +561,9 @@ static int ast_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	return 0;
 }
 
-void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
-					    struct drm_plane_state *old_state)
+static void
+ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
+				       struct drm_plane_state *old_state)
 {
 	struct ast_private *ast = plane->dev->dev_private;
 	struct drm_plane_state *state = plane->state;
-- 
2.6.2

