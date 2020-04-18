Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0D1AEB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDRJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgDRJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:11:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99960C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:11:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n6so1132738ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1+0lxBk92Z4FV+tuRf6x7090CWSvwjw8uGCZ8vNaets=;
        b=XFsyyjgUyNwmjpheTqxW9aYsSQYJ0lDOzuKTUzlVAn2MmCPhJDf4AYtrnJ5n8dLHEQ
         9SSh8T7G+R8Z7OIjaIVm3hDS/o1/b+2tE6Ae3uSkU4ARcNccdDvnK2YsELvKFu/CtRIE
         Z0EPEbA1ZLdARCMDttcWceZMjCTreljTP02DMeUfoy3TFq55oSiT+5KkUGvuN17FmajN
         Z5PI/PH6HrURbRxJ5u7UNS54wM+fIbG9r4lmRekbviiN0m5O+LyIyWsUmmGev+6rf8g7
         9GYKz6YDH1wFHcVEimSZ7fyXizRVTMwaq2OqsiNK91LBcYzizguXPsKmwhM/XemtYWgM
         vTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1+0lxBk92Z4FV+tuRf6x7090CWSvwjw8uGCZ8vNaets=;
        b=Vc/+a2Ovh8Lnth1EQ/JexcGtK60zmLB1Y1oFp9u4HVXgyQFpm8snLxlOIsKBTGkOF8
         dWFBLn4utmm8Fpm3r2rW7m1UJ1OxAZbk1CVxvCaJXWaC24EQPG9s0feM3qRx4i3YRIwA
         //rUDcimdpILQYf3nFSwCKioTBk511EqwSp7Bxu98Hm7kZSOg10YdYC25oWebCts/PlL
         9Op50ROs/N1lIc5d2UUctI3IDSbiH8HEWoG/VM15tJJRSsb7n6CUClHhcAMZhHzTiLTd
         6cY+0AVPGi5g9o1O9gjK42EBjbrxCRXrnsrkS65V1A2VGJkMbs0+zM6OPhClhXR3XMu4
         ZnLQ==
X-Gm-Message-State: AGi0PubwPx892mKgygWR6pYKRYYt7YSZivWP8rmCjwDlPi9E3V6HIArV
        /YQdGAty86IlfCluKcUAtF/fYw==
X-Google-Smtp-Source: APiQypK1l4oogJYB1BPqNzQ+g7PTmKPPdbmtyfUaVP+asaNbzm1SJrR5TaagxWdlGFz7rLKSu9ndtQ==
X-Received: by 2002:a2e:6a0e:: with SMTP id f14mr4577280ljc.102.1587201081939;
        Sat, 18 Apr 2020 02:11:21 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-142.ip.btc-net.bg. [212.5.158.142])
        by smtp.gmail.com with ESMTPSA id 25sm20114469lft.68.2020.04.18.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 02:11:21 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: venc,vdec: Return EBUSY on S_FMT while streaming
Date:   Sat, 18 Apr 2020 12:11:06 +0300
Message-Id: <20200418091106.28370-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the v4l spec s_fmt must return EBUSY while the
particular queue is streaming. Add such check in encoder and
decoder s_fmt methods.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 8 ++++++++
 drivers/media/platform/qcom/venus/venc.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 527944c822b5..7c4c483d5438 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -276,6 +276,14 @@ static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	const struct venus_format *fmt;
 	struct v4l2_format format;
 	u32 pixfmt_out = 0, pixfmt_cap = 0;
+	struct vb2_queue *q;
+
+	q = v4l2_m2m_get_vq(inst->m2m_ctx, f->type);
+	if (!q)
+		return -EINVAL;
+
+	if (vb2_is_busy(q))
+		return -EBUSY;
 
 	orig_pixmp = *pixmp;
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 3d8431dc14c4..feed648550d1 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -357,6 +357,14 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	const struct venus_format *fmt;
 	struct v4l2_format format;
 	u32 pixfmt_out = 0, pixfmt_cap = 0;
+	struct vb2_queue *q;
+
+	q = v4l2_m2m_get_vq(inst->m2m_ctx, f->type);
+	if (!q)
+		return -EINVAL;
+
+	if (vb2_is_busy(q))
+		return -EBUSY;
 
 	orig_pixmp = *pixmp;
 
-- 
2.17.1

