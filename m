Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D536C2E31C7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgL0QNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:13:54 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:33242 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgL0QNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=z3Vnq31DxKVyPM1hK6
        Zk4ooSbMhCB5IcK28zkGpz+eg=; b=cF5XRXkXfYCX8adgqACgW9jUa9FeRFHX1n
        7m2WMVmh8Fd4JGjnneVKdJgX0JOoEpSfbPSCrkfa/kPQdFBgS/NWgJWI6bgmXwq8
        sDvB6x/3LWWgsUhhUKwkUZyuUiOKvVZJgSYZUgjIFOFmLeE6Rnjq0VdroJhe4Aac
        9eR2gDnPs=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp8 (Coremail) with SMTP id NORpCgDnE1SBhuhfwJ5wBA--.10417S2;
        Sun, 27 Dec 2020 21:05:07 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     tom.ty89@gmail.com, kai.heng.feng@canonical.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] ALSA:usb-audio:check urb before kill it
Date:   Sun, 27 Dec 2020 21:04:59 +0800
Message-Id: <1609074299-3990670-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgDnE1SBhuhfwJ5wBA--.10417S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4DJF4rWryxArWUurWfKrg_yoW3tFc_Wr
        s3Xw18GryUG347Cr1UGw42vw1rtw4xZ3WxZwsrt3yrXFyvkFy5tw40qryDG3Z2kr4kXFZr
        Ar1kuFy3Zry2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUgo7tUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiFg0I11pECs+7hQAAsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<124751d5e>, there should be a check for urb before kill it.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 sound/usb/mixer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 81e987e..0223ef3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3589,8 +3589,10 @@ void snd_usb_mixer_disconnect(struct usb_mixer_interface *mixer)
 /* stop any bus activity of a mixer */
 static void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer)
 {
-	usb_kill_urb(mixer->urb);
-	usb_kill_urb(mixer->rc_urb);
+	if (mixer->urb)
+		usb_kill_urb(mixer->urb);
+	if (mixer->rc_urb)
+		usb_kill_urb(mixer->rc_urb);
 }
 
 static int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
-- 
2.7.4

