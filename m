Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D52F6FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbhAOBYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbhAOBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:24:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4914FC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:23:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id md11so4143333pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAPHsHm+2XIrQA1OESxVnuIMSm0KrZ79SJ4XDucyPvM=;
        b=XUdrUW23+dnz/P8wVglvFy5MQnCedEURA9CI4MMRuUKdnhcoWPKTdiUkIabfVKNb0+
         +QLeH6rzURyT0mdSAohSkm5+Kt8j2kQYJjMMQyM2VhTYQVRiojOgol90egFLH0uGRhoA
         CLmyHN9qaqqRJV0ecTBp1n71z2wIh++hf5H5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAPHsHm+2XIrQA1OESxVnuIMSm0KrZ79SJ4XDucyPvM=;
        b=ZsWkKuytg0oELjz3XbFkcH5fkZ9wobacMOdh0GgY9004PkO1hVYW/BlSRt2G1U4GPa
         mHAdhenLl43klYtz3FaimfRA3RZFnlSUxtDyGylGaOcoRiPPjyFtb1ul+AEqhqTDwUk/
         OTgHvhfgEsYFKCScN0oIUzXwvwaxkEe8T2sYG7TWkqztl1mwtu67IvaGY6JBXq+5ONVM
         BAEhlDS7FgAAbEhY+Uod4TRjhANNmD+x/H0OSQzsKey9VtOSlSPDXXHLp8jgYPRydXlC
         ZTQZjvHMeQG+Bp/vmaOPMtNuWeKf/c4hT6qZrc6YBW3fM/id5qUIkh9TGrBMOGXKnyDN
         NWog==
X-Gm-Message-State: AOAM532MsDUcan+iYZvvQzNUYYlUV9UllvnzY3yQecozTYdILUWNTcI5
        IWdWlgKCiKp0FupSTE+eoi6nPg==
X-Google-Smtp-Source: ABdhPJzaiZtuHHebdoNCQc0Ip8w+8uPtCbHJezMb+dhXNEAYWBnV188vW2zTFJDriySZf0NjMZkzQA==
X-Received: by 2002:a17:902:8306:b029:da:d7f0:9e16 with SMTP id bd6-20020a1709028306b02900dad7f09e16mr10351975plb.53.1610673800871;
        Thu, 14 Jan 2021 17:23:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id b65sm2885816pga.54.2021.01.14.17.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 17:23:20 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-simple: Undo enable if HPD never asserts
Date:   Thu, 14 Jan 2021 17:22:59 -0800
Message-Id: <20210114172254.1.I33fcbd64ab409cfe4f9491bf449f51925a4d3281@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the HPD signal never asserts in panel_simple_prepare() and we
return an error, we should unset the enable GPIO and disable the
regulator to make it consistent for the caller.

At the moment I have some hardware where HPD sometimes doesn't assert.
Obviously that needs to be debugged, but this patch makes it so that
if I add a retry that I can make things work.

Fixes: 48834e6084f1 ("drm/panel-simple: Support hpd-gpios for delaying prepare()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 71ae200ac48a..b89394b44f43 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -406,7 +406,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
 		if (IS_ERR(p->hpd_gpio)) {
 			err = panel_simple_get_hpd_gpio(panel->dev, p, false);
 			if (err)
-				return err;
+				goto error;
 		}
 
 		err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
@@ -418,13 +418,19 @@ static int panel_simple_prepare(struct drm_panel *panel)
 		if (err) {
 			dev_err(panel->dev,
 				"error waiting for hpd GPIO: %d\n", err);
-			return err;
+			goto error;
 		}
 	}
 
 	p->prepared_time = ktime_get();
 
 	return 0;
+
+error:
+	gpiod_set_value_cansleep(p->enable_gpio, 0);
+	regulator_disable(p->supply);
+
+	return err;
 }
 
 static int panel_simple_enable(struct drm_panel *panel)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

