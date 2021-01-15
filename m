Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A84B2F88B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbhAOWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbhAOWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:45:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13562C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:50 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id my11so6127019pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esnObWpP9J8bOo0IUsOKjdAe7AetAYNnvTwxBtu8gOA=;
        b=m/ZeZRnI+jQ6T7gJRoAmph4QjmtbXaB9Mbos68yxQkKgbx+Up5eC7p8aAQt9cs7pl2
         byxwu0qKaXYWP4qvIkI5v61Bj/DB8PiExypu9QmGcofaWULqGMlB92lYCiIM8ZLAwLwh
         Yj5E92BfnpRxATnWZh/H0DVg0dYVFe0sB/H94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esnObWpP9J8bOo0IUsOKjdAe7AetAYNnvTwxBtu8gOA=;
        b=mNO04Nn3xbVmkIyDTlp6HaIz0Cg1FhQwNRD2fG9FAt+nfeZUQW81temYgWLr+P5wL8
         E3fOsxFhP+LTS/RilAwxtCIqfqyulzzeSyK376oXLkwoLd4givhecRSEOQ5It9EEm7DV
         x9JVf3Mw8rWcbTvCtdcldFg/Go5WYQHF8xGRRhHfqI7xxmO+6HEmh8QI78F6zjYVvsD5
         uPnsLvcOKtosE+R19TpKWmb6QmUXuOHf/zalUOVVOAkIuodjcrzmMABvOVKIgpABne/T
         CZJ2C+tMBo6ORY9ECAZP5HC1qIesKZwojIoY63lZeTSkL0RCpxGxM6xsfhA4slcVeSZI
         Szgg==
X-Gm-Message-State: AOAM533sKPZ+uGGzyp76M8SBH5h6v5lmH6x9xGmIDkMnR667G3Ql++0a
        vci2P294h5vu00AKpy3hqMTqgQ==
X-Google-Smtp-Source: ABdhPJzhOlOz+MZXZQUM93OIlpGcdb90a+r5o5I+V3QxmNZQ2p4sp1C9wAK28TrCHGgtcB+uRZ8pag==
X-Received: by 2002:a17:90a:5993:: with SMTP id l19mr12779129pji.203.1610750689678;
        Fri, 15 Jan 2021 14:44:49 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q16sm9131100pfg.139.2021.01.15.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] drm/panel-simple: Don't wait longer for HPD than hpd_absent_delay
Date:   Fri, 15 Jan 2021 14:44:17 -0800
Message-Id: <20210115144345.v2.2.I183b1817610d7a82fdd3bc852e96d2985df9623f@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
References: <20210115224420.1635017-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a panel has an hpd_absent_delay specified then we know exactly how
long the maximum time is before HPD must be asserted.  That means we
can use it as a timeout for polling the HPD pin instead of using an
arbitrary timeout.  This is especially useful for dealing with panels
that periodically fail to power on and need to be retried.  We can
detect the problem sooner.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("drm/panel-simple: Don't wait longer for HPD...") new for v2.

 drivers/gpu/drm/panel/panel-simple.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 581ab6810b70..30842cf6d414 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -382,6 +382,7 @@ static int panel_simple_prepare(struct drm_panel *panel)
 	unsigned int delay;
 	int err;
 	int hpd_asserted;
+	unsigned long hpd_wait_us;
 
 	if (p->prepared_time != 0)
 		return 0;
@@ -409,9 +410,14 @@ static int panel_simple_prepare(struct drm_panel *panel)
 				goto error;
 		}
 
+		if (p->desc->delay.hpd_absent_delay)
+			hpd_wait_us = p->desc->delay.hpd_absent_delay * 1000UL;
+		else
+			hpd_wait_us = 2000000;
+
 		err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
 					 hpd_asserted, hpd_asserted,
-					 1000, 2000000);
+					 1000, hpd_wait_us);
 		if (hpd_asserted < 0)
 			err = hpd_asserted;
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

