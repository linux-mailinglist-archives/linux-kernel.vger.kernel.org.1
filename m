Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8744F2D7274
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437317AbgLKJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:00:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9598 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393203AbgLKJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:00:24 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Csl8236kfzM3Tp;
        Fri, 11 Dec 2020 16:58:58 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:59:36 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <joonas.lahtinen@linux.intel.com>, <jani.nikula@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] gpu: drm: i915: convert comma to semicolon
Date:   Fri, 11 Dec 2020 17:00:05 +0800
Message-ID: <20201211090005.3196-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 3f2008d845c2..9737a8604fc7 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1323,8 +1323,8 @@ static int intel_hdmi_hdcp_write(struct intel_digital_port *dig_port,
 	memcpy(&write_buf[1], buffer, size);
 
 	msg.addr = DRM_HDCP_DDC_ADDR;
-	msg.flags = 0,
-	msg.len = size + 1,
+	msg.flags = 0;
+	msg.len = size + 1;
 	msg.buf = write_buf;
 
 	ret = i2c_transfer(adapter, &msg, 1);
-- 
2.22.0

