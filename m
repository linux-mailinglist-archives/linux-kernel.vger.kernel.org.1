Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C1262EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIIMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 08:40:01 -0400
Received: from foss.arm.com ([217.140.110.172]:42506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgIIMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:30:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58CD2101E;
        Wed,  9 Sep 2020 05:30:05 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8734F3F68F;
        Wed,  9 Sep 2020 05:30:03 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Marty E. Plummer" <hanetzer@startmail.com>,
        Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: Ensure GPU quirks are always initialised
Date:   Wed,  9 Sep 2020 13:29:57 +0100
Message-Id: <20200909122957.51667-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU 'CONFIG' registers used to work around hardware issues are
cleared on reset so need to be programmed every time the GPU is reset.
However panfrost_device_reset() failed to do this.

To avoid this in future instead move the call to
panfrost_gpu_init_quirks() to panfrost_gpu_power_on() so that the
regsiters are always programmed just before the cores are powered.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index e0f190e43813..6d17d3cbd1df 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -305,6 +305,8 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 	int ret;
 	u32 val;
 
+	panfrost_gpu_init_quirks(pfdev);
+
 	/* Just turn on everything for now */
 	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
@@ -356,7 +358,6 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
-	panfrost_gpu_init_quirks(pfdev);
 	panfrost_gpu_power_on(pfdev);
 
 	return 0;
-- 
2.20.1

