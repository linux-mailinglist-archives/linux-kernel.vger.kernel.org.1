Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61C25E24C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgIDUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:02:13 -0400
Received: from gw.c-home.cz ([89.24.150.100]:41763 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgIDUCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:02:03 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 084K1EdC002405;
        Fri, 4 Sep 2020 22:01:28 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     devicetree@vger.kernel.org
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 4/6] media: cedrus: Add support for V3s
Date:   Fri,  4 Sep 2020 22:01:10 +0200
Message-Id: <20200904200112.5563-5-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904200112.5563-1-m.cerveny@computer.org>
References: <20200904200112.5563-1-m.cerveny@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3s video engine runs at lower speed and support video decoder
for H.264 and JPEG/MJPEG only.

Signed-off-by: Martin Cerveny <m.cerveny@computer.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 3fd9fd810..3c4fcef37 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -506,6 +506,12 @@ static const struct cedrus_variant sun8i_h3_cedrus_variant = {
 	.mod_rate	= 402000000,
 };
 
+static const struct cedrus_variant sun8i_v3s_cedrus_variant = {
+	.capabilities	= CEDRUS_CAPABILITY_UNTILED |
+			  CEDRUS_CAPABILITY_H264_DEC,
+	.mod_rate	= 297000000,
+};
+
 static const struct cedrus_variant sun50i_a64_cedrus_variant = {
 	.capabilities	= CEDRUS_CAPABILITY_UNTILED |
 			  CEDRUS_CAPABILITY_MPEG2_DEC |
@@ -552,6 +558,10 @@ static const struct of_device_id cedrus_dt_match[] = {
 		.compatible = "allwinner,sun8i-h3-video-engine",
 		.data = &sun8i_h3_cedrus_variant,
 	},
+	{
+		.compatible = "allwinner,sun8i-v3s-video-engine",
+		.data = &sun8i_v3s_cedrus_variant,
+	},
 	{
 		.compatible = "allwinner,sun50i-a64-video-engine",
 		.data = &sun50i_a64_cedrus_variant,
-- 
2.17.1

