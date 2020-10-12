Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979FA28B438
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbgJLL5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:57:09 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:10153 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388255AbgJLL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:57:09 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id D2857482BD2;
        Mon, 12 Oct 2020 19:57:05 +0800 (CST)
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
Subject: [PATCH] gpu/drm/mediatek: fix unused parameter warning
Date:   Mon, 12 Oct 2020 04:56:59 -0700
Message-Id: <20201012115700.8925-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkpLTE5JTElCTUMaVkpNS0lOS0hDSU1KSk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6NRw4HD8eQjk3IxccFQ1M
        Tj4aC1FVSlVKTUtJTktIQ0lNTk9OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSEtMTDcG
X-HM-Tid: 0a751cabda8693bakuwsd2857482bd2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions mtk_drm_crtc_atomic_flush & mtk_drm_crtc_atomic_enable
& mtk_drm_crtc_atomic_disable don`t use the second parameter.
So we may get warning like : warning: unused parameter '***'
[-Wunused-parameter].
This change is to fix the compile warning with -Wunused-parameter.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 4d29568be3f5..6e55ec0e80bb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -542,7 +542,7 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 }
 
 static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
-					struct drm_crtc_state *old_state)
+					struct drm_crtc_state __attribute__((unused)) *old_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
@@ -575,7 +575,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 }
 
 static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
-				      struct drm_crtc_state *old_crtc_state)
+				      struct drm_crtc_state __attribute__((unused)) *old_crtc_state)
 {
 	struct mtk_crtc_state *state = to_mtk_crtc_state(crtc->state);
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
@@ -592,7 +592,7 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 }
 
 static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
-				      struct drm_crtc_state *old_crtc_state)
+				      struct drm_crtc_state __attribute__((unused)) *old_crtc_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	int i;
-- 
2.28.0

