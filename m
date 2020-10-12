Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5328B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgJLL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:57:33 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:11105 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbgJLL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:57:33 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 33E64482BF1;
        Mon, 12 Oct 2020 19:57:30 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] gpu/drm/armada: fix unused parameter warning
Date:   Mon, 12 Oct 2020 04:57:24 -0700
Message-Id: <20201012115724.8980-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkNIT00dHRkYHh1KVkpNS0lOS0hDTktIQ0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6CRw*Ej8ZLzkaFRZRFQw#
        TgMaCUNVSlVKTUtJTktIQ05LTExIVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSUhJTTcG
X-HM-Tid: 0a751cac395993bakuws33e64482bf1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions armada_drm_crtc_atomic_flush &
armada_drm_crtc_atomic_enable don`t use the second parameter.
So we may get warning like :
warning: unused parameter ‘***’ [-Wunused-parameter].
This change is to fix the compile warning with -Wunused-parameter.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/armada/armada_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 38dfaa46d306..fc8b922c3e44 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -427,7 +427,7 @@ static int armada_drm_crtc_atomic_check(struct drm_crtc *crtc,
 }
 
 static void armada_drm_crtc_atomic_begin(struct drm_crtc *crtc,
-					 struct drm_crtc_state *old_crtc_state)
+				struct drm_crtc_state __attribute__((unused)) *old_crtc_state)
 {
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
 
@@ -441,7 +441,7 @@ static void armada_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 }
 
 static void armada_drm_crtc_atomic_flush(struct drm_crtc *crtc,
-					 struct drm_crtc_state *old_crtc_state)
+				struct drm_crtc_state __attribute__((unused)) *old_crtc_state)
 {
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
 
-- 
2.28.0

