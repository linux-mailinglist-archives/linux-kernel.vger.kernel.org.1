Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC50A1B34E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDVCMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 22:12:44 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:60984 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDVCMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:12:44 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id A6E676652E0;
        Wed, 22 Apr 2020 10:10:53 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/arm: cleanup coding style in arm a bit
Date:   Tue, 21 Apr 2020 19:10:46 -0700
Message-Id: <20200422021046.4375-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVOTEhCQkJDQ0pMT09IQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6Dhw4Dzg5SwIDFhQTCkwC
        TB9PC01VSlVKTkNMTklKT05IQ0JJVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSkJPTTcG
X-HM-Tid: 0a719fa6fef29373kuwsa6e676652e0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the code logic, an alarm is thrown after failure, but the
code continues to run and returns successfully, so to the caller
the if check and return branch will never run.
The change is to make the code a bit more readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index af67fefed38d..32bda13250f5 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -160,9 +160,7 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	hdlcd_write(hdlcd, HDLCD_REG_H_SYNC, vm.hsync_len - 1);
 	hdlcd_write(hdlcd, HDLCD_REG_POLARITIES, polarities);
 
-	err = hdlcd_set_pxl_fmt(crtc);
-	if (err)
-		return;
+	hdlcd_set_pxl_fmt(crtc);
 
 	clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
 }
-- 
2.26.2

