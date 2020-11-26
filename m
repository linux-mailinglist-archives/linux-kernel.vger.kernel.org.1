Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15A42C563C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbgKZNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390851AbgKZNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EEFC061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so2192660wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jh3Zn1ResYGUShWTof3m2Q8rRwpV0wK8w2BTM5dDuqo=;
        b=rk6rWnUC9jqDQyGdupgrLNKrRSul0EHQaNGK+50NcidJxDqAvVUj56R5RyfXPBaGcW
         bSBgt/Ie1likRXGMHTQK+17lYRwCLYfSq3BJCLm2XxwMb8WXepCS7ge8/eZVo7gr/XGq
         kCuJM1R00G7RuwWlRH578S74u+AFIcbgHv3NFW66QOirRez6hZequRYFtFmwdFbg4jMK
         863oGkc9U1L7MDiHaIB9G4cRf6dOoqblbB/lUyg/otJbW4APSRCqt0ohAP2dgt2kagdA
         XI8RlvPRmdMATCk3eqe/Xzypb6nIQ8pzFcx6S/gzizO08IQOCYIyaI3A+dQLX9ehNMoK
         2wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jh3Zn1ResYGUShWTof3m2Q8rRwpV0wK8w2BTM5dDuqo=;
        b=IPKfmTw7N8G+ZLKgE7MrLNxnmE7buTWC9+vRH92NJUuS3tUy0Jypv5JiUoqx6gf7E9
         zUVPuH1hyctVJ0ezn+7Cy5uwlOZysOpfjOC2y5LsMcbU6OZAGAA37J+lZYA+JJZ0cF1R
         ePaOX7Bhah98y4BOVOWTd0yfR3n0wtNelErusptmKBsBNw99hxYbYMCK3reckC7tl8U0
         UwUKfcdi/jBQXt4I7B5KUrH48I5OH9JrNvXB9eGqtGNmOf/IvqsBiOtVlmVBL2PqtXao
         3TlHPFiifpdx2nzjc78hv7BTiFr5oZdYsQs5D/ISludd5+axgzXjXasNYh+DYfIxJ7XB
         8eqA==
X-Gm-Message-State: AOAM532pbat1HqeNkGq5vYUavgYvXNFY5vv0Gwx5bOhGeoRM3/CcA5Mf
        NSELj0cDxTXR0+3+EQOknXvPwzbZ/ywMloJf
X-Google-Smtp-Source: ABdhPJyFeP+oHnYZ8ZhxN1ULaFwXRE6QX6gCCHEBKcQb558Ob57TmjG/rdCvrc4GTuL6sxomjXk/Zg==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr3923479wro.373.1606398187789;
        Thu, 26 Nov 2020 05:43:07 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 15/40] drm/msm/disp/dpu1/dpu_hw_interrupts: Demote kernel-doc formatting misuse
Date:   Thu, 26 Nov 2020 13:42:15 +0000
Message-Id: <20201126134240.3214176-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:246: error: Cannot parse struct or union!
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:756: error: Cannot parse struct or union!

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Shubhashree Dhar <dhar@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 38482b1047745..5c521de715670 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -189,7 +189,7 @@ struct dpu_irq_type {
 	u32 reg_idx;
 };
 
-/**
+/*
  * struct dpu_intr_reg -  List of DPU interrupt registers
  */
 static const struct dpu_intr_reg dpu_intr_set[] = {
@@ -245,7 +245,7 @@ static const struct dpu_intr_reg dpu_intr_set[] = {
 	}
 };
 
-/**
+/*
  * struct dpu_irq_type - IRQ mapping table use for lookup an irq_idx in this
  *			 table that have a matching interface type and
  *			 instance index.
-- 
2.25.1

