Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C522C046D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgKWLVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgKWLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556B4C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so16853399wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKoITWdb0NAA2TK8pxTD/cxHUBVgW9vDIRLy1VQg+s8=;
        b=CCyxnCMqaD6iY/pHwlqr9sW8pQD8avE8KqZDp/baOaadch63BqfnmFUxC2u2xSnwXi
         JdKYp2wkcbJrzPIfpMoT6gtkHiai7DA2fnb3Ws2X24klPs4fyBX4jEyX8ZxxPfqHxDG+
         Vr1ZKgJ15buJstTI+jCKRRnmDMwLjmqcWMNXvRDm4BreDc2ty++tMdtvs82ZJINBUEyi
         /v+3eNY7PEWmWw5QzyOxBTpZ++zFTFv8a4GFEiy9xHCHE5PwKDw74pGHOziGcFNx47bV
         7AjL24ldFFtcp5lNCyqo/6Y0Rf44GruO/z3TIyADZ2Tn8lmp7g9LNdt96ZB5rZUly6Ld
         Im/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKoITWdb0NAA2TK8pxTD/cxHUBVgW9vDIRLy1VQg+s8=;
        b=B/SmtgPUc8NL8CAVO3X6L7UbXQoQU5YQR/vQQCqqUwXiwAgXy6SCyXLIGb0ZJqWjn8
         aeXVgUFkJQrqrUPGBDbHhSfjYQVBfWEADHlKOrkhDCxyr5MLtcmTajWt44Aq8kt4vJ5p
         A5YvnwQ5ocaB53ZMCKwOM+sL6dn0We7p5rzv3/yjA0euzaBZ8xZE0e/zlFgtsdujfVgT
         osBsxhKxhc6oZzhct7prl5h0p82Mln+NxAGtdHJJxF4u6EDfUq5ByzzKwO3TV7cc8jog
         WvbTHHd1c58a140O4LkPmRPR/omR6vAlYn70H9m4s/8TWyvQqDIN455U+Io18RLk3FdZ
         0nXg==
X-Gm-Message-State: AOAM533/Dk+IMicSgDPhEx/p8H+zwCMuV2cuZ6PWg3QmssshKa86/hJK
        RO3h0XMbbiQSMR/waatzMbI/Vg==
X-Google-Smtp-Source: ABdhPJwFR9JH8+waSGmVuFK54gn5FZd4IubjIUGmE3hzei8uwpKEfY8VjOTl1bSxhPdXOJ9MukO0MQ==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr23539889wmb.139.1606130388099;
        Mon, 23 Nov 2020 03:19:48 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 20/40] drm/msm/disp/dpu1/dpu_hw_sspp: Fix kernel-doc formatting abuse
Date:   Mon, 23 Nov 2020 11:18:59 +0000
Message-Id: <20201123111919.233376-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:240: warning: Function parameter or member 'ctx' not described in 'dpu_hw_sspp_setup_format'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:240: warning: Function parameter or member 'fmt' not described in 'dpu_hw_sspp_setup_format'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:240: warning: Function parameter or member 'flags' not described in 'dpu_hw_sspp_setup_format'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:240: warning: Function parameter or member 'rect_mode' not described in 'dpu_hw_sspp_setup_format'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:446: warning: Function parameter or member 'ctx' not described in 'dpu_hw_sspp_setup_rects'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:446: warning: Function parameter or member 'cfg' not described in 'dpu_hw_sspp_setup_rects'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c:446: warning: Function parameter or member 'rect_index' not described in 'dpu_hw_sspp_setup_rects'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index c940b69435e16..2c2ca5335aa8c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -231,7 +231,7 @@ static void _sspp_setup_csc10_opmode(struct dpu_hw_pipe *ctx,
 	DPU_REG_WRITE(&ctx->hw, SSPP_VIG_CSC_10_OP_MODE + idx, opmode);
 }
 
-/**
+/*
  * Setup source pixel format, flip,
  */
 static void dpu_hw_sspp_setup_format(struct dpu_hw_pipe *ctx,
@@ -437,7 +437,7 @@ static u32 _dpu_hw_sspp_get_scaler3_ver(struct dpu_hw_pipe *ctx)
 	return dpu_hw_get_scaler3_ver(&ctx->hw, idx);
 }
 
-/**
+/*
  * dpu_hw_sspp_setup_rects()
  */
 static void dpu_hw_sspp_setup_rects(struct dpu_hw_pipe *ctx,
-- 
2.25.1

