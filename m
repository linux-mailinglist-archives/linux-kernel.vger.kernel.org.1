Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000F62F6178
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbhANNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:04:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:03:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v184so405409wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMjCyJ4LFX2yXOveR+4JmstAFOfGTUFf7mwxezUhrSE=;
        b=VU9ytjDnsJhBQEKU8CcNfn5EcCVMbibvcmMIQSw6rqWNc6nN1Lf1oPsOOgFmwiKBTc
         RrPVWF1HCcyoZ3tDzDgIdYHPj60ibMqmq7v41lcCdLex3eGAfcqZNX3auAiU+HgY4YI4
         y8jR1nV/ehPXzbKO5mBB9omD5EgSVnqYK232Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMjCyJ4LFX2yXOveR+4JmstAFOfGTUFf7mwxezUhrSE=;
        b=RodoLbuhIBELUlSbWeMrqknb8p55+3l1aKm/t+EbxXvWQzvbRW0f9kRsKEU3LlA9pK
         ZN4GT+UHtCVp3mqEHGWkR+QW6/O6IighVLBO+iQRdhTROTKEDce8usUBxqkhWYHhxrlz
         v3BQxkaQyS8snK+5GCcZsxvi16/5cZv2pRfs9rcloDnrrfPVdhe4EFiBuSw86qiRb8S9
         YR2cOkAnxAz/PrcEDShFmr0CAdRqpDGQzfynnCly1IceYewR/aMYSzb7pcRTjC3EcVLK
         ByFrdxpuiIeHlgFP6i1veeoFkghzytMeS6LfXnjrPhj3oJd+a8joGjTjM2Ph2FkWnIF0
         JXCA==
X-Gm-Message-State: AOAM530m3tip57t4WPFBGoZ/j5Qi/+bthjRPIAN36OsbGKRYi7WF6gYH
        sO6ttncMUOoue5FFh/zgzAhKDsR8tm0OiiqVNPI=
X-Google-Smtp-Source: ABdhPJwFrQgrAKlNT+/f/q7vLOej10mKl2NqLzYVqByPSzm1wlk/JVQWuVJ4qCBH9M1ZbeaQlqukKg==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr3952785wmb.124.1610629399701;
        Thu, 14 Jan 2021 05:03:19 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id x13sm9313627wrp.80.2021.01.14.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:03:19 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: hantro: Fix reset_raw_fmt initialization
Date:   Thu, 14 Jan 2021 14:03:16 +0100
Message-Id: <20210114130316.803231-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

raw_fmt->height in never initialized. But width in initialized twice.

Fixes: 88d06362d1d05 ("media: hantro: Refactor for V4L2 API spec compliancy")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/hantro/hantro_v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index b668a82d40ad..f5fbdbc4ffdb 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -367,7 +367,7 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
 
 	hantro_reset_fmt(raw_fmt, raw_vpu_fmt);
 	raw_fmt->width = encoded_fmt->width;
-	raw_fmt->width = encoded_fmt->width;
+	raw_fmt->height = encoded_fmt->height;
 	if (ctx->is_encoder)
 		hantro_set_fmt_out(ctx, raw_fmt);
 	else
-- 
2.30.0.284.gd98b1dd5eaa7-goog

