Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247BB2F1F17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbhAKTWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403947AbhAKTV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C28CC061383
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g8so4948wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOMcvHupoNOe/LWOcIRzth9mgUcklXf22W184Qe4k/0=;
        b=jINxIN2J/6RKcOAL6kDcJF+Mgaxi1T5CpE5VbihyBJ33bI6YWqCr6mAuwzxGwkhsv5
         FVpFw3s+rEwrmOhwZRHxpQwCVJ6CKW4KhXS9inF7U76wq9C00wDaxmKMxpK5qIBgTkOR
         FAk3+eWlt4HKHYXNAUJOtRX0vXVfoGo8yZ9RjBe0UK1n5NYW1e7fJa1hkrwj1qb4TxaB
         WvJ7fmUEe7ofzUqDXvT+2Ldjcdkr2T2ythHyQPLeHDGT/1ngjh+zs01UCY/eu0y3FWOl
         XyWRj0QAOjh8kxv/klpi4IxXJQ0w3ChZ1znaBUXCwhPw4n1LidqzJ0GXUJR/zctFuNzc
         yIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOMcvHupoNOe/LWOcIRzth9mgUcklXf22W184Qe4k/0=;
        b=bDT5cp2bkRldfYkqEo87dxInOhKMbcnwTcB7GJs1wijLGO1UuGycMkOn/0AXmYubrG
         yiRVfemaR6I8zDxET/Z8EXANos9yRmp6eao4QEoX3limUU6gFvBmWkxTcQAnP3OXQS2j
         jkymljfhnhpT/gOxhHIMsUqcUxVB6mmegBUnpquu+04IFX2VIUCM8tM5/4NvbtAgtUj8
         X/EkRvfoHdT+zmTNhuJtgC5pB6BI0DtU36jZ7fxbVAZwYAUJtu1gvNs3XbGoif65vNmC
         KNz9U1k6RVCVxAjsoUKygppJR2PJ/EqcJwjQyponu2GXlBEoGyzzhkWPI0hoJQCOrmmR
         7Fbw==
X-Gm-Message-State: AOAM531A+TumQawJS+L1U2i/prCC4Nmd43NZiDPCpJi5Ezf5loU8+9RR
        Jlr8CZTDkBr644kb7cgeOa4SnA==
X-Google-Smtp-Source: ABdhPJzC8kJim0Asdl/jHsMlAY9hTdXgq0nqdS4y/wlPdTiNiOUqq/xEWH3/kje9AOnGdPdj84Nb6Q==
X-Received: by 2002:a05:600c:4ed0:: with SMTP id g16mr280323wmq.176.1610392799259;
        Mon, 11 Jan 2021 11:19:59 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:58 -0800 (PST)
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
Subject: [PATCH 22/40] drm/amd/display/dc/dce110/dce110_hw_sequencer: Demote non-conformant kernel-doc header
Date:   Mon, 11 Jan 2021 19:19:08 +0000
Message-Id: <20210111191926.3688443-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1639: warning: Function parameter or member 'dc' not described in 'dce110_enable_accelerated_mode'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1639: warning: Function parameter or member 'context' not described in 'dce110_enable_accelerated_mode'

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
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 4c230f1de9a30..c57405fa4bebc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1628,7 +1628,7 @@ static struct dc_link *get_edp_link_with_sink(
 	return link;
 }
 
-/**
+/*
  * When ASIC goes from VBIOS/VGA mode to driver/accelerated mode we need:
  *  1. Power down all DC HW blocks
  *  2. Disable VGA engine on all controllers
-- 
2.25.1

