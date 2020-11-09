Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9342AC279
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgKIRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbgKIRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:36:08 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB74C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:36:07 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v4so9663597edi.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SsKi06aFz0HTo2Yl+cJME4oxrb6MxPsHXouTbem6RGI=;
        b=BFxRxbsn5xdgpJDxro2qTxpz/f0nOnFDLq48DGON105z4GLn5pgjkZnbCOd9mCkkZJ
         CRI0u8Or6ciO+QGVcFfMZ1RJovaGb7gOfORQp3Yv+95GSQ729HL+ZPkBSlN4p2BoJJOu
         aDMvNBe7de5MnwHxmWaio5Z6fbRhA3U3uIs0GyhYJ5WqAkRnJ/xmylnSx/Nzu2utmZck
         EBlHZp5yLxaMGD2b47Thvh57MEwg3LhvhFAkTNuys+cwXZUGrTHaOJ0uBGtz5nUlpsLX
         9DvrAh/iAVOBaboXZsGireRxpymIWivTswiOZwjPQ09vE3FrOKoslXyiCLTQmHHUGNo0
         0Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SsKi06aFz0HTo2Yl+cJME4oxrb6MxPsHXouTbem6RGI=;
        b=lz4TRLeCvl4G3QeWNjIPAbFnAKSDsiAX945fpZeTpGpzdEPw5Sjz6AA4XOvNDlyXzV
         bJT4awBcnbBqaDxI8GfEgut3v04fWvxL4/GyUMYXrTiwz9nA36j8zPozKoGnxDwEIaTO
         Z5lLx0OiwGwStQ3T5iUkLAGCjxnBB0siuqC9wDcbZibblAHKu23/fM+bdc/pQsCkKlT3
         f/V9NSR7bitJ6RCBFaZcBExmviFv2epdMkDRiyK3dDGIVD1ZihwRij6++uHSdS/v9h4m
         SRsdJJLEAmd6ooE0xOQi/8D8etEAoveB74h/6Mkruey0LhHRxExxnyuuoLtwj9fC1Nni
         +bVg==
X-Gm-Message-State: AOAM533zd1B3/PALb/t+TI3WPuXldq4MIu45iS8KFucUnXu8iS/GPhiD
        ERa48lhTjblRT6pdurm2Sfjf/HPgr/ZmRfsJ
X-Google-Smtp-Source: ABdhPJxJEqEwcqxwZ5dDOkeXSSn849iNUGTNFrtdZ1oAB0tJBm9PPvPsx4rxq4gFloPMZs4n3fi/jQ==
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr17307631edp.342.1604943365785;
        Mon, 09 Nov 2020 09:36:05 -0800 (PST)
Received: from localhost.localdomain (hst-221-89.medicom.bg. [84.238.221.89])
        by smtp.gmail.com with ESMTPSA id jw7sm9123981ejb.54.2020.11.09.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:36:05 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 3/4] s5p-mfc: Use display delay and display enable std controls
Date:   Mon,  9 Nov 2020 19:35:40 +0200
Message-Id: <20201109173541.10016-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109173541.10016-1-stanimir.varbanov@linaro.org>
References: <20201109173541.10016-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard display_delay and display_delay_enable controls,
the legacy private MFC controls are kept for backward compatibility.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 61e144a35201..4a3e8e9bbff2 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -167,6 +167,13 @@ static struct mfc_control controls[] = {
 		.step = 1,
 		.default_value = 0,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_DECODER_DISPLAY_DELAY,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = 16383,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE,
 		.type = V4L2_CTRL_TYPE_BOOLEAN,
@@ -176,6 +183,13 @@ static struct mfc_control controls[] = {
 		.step = 1,
 		.default_value = 0,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_DECODER_DISPLAY_DELAY_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER,
 		.type = V4L2_CTRL_TYPE_BOOLEAN,
@@ -690,9 +704,11 @@ static int s5p_mfc_dec_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY:
+	case V4L2_CID_MPEG_VIDEO_DECODER_DISPLAY_DELAY:
 		ctx->display_delay = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE:
+	case V4L2_CID_MPEG_VIDEO_DECODER_DISPLAY_DELAY_ENABLE:
 		ctx->display_delay_enable = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:
-- 
2.17.1

