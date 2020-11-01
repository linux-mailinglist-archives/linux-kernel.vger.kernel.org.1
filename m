Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F712A1CE9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKAJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:32:37 -0500
Received: from aposti.net ([89.234.176.197]:38630 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgKAJcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:32:36 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] media: uapi: Add MEDIA_BUS_FMT_RGB888_3X8_DELTA media bus format
Date:   Sun,  1 Nov 2020 09:31:49 +0000
Message-Id: <20201101093150.8071-4-paul@crapouillou.net>
In-Reply-To: <20201101093150.8071-1-paul@crapouillou.net>
References: <20201101093150.8071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add media bus format for 24-bit panels that expect their pixel data to
be sent serially on a 8-bit bus, in RGB ordering on odd lines, and in
GBR ordering on even lines (aka delta-RGB).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/uapi/linux/media-bus-format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index 84fa53ffb13f..5d905ad6dbb2 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x101d */
+/* RGB - next is	0x101e */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -56,6 +56,7 @@
 #define MEDIA_BUS_FMT_RGB888_2X12_BE		0x100b
 #define MEDIA_BUS_FMT_RGB888_2X12_LE		0x100c
 #define MEDIA_BUS_FMT_RGB888_3X8		0x101c
+#define MEDIA_BUS_FMT_RGB888_3X8_DELTA		0x101d
 #define MEDIA_BUS_FMT_RGB888_1X7X4_SPWG		0x1011
 #define MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA	0x1012
 #define MEDIA_BUS_FMT_ARGB8888_1X32		0x100d
-- 
2.28.0

