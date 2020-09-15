Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519526A34C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIOKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:40:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38587 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOKjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:39:49 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kI8N0-0002fg-UJ; Tue, 15 Sep 2020 10:39:31 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andrew Oakley <andrew@adoakley.name>,
        Chris Boyle <chris@boyle.name>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "ALSA: usb-audio: Disable Lenovo P620 Rear line-in volume control"
Date:   Tue, 15 Sep 2020 18:39:23 +0800
Message-Id: <20200915103925.12777-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 34dedd2a83b241ba6aeb290260313c65dc58660e.

According to Realtek, volume FU works for line-in.

I can confirm volume control works after device firmware is updated.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/mixer_maps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 5b43e9e40e49..c369c81e74c4 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -371,7 +371,6 @@ static const struct usbmix_name_map asus_rog_map[] = {
 };
 
 static const struct usbmix_name_map lenovo_p620_rear_map[] = {
-	{ 19, NULL, 2 }, /* FU, Volume */
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
 	{}
 };
-- 
2.17.1

