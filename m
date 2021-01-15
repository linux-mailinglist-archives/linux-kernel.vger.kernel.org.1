Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A42F852C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbhAOTM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:12:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:44672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbhAOTM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:12:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06B02ACAC;
        Fri, 15 Jan 2021 19:12:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, eric@anholt.net, daniel@ffwll.ch,
        airlied@linux.ie, stefan.wahren@i2se.com, broonie@kernel.org,
        tiwai@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] drm/vc4: Unify PCM card's driver_name
Date:   Fri, 15 Jan 2021 20:12:09 +0100
Message-Id: <20210115191209.12852-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User-space ALSA matches a card's driver name against an internal list of
aliases in order to select the correct configuration for the system.
When the driver name isn't defined, the match is performed against the
card's name.

With the introduction of RPi4 we now have two HDMI ports with two
distinct audio cards. This is reflected in their names, making them
different from previous RPi versions. With this, ALSA ultimately misses
the board's configuration on RPi4.

In order to avoid this, set "card->driver_name" to "vc4-hdmi"
unanimously.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Fixes: f437bc1ec731 ("drm/vc4: drv: Support BCM2711")
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 97f368bc1c67..4bdc8e71b5e5 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1404,6 +1404,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	card->dai_link = dai_link;
 	card->num_links = 1;
 	card->name = vc4_hdmi->variant->card_name;
+	card->driver_name = "vc4-hdmi";
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 
-- 
2.29.2

