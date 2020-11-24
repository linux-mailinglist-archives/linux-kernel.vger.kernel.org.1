Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24BF2C311E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgKXTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgKXToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999FC061A53
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so23564748wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IuYUPAmdjNAB2iB0feai5NRQku3ocmldwDZ4+yeUjOQ=;
        b=G6RizRk86LJoiRxWoHggIJioWd/Caezt6X9dDirbeZl2WR1uV0CaD0Ho13XnPd5XtC
         T0S4wjyWXh9IbLoGuJJie52QMC1nQDAogfU2C50i9BdbT+sZO2vfn/sQ+8EpCwYGHFr/
         8cvlIibvBz9utcaqPcSen+zbb9g4q/fEaMXU1zyDfaG0UljGysQMCyu9yd74N5P6+FtZ
         huQU/Q3b68Q2mmTXVS/vH3yZ05TtTa0u96Hy1edtsgmC9aNg9CwFnfX+9vD28/L1Dsht
         59aRyImfMp+OTRPrcesVD0/YgR9S0iK5b336NZUfp7FPsz3cUuNzEphWmZGdJLJw/ELu
         +3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IuYUPAmdjNAB2iB0feai5NRQku3ocmldwDZ4+yeUjOQ=;
        b=IBBCJZcZQSuKn2y/zmziw/jb/Womks/6wrFaylJqhiK1iySERUhA2poIJjJOAAHERt
         Ddlz4EVTAbB4nOE/XaX5XfJbkyM3Vv+2naFzHruC8WCowuGg1KWPuuJMzG76KfMQPSMi
         oPBG149YXv6Wv84TJAaVNZEsV13jXE4ArJa1SVYW1fLxmDafuy+JdN0TPbvMlYwcGtk/
         D/onCby9RSOtvau4sn36BXvwc70u4FRfca5un88i+zYOczwGNXpNVwxP7WInWIzFoKaV
         1/J43HaWImjF8YMok42z1QpVfY6cr/J114e/PKj8IZxMG7yLHPLnqy5B5QxVVz2uTzBx
         GXgg==
X-Gm-Message-State: AOAM533oXlVEucBixc3h1BJFMCVl3gAC3pohWqD5LmMJQgm8EztCt2xh
        J+2GBz1Zy5o00G9BOw+B2gGfRXV1TFtM2tjZ
X-Google-Smtp-Source: ABdhPJz3fTSV3/+18bQ/0bhtmER6mtf+OjZ8lu5pN+mo0EYPCn9N9UjXgTCZ4wuw7uOtKLmiQljm5w==
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr94838wrv.326.1606247085224;
        Tue, 24 Nov 2020 11:44:45 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/40] drm/amd/pm/swsmu/smu12/renoir_ppt: Demote kernel-doc formatting abuse
Date:   Tue, 24 Nov 2020 19:38:21 +0000
Message-Id: <20201124193824.1118741-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 46c44f0abdfb8..d3641a8ed99c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -170,7 +170,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	return -ENOMEM;
 }
 
-/**
+/*
  * This interface just for getting uclk ultimate freq and should't introduce
  * other likewise function result in overmuch callback.
  */
@@ -656,7 +656,7 @@ static int renoir_get_power(struct smu_context *smu, uint32_t *value)
 	return 0;
 }
 
-/**
+/*
  * This interface get dpm clock table for dc
  */
 static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_clocks *clock_table)
-- 
2.25.1

