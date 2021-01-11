Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAA2F1F15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbhAKTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403989AbhAKTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFAC06138B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k10so244316wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tzA9ne5yyDo/B6XSuB5tuKBnRjxwc25nSNFsXm3RyU=;
        b=Ahk/N7WicvAg2xBmcya5Li0rhrLV39Zple9TDmD2+AkEaK8Sfi6y9w1RxaLEw29Hoc
         bPQ62/KVS7U2rMgiAQBD0vuBrdJbNeX3D7IyoSZdxQsfgdy7s5brQpLlxBKi/vu4zzhC
         L50pSaqfRrQ891NVBw/dUnCgk2DJtrLhx+yJn7RG34J0YH/IiiwnToahF89kcKHDb5K4
         v7KOMCktZ16hayl9fz55vyKjRpReSxfAmgM31je2nf9qCvRZiOpzx8MNDyel3UFFq/Bk
         jp3/pQq5ub9ag0PHbuovkitWojvt295oLOh9aJxS8LVJVPssdveidWb3KX+p/JfWGozv
         3cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tzA9ne5yyDo/B6XSuB5tuKBnRjxwc25nSNFsXm3RyU=;
        b=RDc9szNhlti8VgRMK8YsRAgPxk5hCbJyTDDU48hu0dIG3TRWOae7xOOsdPZwlGInX1
         KnvI6sH18er1CNlTXulYCxZDCBd7MkAmNsY18xyhaA4bEt7KvvAEJU66a9NJx+z5OP92
         buCRkcBwKx0PUrFEri3JpLsa08+uh8TM93O3fof36LZP+EceaiwF4KQODYivizQsb6zu
         dfSyqsGSyJi7aMCkTNroinzJs3sGFDaXiIqo44sPAD5O4Qlc5nk3E4sTSbyW5seR5bgB
         DMHJum5PvSyvmkCO4LQSZrNRyNA0Gpk/Qvh3FT4GHTiuWEfFPhzvlKbY5+xAwj6bc4Yc
         m1eg==
X-Gm-Message-State: AOAM531FoTRq/GytnOPVF0WmwlI4tMHQ954guZl2KHQewZ+17FK5c18z
        E8YiTS0DkgfnACHKzaB3biHIOA==
X-Google-Smtp-Source: ABdhPJzrN9L41qmGyfA0DbPZwxDVobcpgwqW/z39Cl9OQZRKF44ip0vd0aenfh8tUWi2E5TeASxFPg==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr292412wmb.76.1610392809471;
        Mon, 11 Jan 2021 11:20:09 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/display/dc/dce110/dce110_timing_generator_v: Demote kernel-doc abuse and line up comments
Date:   Mon, 11 Jan 2021 19:19:16 +0000
Message-Id: <20210111191926.3688443-31-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator_v.c:54: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_v_enable_crtc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator_v.c:216: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_v_wait_for_vactive'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../dc/dce110/dce110_timing_generator_v.c     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
index a13a2f58944e3..c509384fff543 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
@@ -46,17 +46,16 @@
  *
  **********************************************************************************/
 
-/**
-* Enable CRTCV
-*/
+/*
+ * Enable CRTCV
+ */
 
 static bool dce110_timing_generator_v_enable_crtc(struct timing_generator *tg)
 {
 /*
-* Set MASTER_UPDATE_MODE to 0
-* This is needed for DRR, and also suggested to be default value by Syed.
-*/
-
+ * Set MASTER_UPDATE_MODE to 0
+ * This is needed for DRR, and also suggested to be default value by Syed.
+ */
 	uint32_t value;
 
 	value = 0;
@@ -209,9 +208,9 @@ static void dce110_timing_generator_v_wait_for_vblank(struct timing_generator *t
 	}
 }
 
-/**
-* Wait till we are in VActive (anywhere in VActive)
-*/
+/*
+ * Wait till we are in VActive (anywhere in VActive)
+ */
 static void dce110_timing_generator_v_wait_for_vactive(struct timing_generator *tg)
 {
 	while (dce110_timing_generator_v_is_in_vertical_blank(tg)) {
-- 
2.25.1

