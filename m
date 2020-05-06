Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270C41C7067
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgEFMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 08:34:09 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:9521 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgEFMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:34:09 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 376994829E3;
        Wed,  6 May 2020 20:34:03 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] drm/mediatek: cleanup coding style in mediatek a bit
Date:   Wed,  6 May 2020 05:33:55 -0700
Message-Id: <20200506123356.9147-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVPTUlCQkJDSUtMS0JJSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6Nyo6Pjg0PzgZKh42NVEX
        Ph1PFANVSlVKTkNDTE1DT09IT0NMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUpDTTcG
X-HM-Tid: 0a71e9fa8c1193bakuws376994829e3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code change is to make code bit more readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index ff43a3d80410..43e9876fd50c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -311,14 +311,10 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_hdmi *hdmi, u8 *buffer,
 	u8 checksum;
 	int ctrl_frame_en = 0;
 
-	frame_type = *buffer;
-	buffer += 1;
-	frame_ver = *buffer;
-	buffer += 1;
-	frame_len = *buffer;
-	buffer += 1;
-	checksum = *buffer;
-	buffer += 1;
+	frame_type = *buffer++;
+	frame_ver = *buffer++;
+	frame_len = *buffer++;
+	checksum = *buffer++;
 	frame_data = buffer;
 
 	dev_dbg(hdmi->dev,
-- 
2.26.2

