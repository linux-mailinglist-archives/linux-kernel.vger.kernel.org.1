Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208172C7B1A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgK2UKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgK2UKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:10:12 -0500
Received: from threadripper.lan (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685F320756;
        Sun, 29 Nov 2020 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606680572;
        bh=rQ5NWEEEPU4g45U80zBfT28KT/fxWWNh4bB2Arjzahk=;
        h=From:To:Cc:Subject:Date:From;
        b=HaBHq0rmQ3UUakU8auzk6mvEnyoOY5gHkt7DdwdL+XdzKV4NuuddNb01IJWJSZQ7J
         RF7AkL64t8au1LQVxNjL5/nfsTs4eLh3WIfmKxRJZ66nNDHIxVPhiIDTA8E3g446/P
         TJjkOnrB9/JVN2YyxvcrYkxABSRqQaYcsRJbBcKY=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/kmb: fix array bounds warning
Date:   Sun, 29 Nov 2020 21:09:08 +0100
Message-Id: <20201129200927.1854104-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an out-of-bounds access when the using nonzero
values for 'plane_id' on kmb->plane_status:

drivers/gpu/drm/kmb/kmb_plane.c: In function 'kmb_plane_atomic_disable':
drivers/gpu/drm/kmb/kmb_plane.c:128:20: warning: array subscript 3 is above array bounds of 'struct layer_status[1]' [-Warray-bounds]
  128 |   kmb->plane_status[plane_id].ctrl = LCD_CTRL_GL2_ENABLE;
      |   ~~~~~~~~~~~~~~~~~^~~~~~~~~~
drivers/gpu/drm/kmb/kmb_plane.c:125:20: warning: array subscript 2 is above array bounds of 'struct layer_status[1]' [-Warray-bounds]
  125 |   kmb->plane_status[plane_id].ctrl = LCD_CTRL_GL1_ENABLE;
      |   ~~~~~~~~~~~~~~~~~^~~~~~~~~~
drivers/gpu/drm/kmb/kmb_plane.c:122:20: warning: array subscript 1 is above array bounds of 'struct layer_status[1]' [-Warray-bounds]
  122 |   kmb->plane_status[plane_id].ctrl = LCD_CTRL_VL2_ENABLE;

Having the array truncated to one entry seems intentional, so add
a range check before indexing it to make it clearer what is going
on and shut up the warning.

I received the warning from the kernel test robot after a private
patch that turns on Warray-bounds unconditionally.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 8448d1edb553..be8eea3830c1 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -114,6 +114,9 @@ static void kmb_plane_atomic_disable(struct drm_plane *plane,
 
 	kmb = to_kmb(plane->dev);
 
+	if (WARN_ON(plane_id >= KMB_MAX_PLANES))
+		return;
+
 	switch (plane_id) {
 	case LAYER_0:
 		kmb->plane_status[plane_id].ctrl = LCD_CTRL_VL1_ENABLE;
-- 
2.27.0

