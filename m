Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A42F1F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbhAKTVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbhAKTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A70EC06138E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so880755wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIbmEvfzHXehTUhCMEmMZrSzDyf/FShSUv7k6W8xO0I=;
        b=zMzZ4xE5NKZ9zZzeixi0EshIlbVM+Oqc0rHAXlxuiA9B1gxQh79nQVjQEYiHwQn18H
         TcgstRKaBJCcs24Vnyg12yQBMOqOiXw+LDrjMF/1a1ovufxRBx4X0bVRwKrdtog/+Wej
         2vADHgeCtfaD2aqGnfDnm9yDyUyhN7YuBF2lFtel/9aXRCptMNSoSYHmkPtHUtlotPWJ
         gPchL821+gq/eH/44RW1MySEpowk94XjDdOQFpFL8fjtHXIscERdaIlPNpnMEXCHE4gc
         bIrv9WhxJF9movrz1mrhKWYmj74JkSx5LUGUR+oVb/CNTDkZX+xS3gwb+fcPeIqVfWvC
         JmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIbmEvfzHXehTUhCMEmMZrSzDyf/FShSUv7k6W8xO0I=;
        b=LLUXYVIJqsa1VI7Hh3JXVRCTlepjYYP9Q5mOt6ozlf7JurMbrRrWWfIGfk7T6AHW78
         nCN9iVboO+OgvMhquExjZ8P64M9xuqEc2vk5Z0/Y7VHJ8n4gzzB8Xswds/xPpCe6Shlq
         Z/UhLFa/hvUlpPZHviyF1XyTIxzKEeHRXfh+ecK4G6YPUsC8ZbwJ1mKLpjYZTAwk9j17
         h79Ey9MvqmiDrbxA5UbTxuqalKPa0crXwJ9kHeIdb8lLhMh3xlzOW/SFtVaEnGQBXpis
         VXZKfwS6C3/5E2ZO+LA7fQok4aquLGcpV1vtP88uwmcpO8PDcCIEDpbOj/OI4/s2+Hn5
         rWHg==
X-Gm-Message-State: AOAM532AyPOh4xZD1LVS4Y4JcCdR0QykSS7VJG3bNGqQtHuPCT6GxUQ5
        Wq1V3+BtijD9/Hf2S87R15H7aQ==
X-Google-Smtp-Source: ABdhPJwPslRBTQryX8hbTrdbI2rKljD9/OIme1u+tGVt0jX+nOO8mXoWjIqC+0cfZdcnshAkR/UwpA==
X-Received: by 2002:adf:8185:: with SMTP id 5mr615286wra.44.1610392816068;
        Mon, 11 Jan 2021 11:20:16 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 35/40] drm/amd/display/dc/dce60/dce60_timing_generator: Make 'dce60_configure_crc' invoked by reference static
Date:   Mon, 11 Jan 2021 19:19:21 +0000
Message-Id: <20210111191926.3688443-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_timing_generator.c:192:6: warning: no previous prototype for ‘dce60_configure_crc’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
index fc1af0ff0ca4c..c1a85ee374d9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
@@ -189,8 +189,8 @@ static bool dce60_is_tg_enabled(struct timing_generator *tg)
 	return field == 1;
 }
 
-bool dce60_configure_crc(struct timing_generator *tg,
-			  const struct crc_params *params)
+static bool dce60_configure_crc(struct timing_generator *tg,
+				const struct crc_params *params)
 {
 	/* Cannot configure crc on a CRTC that is disabled */
 	if (!dce60_is_tg_enabled(tg))
-- 
2.25.1

