Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA52F95EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 23:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbhAQWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 17:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730496AbhAQWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 17:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610922112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Q/nirjyd353laCSIcUJdblTkIhaVs8AOQO2AamTKH0=;
        b=YT2htPgRh3IjSkrigGvxEeBTkLV+rJ8Mmx+1YJXQw7kNz78OUrwTK44vUzqH92aqunqF2m
        i+1BoDAwmwb0OpgcOwrqzW9jM8fWojC1XQGToM9YeCotec/JVn3hp3sWdmhNaAcP4rWXOI
        JovaZnIVj7ki5I6XzZKBrNUJVBiJbpI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-k0KiTRT4MfOzQqVQgeqIvw-1; Sun, 17 Jan 2021 17:21:50 -0500
X-MC-Unique: k0KiTRT4MfOzQqVQgeqIvw-1
Received: by mail-qk1-f198.google.com with SMTP id g5so15151624qke.22
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Q/nirjyd353laCSIcUJdblTkIhaVs8AOQO2AamTKH0=;
        b=Du2kb4HsXo9hqlZx9JGJVLAIAC9yoMRunCaoGlyvnJHpcdWeS98KFoV8FbR7l6VHif
         uOb4hfKbaFdg5gHpDoJ9s+91x3V9FFiuf5ZX6UJgWntbn2SqOrKj7d1c2eABS83WC/jg
         jZ/is3cUfryIAwuJ4t8DVeBj98BIf8qye8Px4iCwM1olDrtUT3t5PIQwoYVXh1eAvzWH
         VafDhOaV/EU2NMZQjyLy8pDNPs4zw7ilVfr4bKNEYLBT0i4OmmDaac7Y1C1Hz/GxAWuV
         z1kq0Z98ojmlZeXu0t3AJP24UA5PyfzsrWDBILYgPdtRrDKcVDHzNnTxF3qQRMGoy9HJ
         5Xew==
X-Gm-Message-State: AOAM533dWNEHNLPLT9ryoqy+4m/JDveWV9QSSz6UE6G7yGTCIcMQtU/r
        TmUTLDTvseADfce6Qv6FWxULiAkHPFppGGZ0W8n81xbVYBCxiQGtGKY4+oxgpJ4pYup5jRNPZze
        q0PqkkWNIcWiw935odcT9EkH4
X-Received: by 2002:a0c:9e50:: with SMTP id z16mr21356529qve.13.1610922110404;
        Sun, 17 Jan 2021 14:21:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLfAViRBC01RcVQ97+1PHfTVCqF3ZzkhqNaMPivdg097DavcqB1qB4Ni4JYwm+u1ckPY0Qnw==
X-Received: by 2002:a0c:9e50:: with SMTP id z16mr21356516qve.13.1610922110196;
        Sun, 17 Jan 2021 14:21:50 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d25sm9674480qkl.97.2021.01.17.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 14:21:49 -0800 (PST)
From:   trix@redhat.com
To:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        hverkuil-cisco@xs4all.nl, yunfei.dong@mediatek.com,
        acourbot@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: mtk-vcodec: fix argument used when DEBUG is defined
Date:   Sun, 17 Jan 2021 14:21:38 -0800
Message-Id: <20210117222138.551147-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When DEBUG is defined this error occurs

drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:306:41:
  error: ‘i’ undeclared (first use in this function)
  mtk_v4l2_debug(2, "reg[%d] base=0x%p", i, dev->reg_base[VENC_SYS]);

Reviewing the old line

	mtk_v4l2_debug(2, "reg[%d] base=0x%p", i, dev->reg_base[i]);

All the i's need to be changed to VENC_SYS.
Fix a similar error for VENC_LT_SYS.

Fixes: 0dc4b3286125 ("media: mtk-vcodec: venc: support SCP firmware")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index dfb42e19bf81..be3842e6ca47 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -303,7 +303,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		ret = PTR_ERR((__force void *)dev->reg_base[VENC_SYS]);
 		goto err_res;
 	}
-	mtk_v4l2_debug(2, "reg[%d] base=0x%p", i, dev->reg_base[VENC_SYS]);
+	mtk_v4l2_debug(2, "reg[%d] base=0x%p", VENC_SYS, dev->reg_base[VENC_SYS]);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
@@ -332,7 +332,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 			ret = PTR_ERR((__force void *)dev->reg_base[VENC_LT_SYS]);
 			goto err_res;
 		}
-		mtk_v4l2_debug(2, "reg[%d] base=0x%p", i, dev->reg_base[VENC_LT_SYS]);
+		mtk_v4l2_debug(2, "reg[%d] base=0x%p", VENC_LT_SYS, dev->reg_base[VENC_LT_SYS]);
 
 		dev->enc_lt_irq = platform_get_irq(pdev, 1);
 		irq_set_status_flags(dev->enc_lt_irq, IRQ_NOAUTOEN);
-- 
2.27.0

