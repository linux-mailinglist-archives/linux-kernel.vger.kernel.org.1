Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023C62F1F10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403971AbhAKTVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403931AbhAKTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2EC0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q75so297915wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibELFDbc+rU5KzM1TXI9030Gw8Nefp3Muywz/D1PCVQ=;
        b=X/A0BMqukT025ywWBP6402TmF9xYzKVtwcepbD+sRqr3dYbz9bjse+SWUcfaTjW0pr
         qJTtAQmOqDtekaE5N+7ON8TVe6h3wNQ48g4QW2sT2kuG+jdlWJj011xqQFq2AcK0iZR/
         CNGUYa5lKgSW57Qj5YJS7D7dbAVdYirp7zmE+TqJbqEl5qmLIY9skYjXz9lmrQEZ9vTb
         GuknaG74tmKA3q1YA0KIwPD+1lXAnDgKPFZvT/XAwlsuhhMHD0bYo2xXHpf/50vE/APy
         l1kUmFCRRlhWatFgHHo3Hev2TLeLnhRI49SdE7gwEIZHfWQRj71KeMuALvnNf4ZE29IG
         PmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibELFDbc+rU5KzM1TXI9030Gw8Nefp3Muywz/D1PCVQ=;
        b=r2Kvm9S5zvCdJB0e5pc/0TADGw0wIRu9kwtXXODRLDvrT7aMFtfiBY1IvzEqH0A6GO
         XszclYGB/F6kDunVFWcqpVDZHQbabwDEEUGOwsiZy3W5YV0n/hBFNvEKPlzvrGqYVdOz
         GxxhAZYiXx2uXUSUwi8X4iRSACGeT3EdPuqtQckgeReegWUUU3Q49vcvQ48BpZJg+ukn
         FfUmw/n7MP1Sj7ExsORzPpLYoVuWF5K/A4WwqHteVxfYuV/qamjKvG82lXeo8VYVPR3T
         b/QCeNG4/8959/q6rNMgSa6rwIpGE5BfU8dVorQhstbZvIJhh/CgDG+tuZ7BPuzL6M0M
         cQnA==
X-Gm-Message-State: AOAM533om64URCZTAKjr6Kog4gKY8XJZ/qgtqPXJ5Uajh8v2mG/I8Gxo
        TABCYY3j5Ba3DAXfsTcrJRFYIw==
X-Google-Smtp-Source: ABdhPJw5pKXVGtKU5/0T6G4y0EaXSn4tXsz5RwR4PV4c8N8pkhKVEJNKTjStdBxA+xGzmYPpQ/TYAw==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr293177wmm.72.1610392821103;
        Mon, 11 Jan 2021 11:20:21 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amd/display/dc/core/dc_surface: Demote kernel-doc abuse
Date:   Mon, 11 Jan 2021 19:19:25 +0000
Message-Id: <20210111191926.3688443-40-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c:119: warning: Cannot understand  *****************************************************************************

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Josip Pavic <Josip.Pavic@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 3d7d27435f15e..e6b9c6a718413 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -115,7 +115,7 @@ struct dc_plane_state *dc_create_plane_state(struct dc *dc)
 	return plane_state;
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: dc_plane_get_status
  *
-- 
2.25.1

