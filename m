Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3123569B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHBLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 07:15:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54838 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbgHBLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U4TqfqO_1596366935;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4TqfqO_1596366935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:35 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, jose.souza@intel.com,
        maarten.lankhorst@linux.intel.com, chris@chris-wilson.co.uk,
        manasi.d.navare@intel.com, wambui.karugax@gmail.com,
        stanislav.lisovskiy@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: [PATCH] drm/i915: Fix wrong return value in intel_atomic_check()
Date:   Sun,  2 Aug 2020 19:15:35 +0800
Message-Id: <20200802111535.5200-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of calling check_digital_port_conflicts() failed, a
negative error code -EINVAL should be returned.

Fixes: bf5da83e4bd80 ("drm/i915: Move check_digital_port_conflicts() earier")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 26996e1839e2..9f3a7ef58aba 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -14872,7 +14872,7 @@ static int intel_atomic_check(struct drm_device *dev,
 	if (any_ms && !check_digital_port_conflicts(state)) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "rejecting conflicting digital port configuration\n");
-		ret = EINVAL;
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.26.2

