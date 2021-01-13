Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9112F4DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbhAMOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbhAMOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA8C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i9so2417957wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZA26LGPctNuqP7mpV6XCcQsQZ+HB0XmYF1B/7L0jYA=;
        b=YtqFI8RDxxpW9mdQOUk2m2f1SEWXkWNA5Pijok8cpdh3D28yUmkArEeHKDJHaMEw2D
         PdgSAP9Q4tLae/SkYSJ5eTZDO+n6pFatwv/TqUUoiuB320K732eTGq0iXq8oR/tNfkIH
         9Y7pMmU2dnvUJlE7Cdikh+7Q8gG1oq1Nl7lwW/RGcLXR8b/1SFcPKGDY/yVn+9vcaOw5
         ZsO4KDnuoqv4twTiAyGApWz9SY9RChb3/M/q2nVmM21sVoOCVxHdSCQemO93T1g3lrAj
         3Lx+99Zkwfs70d4L1iYYRAQVeIVTso9ON+bmqWt1gSMmPn5bt/vIUtmLPizMCW6GT2UM
         qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZA26LGPctNuqP7mpV6XCcQsQZ+HB0XmYF1B/7L0jYA=;
        b=ktuay1wxMU+2V5h2EiPZNjZ7MUMtD1W792CCbDwoDwIwLnTtv4XXJYxrfTKT28IHb5
         dGVZFi4uWN+asmoY7aV0tQaAVAmjJrtrnRP9pUeT3aNbX4uxYe3uK2utpxb6hZnrlAcQ
         7Mk5Wcf6TpqtERtvKIeUkV0+BZYV1kt3anFTSEP/ie6BzpNepGufop1E2sr5IdorlAru
         VDlIWO2ff9e8yNi2E2r9PO6pa9z1SP2BuZGrAsKgPWuAoo++MuzXcEP4EihipdKP1kRL
         Sse9wRxNfHCpoQeYjFeuqzVHsUbQtgbbWo9XfSgMCCxar2PKx8g7mLy4op4NXcDkbzAQ
         9Cwg==
X-Gm-Message-State: AOAM5313y+pvfxVmQZ9Kloke4q24lTCtn527R86gN+gAPTK3GmsF10Gl
        DY7PrDaunsLlNcAHqFr7/lARzg==
X-Google-Smtp-Source: ABdhPJybD9xMfIqt11fPwnFfiI93H9p+YPj4ju8Xk0ywP3UrRKbDeRkdo75NDlfYMlTY1EKiKvzaMA==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr2935428wrw.379.1610549422311;
        Wed, 13 Jan 2021 06:50:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
        Brad Douglas <brad@neruo.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 06/31] video: fbdev: core: fb_notify: Demote non-conformant kernel-doc header
Date:   Wed, 13 Jan 2021 14:49:44 +0000
Message-Id: <20210113145009.1272040-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/core/fb_notify.c:44: warning: Function parameter or member 'val' not described in 'fb_notifier_call_chain'
 drivers/video/fbdev/core/fb_notify.c:44: warning: Function parameter or member 'v' not described in 'fb_notifier_call_chain'

Cc: Antonino Daplas <adaplas@pol.net>
Cc: Brad Douglas <brad@neruo.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/core/fb_notify.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
index 74c2da5288848..1f142182fb40e 100644
--- a/drivers/video/fbdev/core/fb_notify.c
+++ b/drivers/video/fbdev/core/fb_notify.c
@@ -36,9 +36,8 @@ int fb_unregister_client(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(fb_unregister_client);
 
-/**
+/*
  * fb_notifier_call_chain - notify clients of fb_events
- *
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
-- 
2.25.1

