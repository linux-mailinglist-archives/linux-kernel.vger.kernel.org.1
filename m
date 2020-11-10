Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385202AC9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgKJBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:01:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F333C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:01:22 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t6so5597909plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bW1B13MA+lpPF6obdjVtfz4uu2DnlzXJwA4hsuPKBZM=;
        b=OyMbX78C5V0d7RSyIgee1PPNW2ZO8LENAU6+xOMJwz0rntmWC8FnJBSUt9lL+TQ+Rt
         2x6U85pZQa9AZrUkySIoP+GlPZj8k/bHqc1rP5i+5cLkeUnHj1Tzt7oADS2Zoe2VY70q
         QbV8STcGdOaBg31JdsiZDBeGrc+Kz5tyQzcfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bW1B13MA+lpPF6obdjVtfz4uu2DnlzXJwA4hsuPKBZM=;
        b=LL+HKeJAdj2Lq49556X7hFNCpXveGg4tl+TPJSa5ou6B7lnJIxlZTxfzzhQFmAMZUx
         BftODL+s/C5HPdkO8m0JQdJ+du1O9wmzBFOeIpEivD6FT1DNAHlPpXbULLGMudYmEidt
         ab3yOy/Bafi7/0BbJl5x6kHOubkX3AGmgOY9sS1dV/k0NXKnLNkDU/c9f90485JyqyVu
         XoeazveB0PSUpEVkRkWcHJa5Ey4POcaC0KuwIC4BxdV/+odYlWgsAbVKOYAKmJN4fJTJ
         mUuCh42lGxjJ0S/frenlzY6SmP/xo6v5aJkP43uOqFyiInJenHdNDexebXqIqtv4mg8g
         dT5A==
X-Gm-Message-State: AOAM5300GZ8LdT4Rkxbo3pe8FrRxd3c0iBpmV8Sp17SEXCFq4EXVoOoB
        QIbTqnIViTTQr+bXjLFa+86CMQ==
X-Google-Smtp-Source: ABdhPJy9bs+Rprsk5hzIlJbn+gxTdb4kEK+sylbcZHNFCrVE6MBigUyOI3vHG8/L+2CJOuEbVdQRDw==
X-Received: by 2002:a17:902:bf0c:b029:d8:86aa:eb4e with SMTP id bi12-20020a170902bf0cb02900d886aaeb4emr1977511plb.82.1604970082146;
        Mon, 09 Nov 2020 17:01:22 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id u197sm7283233pfc.127.2020.11.09.17.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:01:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] drm: panel: simple: Defer unprepare delay till next prepare to shorten it
Date:   Mon,  9 Nov 2020 17:00:56 -0800
Message-Id: <20201109170018.v4.2.I06a95d83e7fa1bd919c8edd63dacacb5436e495a@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is believed that all of the current users of the "unprepare" delay
don't actually need to wait the amount of time specified directly in
the unprepare phase.  The purpose of the delay that's specified is to
allow the panel to fully power off so that we don't try to power it
back on before it's managed to full power down.

Let's use this observation to avoid the fixed delay that we currently
have.  Instead of delaying, we'll note the current time when the
unprepare happens.  If someone then tries to prepare the panel later
and not enough time has passed, we'll do the delay before starting the
prepare phase.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Split ("Allow timing constraints, not fixed delays") into 2 patches.
- Reuse the existing "unprepare" and assume it means "unprepare_to_prepare".
- Shortened function name to panel_simple_wait().
- Change to fix kerneldoc is now patch #1 in the series.

 drivers/gpu/drm/panel/panel-simple.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 813c90274631..4bc61d71f068 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -115,6 +115,11 @@ struct panel_desc {
 		 *
 		 * The time (in milliseconds) that it takes for the panel
 		 * to power itself down completely.
+		 *
+		 * This time is used to prevent a future "prepare" from
+		 * starting until at least this many milliseconds has passed.
+		 * If at prepare time less time has passed since unprepare
+		 * finished, the driver waits for the remaining time.
 		 */
 		unsigned int unprepare;
 	} delay;
@@ -130,6 +135,8 @@ struct panel_simple {
 	bool enabled;
 	bool no_hpd;
 
+	ktime_t unprepared_time;
+
 	const struct panel_desc *desc;
 
 	struct regulator *supply;
@@ -257,6 +264,20 @@ static int panel_simple_get_non_edid_modes(struct panel_simple *panel,
 	return num;
 }
 
+static void panel_simple_wait(ktime_t start_ktime, unsigned int min_ms)
+{
+	ktime_t now_ktime, min_ktime;
+
+	if (!min_ms)
+		return;
+
+	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
+	now_ktime = ktime_get();
+
+	if (ktime_before(now_ktime, min_ktime))
+		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
+}
+
 static int panel_simple_disable(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
@@ -283,10 +304,8 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 
 	regulator_disable(p->supply);
 
-	if (p->desc->delay.unprepare)
-		msleep(p->desc->delay.unprepare);
-
 	p->prepared = false;
+	p->unprepared_time = ktime_get();
 
 	return 0;
 }
@@ -326,6 +345,8 @@ static int panel_simple_prepare(struct drm_panel *panel)
 	if (p->prepared)
 		return 0;
 
+	panel_simple_wait(p->unprepared_time, p->desc->delay.unprepare);
+
 	err = regulator_enable(p->supply);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to enable supply: %d\n", err);
-- 
2.29.2.222.g5d2a92d10f8-goog

