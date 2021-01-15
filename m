Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D402F83ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbhAOSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbhAOSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF05C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c5so10208437wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LH1gDNEpa04mVmMwrdsnTHPuZadf7vRIYykG237nqs=;
        b=OoioVsm+TQx6nV7gS8EYVFvVJ1Fv6AK0ME2b/TTWZE6GVipp0qR5swgZ83FEbZ12hJ
         bHfLNqxGSPlvKS/kjMA6EFo0ABSEJZ7RxksriR+eL3aLaSRw+duGxMmfMFNZ/6DWKvR1
         W10uIAzHzlddHv+JocGFwsSmxmEbLV0Tlhngr0vMllvQKG/JNDysKLzXv0AyOiKStki+
         WjLofYAriQTZgUtIf2WYUjD/ue1rD7qJbI760ANCfyWYCqT4EUaiH+f56OdxXd2zqSut
         keQOIR2LCIAHQ4j+dA2EHerIqjTJF5JZ+VvUE4csnjttU6l1DvBN4KjjB/ingtnz4MwT
         z7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LH1gDNEpa04mVmMwrdsnTHPuZadf7vRIYykG237nqs=;
        b=Ds8eFMi0p4q8X6he00RMA+k8SiyMZLNKWKSEWjmzMFx7Dr8pqIwtQ0aNoSmFL4ZgxN
         KlpVD/kZ2MU0reXO2dx8+Z80jU0G/a7ouvhIbX5ESK2PjYPiN4FuMEyiFsC4XjqWxPMh
         M3TTIpI8nrh50Gl3y8Q9i+v9PwwiMZ5VY9Hk49UvB9GxeiHy63pu6f22YjppjXCHEzCr
         UF/LlooLfroSVQkXpg4qTmxeMtDbcdxUZTZz0pqdlvmuH7aZ6JbbrZG0t5NbOtQpG54q
         w5/kqFuQV6S4+sHIXfhUDgqRlAGc7lxjRTlfrE8oF2EiLogfpBUYcBF9S8upc1DLAqTS
         jdlA==
X-Gm-Message-State: AOAM531KMY9gT/u8RkiScb9UHvNnp9TRIDU/tUYxqKqXsdIastlCuw94
        tAlhTfUMKwExeZA2iw+7DU6yFA==
X-Google-Smtp-Source: ABdhPJyKcUhDIemsychtub1SOGZ27ei+YoeVSS+BDyIF3O5uT+K79mKwPFMnaxURU7ZO+559zmOaNQ==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr14514805wrs.58.1610734589879;
        Fri, 15 Jan 2021 10:16:29 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Keith Packard <keithp@keithp.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/29] drm/gma500/cdv_intel_dp: Demote one unworthy header fix another
Date:   Fri, 15 Jan 2021 18:15:49 +0000
Message-Id: <20210115181601.3432599-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/cdv_intel_dp.c:315: warning: Function parameter or member 'encoder' not described in 'is_edp'
 drivers/gpu/drm/gma500/cdv_intel_dp.c:315: warning: Excess function parameter 'intel_dp' description in 'is_edp'
 drivers/gpu/drm/gma500/cdv_intel_dp.c:1698: warning: Function parameter or member 'connector' not described in 'cdv_intel_dp_detect'
 drivers/gpu/drm/gma500/cdv_intel_dp.c:1698: warning: Function parameter or member 'force' not described in 'cdv_intel_dp_detect'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Keith Packard <keithp@keithp.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index bfd9a15d63b1a..6d3ada39ff867 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -306,7 +306,7 @@ static uint32_t dp_vswing_premph_table[] = {
 };
 /**
  * is_edp - is the given port attached to an eDP panel (either CPU or PCH)
- * @intel_dp: DP struct
+ * @encoder: GMA encoder struct
  *
  * If a CPU or PCH DP output is attached to an eDP panel, this function
  * will return true, and false otherwise.
@@ -1687,7 +1687,7 @@ static enum drm_connector_status cdv_dp_detect(struct gma_encoder *encoder)
 	return status;
 }
 
-/**
+/*
  * Uses CRT_HOTPLUG_EN and CRT_HOTPLUG_STAT to detect DP connection.
  *
  * \return true if DP port is connected.
-- 
2.25.1

