Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4171E19D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 05:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbgEZDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388634AbgEZDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:22:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:22:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b27so9264701qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqGVPzCwYn8DVvhE6LVcxMlICfwfg+X8jSsAedeo4EE=;
        b=phARGkuLZUYehpM/d2KMBVBv+kPH50tL7EaDIKPedz9VnKE/uo7g88SvQ0ya2SMR2V
         /EoPXB52tLpEU6++KCQ/2MaM7SqcTSxWIkbirnoD6jus+eBielNWV8g5qCjOx/cfHCAU
         iSUSPR5s4+yZqBcsL0WR7lVd2wOqKM0UOtgIpQ9rljOYfvevAprbF2089/Y57pIbk+dZ
         51ceW9zGJDqBrubv7vDkOQUbDoBKJSI9qgh6WZBeeGN1uXcvTRFj1sPKr2vVGT0Ccsxp
         SZpznyIKink68buJUl93sIPpTP85K//SiaEDUhkzAfb1YN5drOKqTvZDti9D+RljnsVX
         HvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqGVPzCwYn8DVvhE6LVcxMlICfwfg+X8jSsAedeo4EE=;
        b=uHT2V9zYdnDQ2VyBm4Cq5e//dtwKFMJmSAn5Oa4T/6sy+mkMbu46hqmb5WbHu+couY
         730OPBpYIZXz+MkE9CjcS7Mxu7LzTN/C1xvnvtzR0WUsVP/0xYUz9TOM6dtUPromlVBF
         4yenXyQduwABuchZciJ7W08yQf6cle09nFpwfFlQ9X8SSmAtEV/hpz+qEQeGkg76nFzc
         G/UpeUh9hglxzuSEjUJbWDKt9vBREOhyKQeY9jBFgpm1BmcAhEvj/PVSPA7ce/1T8rZK
         EciyuZLB2jR3GcRhLf+XT0M9WGEeEA2aRg0xf0HwGmf4/e0cWcBowuTps8FZAANgTu8t
         fcHA==
X-Gm-Message-State: AOAM53145Z0iJoWwzGEpE4HtUdmAgNc6GJW0g/4f3PAXpLr//KrRt2Gz
        r6ZK1VOIuumYaX9WUcf0IqlfWA==
X-Google-Smtp-Source: ABdhPJxHwkI9byKgEUj3ejcFaK3cCkToltc+6OW/ingZP4EQhU7BbTrM40I8+svqwohGSvqEOaIedw==
X-Received: by 2002:a37:7984:: with SMTP id u126mr8678321qkc.73.1590463362982;
        Mon, 25 May 2020 20:22:42 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k20sm2530796qtu.16.2020.05.25.20.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 20:22:42 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] drm/msm/dpu: use right setup_blend_config for sm8150 and sm8250
Date:   Mon, 25 May 2020 23:22:08 -0400
Message-Id: <20200526032235.21930-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200526032235.21930-1-jonathan@marek.ca>
References: <20200526032235.21930-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All DPU versions starting from 4.0 use the sdm845 version, so check for
that instead of checking each version individually. This chooses the right
function for sm8150 and sm8250.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 37becd43bd54..4b8baf71423f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -152,14 +152,13 @@ static void _setup_mixer_ops(const struct dpu_mdss_cfg *m,
 		unsigned long features)
 {
 	ops->setup_mixer_out = dpu_hw_lm_setup_out;
-	if (IS_SDM845_TARGET(m->hwversion) || IS_SDM670_TARGET(m->hwversion)
-	    || IS_SC7180_TARGET(m->hwversion))
+	if (m->hwversion >= DPU_HW_VER_400)
 		ops->setup_blend_config = dpu_hw_lm_setup_blend_config_sdm845;
 	else
 		ops->setup_blend_config = dpu_hw_lm_setup_blend_config;
 	ops->setup_alpha_out = dpu_hw_lm_setup_color3;
 	ops->setup_border_color = dpu_hw_lm_setup_border_color;
-};
+}
 
 static struct dpu_hw_blk_ops dpu_hw_ops;
 
-- 
2.26.1

