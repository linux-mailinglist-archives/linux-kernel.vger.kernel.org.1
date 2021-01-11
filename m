Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21A52F18D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbhAKOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbhAKOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E2C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c133so94981wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqQD8/80d4lI7bJ5BkF04XGNAqEe6coGxChG+Im6UdQ=;
        b=MU+JTSjlB5pP8MpoRRx6svcjs01UzZUhf+aMlFi01hgpEEu6Sxpjj5nM9Izn+lc9T3
         n0mgHNXqxMFFrwUAm+LXFjHV2pcagP4DqlWw53F9n5vueQzIqsGLJbs4zW8ASWGEBs6E
         NEXrC4+uYE63KVWhsd6KDQZdZaFNPqmyJGJ3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqQD8/80d4lI7bJ5BkF04XGNAqEe6coGxChG+Im6UdQ=;
        b=LTT9hwbq4tG0nAY57g5I1mB/sDAf6NsiumykKkyIrV6bQpV+NQulCbNtpS1WtXSbg0
         5+aHZcVmsk50rI2BIX4zgnMn5mj2JLiKO1JQFemeDPmiXQ1tYpCS8fpNkqOf7I3NbItK
         UF2wqSS1ocjuGw+eFYuRheNwoVVw+Npoehxa87ZNM1yT2HM2WM4oSLKvOVMkI+4FCVXV
         GhYvp75udMGMxdPJEg1e4N6VO11U3nbaDKXx3D5lhlYlfnR3/ShA7Ke1y+BfyYdW9iNx
         Qt7cq2LsRycAnEa8E0hrVjm2QURLb/hjOVXCF64UL4oekQ3DNRZnHiGPsUk11XZGVgnA
         CkvQ==
X-Gm-Message-State: AOAM530Q1l+9VzoeCRxWwxMT/Uz7dut8JzAa2l+wxl5SrbVFbmYCoZys
        j3CxaShavVvhknHgUI8yMk2rUw==
X-Google-Smtp-Source: ABdhPJy1Fi5TqRnSQ/AhkZQG5j5NkOX2yRSDqdpuHp2wRpoEfTueibevUrLphrS28hBfrmaaCgr60w==
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr77729wmg.33.1610376889181;
        Mon, 11 Jan 2021 06:54:49 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/9] media: mtk-mdp: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:38 +0100
Message-Id: <20210111145445.28854-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111145445.28854-1-ribalda@chromium.org>
References: <20210111145445.28854-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core code already clears reserved fields of struct
v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
v4l2_plane_pix_format reserved fields").

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
index 724c7333b6e5..ace4528cdc5e 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
@@ -199,7 +199,6 @@ static const struct mtk_mdp_fmt *mtk_mdp_try_fmt_mplane(struct mtk_mdp_ctx *ctx,
 		pix_mp->ycbcr_enc = ctx->ycbcr_enc;
 		pix_mp->quantization = ctx->quant;
 	}
-	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
 
 	max_w = variant->pix_max->target_rot_dis_w;
 	max_h = variant->pix_max->target_rot_dis_h;
@@ -247,8 +246,6 @@ static const struct mtk_mdp_fmt *mtk_mdp_try_fmt_mplane(struct mtk_mdp_ctx *ctx,
 		pix_mp->plane_fmt[i].bytesperline = bpl;
 		if (pix_mp->plane_fmt[i].sizeimage < sizeimage)
 			pix_mp->plane_fmt[i].sizeimage = sizeimage;
-		memset(pix_mp->plane_fmt[i].reserved, 0,
-		       sizeof(pix_mp->plane_fmt[i].reserved));
 		mtk_mdp_dbg(2, "[%d] p%d, bpl:%d, sizeimage:%u (%u)", ctx->id,
 			    i, bpl, pix_mp->plane_fmt[i].sizeimage, sizeimage);
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

