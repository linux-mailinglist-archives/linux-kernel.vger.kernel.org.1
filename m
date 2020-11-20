Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2F2BB9B8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKTXKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgKTXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:10:53 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:10:52 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u19so15756460lfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyaDQ59Xa+QtuyHKnT1OfwqIq6Z2viIRqDw3lT6p86A=;
        b=avjXDLLq0T69cWueF0peuiKWe70cp7lI1mDGSjFGYE5O5SR1+UJV3vfgHNh63+9A+m
         rPPbBxtAUAnfO4+OozC/cnjeSh2sJHYYlxsAr21Vj/Hm2Vo4XQTEnU9Zoic/ByZIyrhi
         SaKUJI11PTFozUlWNen1X60ve37i/7siRVzyhtrNyap6byS7/x1nN544Li27Kqz2XS01
         0qMRsDQuAkGMv7P6107/YNv6jtO3yrgtQjD8qBrR3jFzOxmzy0qAGEHzNE8jbKtCFrg8
         +eZfjgKrkp/jhx0NcXvySG3j0wUG78bpsC8z042p4vMAjRzREVZyroRqm0IoAj0RMwHD
         A1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyaDQ59Xa+QtuyHKnT1OfwqIq6Z2viIRqDw3lT6p86A=;
        b=LXGhfqTwGitYAHmGZbx7qi/AcLHV07nwPo9EapKUnmQ+mvwgZv41c1ez+NnuPID6x+
         LqEq37Fp3J4PFP4bpAGFKhgY+abiawtRpHyo3sXjFCJWHmaklNrW03i+u5GJkcb5Ylk7
         Gz7hsQteLUamEnFDbUKtJcKSg3AXqEP5sfBvvChMlGUK5j+agA7qzLjTLSKyOTG+B8iX
         WHzUuW87y+LATnj/ZNkGz/IevnVcpMKyKx1cK9w9ncHvekUTP6kIVkEPiceCQp43tIyu
         GFM0L9j1erJop0rgnj4IO89cvc0f0WoSRfkYNlgS17fQ42R8BMSzKg3lKo923qjxOmdD
         DTvw==
X-Gm-Message-State: AOAM533f2gGd6BlxAOgGAL0OagDfR8LW1BqkIp9wDagEoJuWET9DIZIG
        el6gt17OJlTpUuavjDuZpqIEEWgaYDU=
X-Google-Smtp-Source: ABdhPJyFOQj6ZUsQsgE61ZNUC7d+DA/frbSsQ4l+9LnnB5R+5Q9igswbzgsPtjUNhpytFOm74Pwf4w==
X-Received: by 2002:a19:4a08:: with SMTP id x8mr9756918lfa.322.1605913851350;
        Fri, 20 Nov 2020 15:10:51 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id a132sm493810lfd.101.2020.11.20.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 15:10:50 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>, aroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ALSA: aloop: Constify ops structs
Date:   Sat, 21 Nov 2020 00:10:46 +0100
Message-Id: <20201120231046.76758-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of the ops field in the loopback_cable struct is to call
its members, the field it self is never changed. Make it a pointer to
const. This allows us to constify two static loopback_ops structs to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/drivers/aloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index c91356326699..702f91b9c60f 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -105,7 +105,7 @@ struct loopback_cable {
 	unsigned int running;
 	unsigned int pause;
 	/* timer specific */
-	struct loopback_ops *ops;
+	const struct loopback_ops *ops;
 	/* If sound timer is used */
 	struct {
 		int stream;
@@ -1021,7 +1021,7 @@ static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
 	return 0;
 }
 
-static struct loopback_ops loopback_jiffies_timer_ops = {
+static const struct loopback_ops loopback_jiffies_timer_ops = {
 	.open = loopback_jiffies_timer_open,
 	.start = loopback_jiffies_timer_start,
 	.stop = loopback_jiffies_timer_stop,
@@ -1172,7 +1172,7 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 /* stop_sync() is not required for sound timer because it does not need to be
  * restarted in loopback_prepare() on Xrun recovery
  */
-static struct loopback_ops loopback_snd_timer_ops = {
+static const struct loopback_ops loopback_snd_timer_ops = {
 	.open = loopback_snd_timer_open,
 	.start = loopback_snd_timer_start,
 	.stop = loopback_snd_timer_stop,
-- 
2.29.2

