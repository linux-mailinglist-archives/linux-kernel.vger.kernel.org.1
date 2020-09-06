Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C39625EF0F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgIFQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 12:22:32 -0400
Received: from gw.c-home.cz ([89.24.150.100]:41972 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgIFQW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:22:28 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 086GLocu011279;
        Sun, 6 Sep 2020 18:21:58 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/sun4i: sun8i-csc: Secondary CSC register correction
Date:   Sun,  6 Sep 2020 18:21:39 +0200
Message-Id: <20200906162140.5584-2-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200906162140.5584-1-m.cerveny@computer.org>
References: <20200906162140.5584-1-m.cerveny@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Allwinner V3s" has secondary video layer (VI).
Decoded video is displayed in wrong colors until
secondary CSC registers are programmed correctly.

Signed-off-by: Martin Cerveny <m.cerveny@computer.org>
---
 drivers/gpu/drm/sun4i/sun8i_csc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index f42441b1b14d..a55a38ad849c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -12,7 +12,7 @@ struct sun8i_mixer;
 
 /* VI channel CSC units offsets */
 #define CCSC00_OFFSET 0xAA050
-#define CCSC01_OFFSET 0xFA000
+#define CCSC01_OFFSET 0xFA050
 #define CCSC10_OFFSET 0xA0000
 #define CCSC11_OFFSET 0xF0000
 
-- 
2.17.1

