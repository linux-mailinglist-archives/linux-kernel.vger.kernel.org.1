Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753F42A9F84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgKFVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgKFVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA177C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so2658365wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3s/vNbQhCOhaWUYjnatK+JAnL9zFArhDEfxOk3yJ9s=;
        b=QWCbYIFHbnL6cvVci1njVHiIUyhUnpp3bWojQBoR2JpVYoexBntA0mWqhP0DaOE2fM
         M7A6HqqFQ7dsmueWwZcVWsA9lu9tHYweFv81kqWlo1c4FbFUtVgUaCvtZQkpWHDUnrWk
         hjnAtDgqlGXxpfXJuujeGzda1GJmOmIi9oIyAzvinNSYXX0/bqCAczSXaP964OnyZqnQ
         itH5RagP5FQTTjj4FyQddYro6+/8euDYjhwzlwQI2+M3D6xnTS1GANsk3X7PZrzs8kTK
         pNZ2tlRH7Kl64ZBNSGfJAK63+d4wrmV3FTejPZe/RLzgVbbvigIP1/ZdAD4BzTX3iJ97
         berA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3s/vNbQhCOhaWUYjnatK+JAnL9zFArhDEfxOk3yJ9s=;
        b=qboF3S4TdrJEnzXC+FqofdlWb7Zc4yhkYiVmtjkh/HpqjdyE/i8g9mMgOcZt5dEJ7B
         hF+pSwLdvQO/R30mijtbdUc4v03xFetUME703XvZehKLURjw4I7aMyIXfBV6XqatYs3R
         OPWdVeMQS0L0iCRhtihDyGPYSPPgxy1y1wUCZgIClwnxhddkTcsTb/jaFHwBcz8Wl5CP
         B+fnpCeUQiquHEvIuQ9IsHdqRxWx1P0vQ4zOKsNAAuAo9rEohb1zlzYsL5QjLWV4qKip
         qKo3Q+8ZywAwjdHkuLfsvjw49AKaSa6KL1bKJzPjrvNsUzeRc6MPwB3oqZudX2BHqHaO
         f7ug==
X-Gm-Message-State: AOAM532jJGX3IHALDAtZKvHV+JQ286OXFEg0SXMY0F8wFNeFARuTYfgy
        jkFvkOGVzCnh1Wcw53rPJ0g1Ug==
X-Google-Smtp-Source: ABdhPJyOw2SZ7qeRyvMdjsuBPr5WvcSlm0uiM/Hm5KSHTGSt1O1F+ndVZ5Pq7eFnPGNB15kWxdNmAA==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr1615684wme.153.1604699404699;
        Fri, 06 Nov 2020 13:50:04 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Clark <rob@ti.com>,
        Andy Gross <andy.gross@ti.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH 09/19] drm/omapdrm/omap_dmm_tiler: Demote abusive use of kernel-doc format
Date:   Fri,  6 Nov 2020 21:49:39 +0000
Message-Id: <20201106214949.2042120-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:313: warning: Function parameter or member 'dmm' not described in 'dmm_txn_init'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:313: warning: Function parameter or member 'tcm' not described in 'dmm_txn_init'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:353: warning: Function parameter or member 'txn' not described in 'dmm_txn_append'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:353: warning: Function parameter or member 'area' not described in 'dmm_txn_append'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:353: warning: Function parameter or member 'pages' not described in 'dmm_txn_append'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:353: warning: Function parameter or member 'npages' not described in 'dmm_txn_append'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:353: warning: Function parameter or member 'roll' not described in 'dmm_txn_append'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:399: warning: Function parameter or member 'txn' not described in 'dmm_txn_commit'
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:399: warning: Function parameter or member 'wait' not described in 'dmm_txn_commit'

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <rob@ti.com>
Cc: Andy Gross <andy.gross@ti.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 42ec51bb7b1b0..cedaab456041a 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -306,7 +306,7 @@ static irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * Get a handle for a DMM transaction
  */
 static struct dmm_txn *dmm_txn_init(struct dmm *dmm, struct tcm *tcm)
@@ -344,7 +344,7 @@ static struct dmm_txn *dmm_txn_init(struct dmm *dmm, struct tcm *tcm)
 	return txn;
 }
 
-/**
+/*
  * Add region to DMM transaction.  If pages or pages[i] is NULL, then the
  * corresponding slot is cleared (ie. dummy_pa is programmed)
  */
@@ -392,7 +392,7 @@ static void dmm_txn_append(struct dmm_txn *txn, struct pat_area *area,
 	return;
 }
 
-/**
+/*
  * Commit the DMM transaction.
  */
 static int dmm_txn_commit(struct dmm_txn *txn, bool wait)
-- 
2.25.1

