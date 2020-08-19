Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A022424A1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHSOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 10:38:08 -0400
Received: from mail.ispras.ru ([83.149.199.84]:58214 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHSOiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:38:04 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id 59B7440A206D;
        Wed, 19 Aug 2020 14:37:59 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Peter Senna Tschudin <peter.senna@gmail.com>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] drm/brige/megachips: Add checking if ge_b850v3_lvds_init() is working correctly
Date:   Wed, 19 Aug 2020 17:37:56 +0300
Message-Id: <20200819143756.30626-1-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ge_b850v3_lvds_init() does not allocate memory for ge_b850v3_lvds_ptr,
then a null pointer dereference is accessed.

The patch adds checking of the return value of ge_b850v3_lvds_init().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 6200f12..ab81748 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -302,8 +302,12 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
 				       const struct i2c_device_id *id)
 {
 	struct device *dev = &stdp4028_i2c->dev;
+	int ret;
+
+	ret = ge_b850v3_lvds_init(dev);
 
-	ge_b850v3_lvds_init(dev);
+	if (ret)
+		return ret;
 
 	ge_b850v3_lvds_ptr->stdp4028_i2c = stdp4028_i2c;
 	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
@@ -361,8 +365,12 @@ static int stdp2690_ge_b850v3_fw_probe(struct i2c_client *stdp2690_i2c,
 				       const struct i2c_device_id *id)
 {
 	struct device *dev = &stdp2690_i2c->dev;
+	int ret;
+
+	ret = ge_b850v3_lvds_init(dev);
 
-	ge_b850v3_lvds_init(dev);
+	if (ret)
+		return ret;
 
 	ge_b850v3_lvds_ptr->stdp2690_i2c = stdp2690_i2c;
 	i2c_set_clientdata(stdp2690_i2c, ge_b850v3_lvds_ptr);
-- 
1.9.1

