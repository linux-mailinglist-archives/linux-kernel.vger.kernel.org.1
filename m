Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC962C4DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbgKZDIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbgKZDIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:08:52 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029ECC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:08:52 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so502011pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atnJehQZVO119pd4VO6r7q8kYsvyqoBTmsMlSh7A/i8=;
        b=BM3vd/ZFTSIIrKiVzBBNSfoocvC2mblhZ+0r6qJV9fNEKYFCP90dXn3R9CA4G5/2pW
         C99fiMkTeWf0gmDuqNgO58YNoGNW1I2ngQc3mvSf6PCpZpMlhxlsTxuUVEldMDeg00F8
         f2LEf6I/A7CjN2hp8bOumSlFwDFEcFucwQ3L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atnJehQZVO119pd4VO6r7q8kYsvyqoBTmsMlSh7A/i8=;
        b=LBTWk8TsA+X0oYqif9FO/xRD9JsX3j7jb3u6VIiva9ZQGfCFBo4rnBqbB2mJ3HqZjF
         qUThc7FmsOFwbUqRNM3+BLuAVjcqhvVjrFuSYd80hyHt/kV/4JSwudXr43AXY4qSiT9b
         hPuNC/nuB1r4cJuvciZJXlqRZuWOLjfF6m+OQ+KQq8OlsXNeEZFeN+UvIkcK5V+62g7r
         Q2OwGyuP8ARzknDQ+1FiD6U0dBATSl1w9SFjIZ1ab6xA3DKv8J+j7LMQI0kd8Q2iD5/i
         oslEgTHaGFwsFocUWcKz2B21kJEl1OLiyowseB/+D08UVD7dhXmzTulr+d7Fwc+W5Niq
         3xXw==
X-Gm-Message-State: AOAM530NyeIgcD+Ik5+JzH6UU2NKpSfRhQJjQ4X4bDI1dNdj83RznQPC
        5d+mc4Rg2up8sQ8DsO5cf09mJQ==
X-Google-Smtp-Source: ABdhPJyAC2YiZ6o3LkjuCB38jzADK3Pw3TNqQRc+UnVcBfB1j9l5XRJ1Br9UH0oCUYWbT3uXJ1Z9ww==
X-Received: by 2002:a17:90b:30cb:: with SMTP id hi11mr1119711pjb.94.1606360131611;
        Wed, 25 Nov 2020 19:08:51 -0800 (PST)
Received: from localhost.localdomain ([120.152.32.152])
        by smtp.gmail.com with ESMTPSA id y9sm4323663pjj.8.2020.11.25.19.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 19:08:51 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Evan Benn <evanbenn@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mtk-vcodec: Fix order of log arguments
Date:   Thu, 26 Nov 2020 14:08:42 +1100
Message-Id: <20201126140839.1.I723c6846bc6913bd0831a78874aa767dcbdae470@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Evan Benn <evanbenn@chromium.org>

---

 drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
index a3c7a380c9308..785ec0df445ec 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
@@ -27,11 +27,11 @@ int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx  *ctx, int command,
 
 	if (!ret) {
 		status = -1;	/* timeout */
-		mtk_v4l2_err("[%d] cmd=%d, ctx->type=%d, wait_event_interruptible_timeout time=%ums out %d %d!",
+		mtk_v4l2_err("[%d] ctx->type=%d, cmd=%d, wait_event_interruptible_timeout time=%ums out %d %d!",
 				ctx->id, ctx->type, command, timeout_ms,
 				ctx->int_cond, ctx->int_type);
 	} else if (-ERESTARTSYS == ret) {
-		mtk_v4l2_err("[%d] cmd=%d, ctx->type=%d, wait_event_interruptible_timeout interrupted by a signal %d %d",
+		mtk_v4l2_err("[%d] ctx->type=%d, cmd=%d, wait_event_interruptible_timeout interrupted by a signal %d %d",
 				ctx->id, ctx->type, command, ctx->int_cond,
 				ctx->int_type);
 		status = -1;
-- 
2.29.2.454.gaff20da3a2-goog

