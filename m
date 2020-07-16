Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D922260A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGPOmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:42:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgGPOms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:42:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B94BEB76A;
        Thu, 16 Jul 2020 14:42:51 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix double free in gem code
Date:   Thu, 16 Jul 2020 16:42:29 +0200
Message-Id: <20200716144229.2581-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix the same issue:

- drm/v3d: Fix memory leak in v3d_submit_cl_ioctl (29cd13cfd76)
- drm/v3d: don't leak bin job if v3d_job_init fails (0d352a3a8a1)

And it seems that the conflict was missed during the merge.

Get rid of one of the free() calls.

Fixes: 77e0723bd27f ("Merge v5.4-rc7 into drm-next")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 915f8bfdb58c..3cfbdb8e6a91 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -570,7 +570,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		if (ret) {
 			kfree(bin);
 			v3d_job_put(&render->base);
-			kfree(bin);
 			return ret;
 		}
 
-- 
2.27.0

