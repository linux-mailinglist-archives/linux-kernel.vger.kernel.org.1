Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A22C046F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgKWLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgKWLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so18248019wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/zamWA9w0pOX2DctOX3yJEbpsZvbeKEF08oXx4R0JI=;
        b=OuMa9UaWIFPj86BbHXSs73Xo1Pusn+Lxmxt+3cAZmcGB5PQm7gFVsRy18MW3/CEdGv
         iiA7WZtPwOLtaRQDjnprrZephkR0OYEKOS7XhRvpvIUztFc15DlQ/HmBW27rHUvUGZ84
         xhQ13Jr83ctPTHNSZ2le8pTffof04hJ1dSgQKDsytfWNIgDhfi0BPTGwBEzBStmbG3Ia
         R0VKK2mdmfJ8jgYuljfIm3fX7cqTJkCg99LNM7I+2GAi5zHL7r+58DG3PHKZAxzEz//C
         TbiL/JlgCJ172UmD3iTorkzYwpyYtsN6u5GIdRGXQsxUYjYAfQjetzPTotyFYsdi71hQ
         9tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/zamWA9w0pOX2DctOX3yJEbpsZvbeKEF08oXx4R0JI=;
        b=Yv2tvNfW/3nBf/y7TrcKM5sj72Eo6aZI9ief9h3suz9N3VlW7SN2sdsmD7ND85pkCv
         XRhFEg8B0f2tAXCyr64lOy3ZH0VUEunb2zUdZ3hAmVOeHJCOKWtdE8/DSHoRal8e+aT5
         2whygU1LwZUuhh0J32FJ9f7ajX5KqNikqbCLkpFsx0N9MDJMTr5lBmAsrFAsplEBZJLF
         7R34+SwB12gqEk0g3odo4xEF1t/HI8uJeUVICOPsrqOS/pj74721w4UvOX+eUTJAorRR
         Ht271frKzBWVg/v4ckeJCpOJsr7kZ1uWqTefrji1q1ACawHxgQH76+eXzKCCdEEqKbD9
         hkSw==
X-Gm-Message-State: AOAM530Ie85Qa/TiWw/u+Y83jtnWT0s3r0BWI2IrTlF2q+95x7iqjqRY
        IcUWNNRkWkhsdilHd4GSrims0A==
X-Google-Smtp-Source: ABdhPJygg5mGjWKEpUGK18y+BwQVZ6dGUYGr/KB94FrRZQtceWE1L+PTGjoAE/gZYYVeSTSbikPGAQ==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr30804236wrs.168.1606130386916;
        Mon, 23 Nov 2020 03:19:46 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 19/40] drm/msm/disp/dpu1/dpu_hw_lm: Fix misnaming of parameter 'ctx'
Date:   Mon, 23 Nov 2020 11:18:58 +0000
Message-Id: <20201123111919.233376-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c:55: warning: Function parameter or member 'ctx' not described in '_stage_offset'
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c:55: warning: Excess function parameter 'c' description in '_stage_offset'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 4b8baf71423f2..6ac0b5a0e0573 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -48,7 +48,7 @@ static const struct dpu_lm_cfg *_lm_offset(enum dpu_lm mixer,
 /**
  * _stage_offset(): returns the relative offset of the blend registers
  * for the stage to be setup
- * @c:     mixer ctx contains the mixer to be programmed
+ * @ctx:     mixer ctx contains the mixer to be programmed
  * @stage: stage index to setup
  */
 static inline int _stage_offset(struct dpu_hw_mixer *ctx, enum dpu_stage stage)
-- 
2.25.1

