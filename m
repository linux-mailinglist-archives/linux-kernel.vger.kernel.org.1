Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0256297D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762391AbgJXQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761918AbgJXQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:35:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC5C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 09:35:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so6421808wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ER8iR0n3TP0B50wH2AMHoifIBM+NeyH/1BCBaFlBLbo=;
        b=WnKcgYaDxVABnebEyKyc17XeuY1aZnNqlqYonooOM8bR5CB1mAAI79mFikVohrBiPP
         88324mr04/G5u4VQ9pAknsne5ET+JdvCCMJnV3WPitcZTLPd87Wjkz8IBmSNsp3/KKPM
         Z8UO8uj7iBqCZniPfk/rb1DkG37OpqZf4LD1PN9CvPHY8iEsWinPQX07Ejh4B7nyzJ4X
         AYbgA50xcZMZHTPJHcjcI44wH9vtGdPVIe4qn25yOV8IE+tHqehTs4n7/S03RkExwPRp
         2VzvRxCyudMqRwND+fh5c25rRqrc0LRLmhcBqKTp74LTd4aVk1gUMmi0Iu2GQ/X36p/8
         /E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ER8iR0n3TP0B50wH2AMHoifIBM+NeyH/1BCBaFlBLbo=;
        b=kxdFXsc7ocJjYylEFV+7duJG+AvtO9PY4Pk/lpPPjM0XupliYgQc0viDp7CEjq7dNJ
         twelHpLOAsPrgdS5R70jG04wclmMDTlmkQ2L3YxyvfRnlk5blbbQ5jJu63J+onxf989U
         pJfGepNue/ktcSv7NXFaBTfuz4p5Kyou/zy8VUbxnXm+nWjKVQgLniFceLBOWjzyzUx5
         +OS6pNt72+HZ8YJKUlXNy5aOahR8fzrFLcXB437HX18Rq017yxb4LSRbNckbLEBPCqZP
         kKyyMg9NIpYwxy2GQj2qYkh78tFqVyG22oCf94f0xWRnLMdBeF+EnNYReklBv8rfrllI
         6/tA==
X-Gm-Message-State: AOAM5327WQIwQ6NA9XAYPNPljn2HS7+2tUb2EFxEiDR91/KHQQAE3r1O
        g3ATfZg/nYHGw1/IdSU2x/wkvg==
X-Google-Smtp-Source: ABdhPJx2DfS9bYx7Fu/fpbSrjDBlTDv4IxMusvktM3Bls0i/NIYx9AUAK4UQ1fmnDrQv9Jnvj3pIsw==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr8165021wre.13.1603557321197;
        Sat, 24 Oct 2020 09:35:21 -0700 (PDT)
Received: from localhost.localdomain ([84.238.208.204])
        by smtp.gmail.com with ESMTPSA id z6sm13126202wrm.33.2020.10.24.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 09:35:20 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: venc: Fix default capture format
Date:   Sat, 24 Oct 2020 19:35:09 +0300
Message-Id: <20201024163509.22246-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default codec after driver open is set to be H264 but the
instance format for capture is wrongly set to H263. Correct this
to H264.

For regular applications this is not a big issue because they set
the format through S_FMT but for example v4l2-complience does not.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/venc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 178e034769e8..4aedde172c83 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1029,7 +1029,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 
 static void venc_inst_init(struct venus_inst *inst)
 {
-	inst->fmt_cap = &venc_formats[2];
+	inst->fmt_cap = &venc_formats[3];
 	inst->fmt_out = &venc_formats[0];
 	inst->width = 1280;
 	inst->height = ALIGN(720, 32);
-- 
2.17.1

