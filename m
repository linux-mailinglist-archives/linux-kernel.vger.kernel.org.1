Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4857D24D2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHUKiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 06:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgHUKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:37:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B0DC06134B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so857124pfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5ysidPZyRWdeECygkw5/tjlDUm7P4m3Td9H5p5iiOo=;
        b=QllXcQvafwdxZtqCOWYNuOpr5bk3EVyJhW4ve3i3V6F8CPxZfPfuCYKOpteZvfbSWQ
         jVDZ9ABjjKcr3jDHnLC+xDtUicUOM8Ld4koytB4iMeEd2VkFkAGxhoX/ZVNmFq4dX7iR
         5FEkIlSTKHlJdiaGljctSN4bguGNRwS27iCXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5ysidPZyRWdeECygkw5/tjlDUm7P4m3Td9H5p5iiOo=;
        b=BsnFUrY+CIwVmC+x377g6u/aY3cWH9+oXGlxIcm8M61Zh9IHfZvDAqg5Cr6zSaw1Eg
         o4hnyXMG6eFDVKvUULbVflQ2cEv/f4qhHtqHvaUPRHxOgQkmqylsLUZTkyHcNQ42+Oir
         y5RvD5Q1mlnfLdSFF3GjgcbPwH/qfGpB+UilXxnVo/8iEoVVtToXQjXIUcdjp03Z3OSO
         S6Qt6t6K8kT1v4YSKysqm+HnrW/DwH0+3y36u29jtUhIXkVlxHh9lLtLrxiFHnL6RPQE
         jYqHOMpofa6gqdj7sLSR5KTyVRjnhbMZp6Isj0jqOax2J9vKzy3DeDT3a+4WFGlyGuwB
         FVAA==
X-Gm-Message-State: AOAM530H+rthf7DODqqGp1AMRRHO2otEa9DsBJCViTBVfYZDAAJjJVte
        BiSZCvK1/DzVOGXbtRYdbYccWUzgqVD1OTyP
X-Google-Smtp-Source: ABdhPJwFeTw+XO7IIO3hIBMzDU1dUX0aLZcDBZNoCjlCGYvip1tLKkM+/8qFTxgpvgudTqGdGsdaUg==
X-Received: by 2002:a65:480a:: with SMTP id h10mr1840003pgs.304.1598006250395;
        Fri, 21 Aug 2020 03:37:30 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id y20sm2081525pfn.183.2020.08.21.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:37:29 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 17/17] media: mtk-vcodec: venc: fix invalid time per frame in S_PARM
Date:   Fri, 21 Aug 2020 19:36:08 +0900
Message-Id: <20200821103608.2310097-18-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821103608.2310097-1-acourbot@chromium.org>
References: <20200821103608.2310097-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance expects the driver to adjust the time per frame if it is
invalid (numerator or denominator set to 0). Adjust it to the default
value in these cases.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 09baac2dbc36..82b04714f750 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -200,14 +200,18 @@ static int vidioc_venc_s_parm(struct file *file, void *priv,
 			      struct v4l2_streamparm *a)
 {
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct v4l2_fract *timeperframe = &a->parm.output.timeperframe;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
 
-	ctx->enc_params.framerate_num =
-			a->parm.output.timeperframe.denominator;
-	ctx->enc_params.framerate_denom =
-			a->parm.output.timeperframe.numerator;
+	if (timeperframe->numerator == 0 || timeperframe->denominator == 0) {
+		timeperframe->numerator = MTK_DEFAULT_FRAMERATE_NUM;
+		timeperframe->denominator = MTK_DEFAULT_FRAMERATE_DENOM;
+	}
+
+	ctx->enc_params.framerate_num = timeperframe->denominator;
+	ctx->enc_params.framerate_denom = timeperframe->numerator;
 	ctx->param_change |= MTK_ENCODE_PARAM_FRAMERATE;
 
 	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
-- 
2.28.0.297.g1956fa8f8d-goog

