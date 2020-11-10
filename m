Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9952ACBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgKJDjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKJDjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:39:22 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 19:39:22 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so4634844pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 19:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5l+aTVwgSsK2O96++5nt0utffEQmGVX4LPCwmYVddCw=;
        b=tIbfwY96mQDbmX4I6d+ydhVx5jO2Eb5JxWv5EXAbTmfuSTaYRFnsw0Q3SJJWXivoqf
         7F0nRutTNIInz12E+SE0vdsTrxDpAgwaQ2kTh9LroZFWBP6dxrLCAdf0aXa8/4qg+XLK
         Izq9EusyNaZfOmT43GCPD3JDU4xT11D8ShssdqkV8ypg65Kbd5bVXNTv/CgAsF2UDyf1
         xW5BC3FH4Mbwv5sLGYan0BwkRn0Svhe/VwxMF43BLBFJp1A27T/ewUV5zvX9jlpxBl7h
         xQMHpaVw4IgK7sMT+aCBe3ltBVbXMZxjfyv+IO9a49QXeZSek52I/5TeO7W3+v32Lw+6
         PnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5l+aTVwgSsK2O96++5nt0utffEQmGVX4LPCwmYVddCw=;
        b=a66BRkhu93ukhYI56FweKT4oeH2RfDejNdVa83y5H7CUS+72lG2ZXfBX1sZSWqMwtK
         yFWe20xttDJWiHUJqykkVseqMYJZp+wrZsVCbuavfmoJHgnJiHNZTDOBdzZyfv0FsitE
         v6G67z5cFz4mQTtYd7nydsAsazPvslPNZfbwDkXQsJajF6OFmzRmHNjP4us/jY7cfoaV
         9KInystP4NXjsAZWSsDeZY29cpU5l9g4NsilfCNeZK66U6fcZVTJQmkBYXOTEWdYEOfN
         NUNgjxcbMR2OYA/00aNzhuGfaEFGv2eqmym4DR7KRWzD7EOgoZNNoP/URd9oeKrpx4d5
         zQEA==
X-Gm-Message-State: AOAM533K7V9JuchSC7qZXYapTOr9C8NKd25tbZKYBqKhJDRETnjVVpSo
        bXO1bUjfX4SFa6xOI0nTaxUO7xVYy4n0
X-Google-Smtp-Source: ABdhPJwudf7YkzrzJBdo1+dwCzTTS7e1ImPFgTbwm06lU379OuYUEn1v/0WX3nqqmGTEIhSR/b1RMA==
X-Received: by 2002:a17:90a:d182:: with SMTP id fu2mr2744446pjb.145.1604979562020;
        Mon, 09 Nov 2020 19:39:22 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id e23sm1060735pja.25.2020.11.09.19.39.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 19:39:21 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] coresight: tmc-etr: Assign boolean values to a bool variable
Date:   Tue, 10 Nov 2020 11:39:15 +0800
Message-Id: <1604979555-20619-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle warnings:

./drivers/hwtracing/coresight/coresight-tmc-etr.c:957:2-15: WARNING: Assignment of 0/1 to bool variable

Fix them by assigning boolean values.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 714f9e867e5f..525f0ecc129c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -954,11 +954,11 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		dev_dbg(&drvdata->csdev->dev,
 			"tmc memory error detected, truncating buffer\n");
 		etr_buf->len = 0;
-		etr_buf->full = 0;
+		etr_buf->full = false;
 		return;
 	}
 
-	etr_buf->full = status & TMC_STS_FULL;
+	etr_buf->full = !!(status & TMC_STS_FULL);
 
 	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
 
-- 
2.20.0

