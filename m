Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9B2656B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgIKBgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgIKBgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:36:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D8C061573;
        Thu, 10 Sep 2020 18:36:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so5991993pff.6;
        Thu, 10 Sep 2020 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tgNahNYZMXrtXJeygjsMjzSrNWcxFP6xVcE3T4mcxQI=;
        b=krwr8eUejyOxlLJDdQubB7ACobn+yVeTllJsTrtCQSgf1ac41zcVHcDEj8sEt64Vs3
         DyMVltAnWqd+570rbrM+YYpmcESjuwou87ng5go8hyKn+a8ldVzon1mH43t9s4piUnLG
         pvj0zRbPjH0YPelzR7RSR8WsuKd52OvwXE51Y6pvgqqaGc0BdwAdoCblpRswW3cyfCTS
         j9dQIcfM/hfLufRkCgN0dIaahtF4QUD5pKvzf6dKtZ4EqDrROc7JIUVp3j6jR3rlpvTv
         ztjp2E9C7C1h2CRn+kqa2X/q2H/f5GWZ9FE0oNixFWxfKTyemA31lKJesUVKbVzYXi9I
         RBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tgNahNYZMXrtXJeygjsMjzSrNWcxFP6xVcE3T4mcxQI=;
        b=s9MdK+Svvj2fIoHsy6NdGqGx674OiOBva2m369X+CCBbwH4BW+TKR+YxwOuGdIZ3IR
         t5SQFSgVfyCKDXOPzvkwWWagd4eOq7HWjxoYxiTKEtRfaG/ueVAYIUS7WcV8FGIg18du
         F9BKAtrigN1XtLmQAoiq6tN91OjjlMU46rWg7xkq8IUkkGR7DHtJqwoLX6sz855cQIFn
         hHcouRtVE+XEBNOp+RyvaBA8LnZB32heezffqF8VVeJR24tHew6cF6QovTH+8/adTGOv
         IHzhuo3h/HRDwodAyHHjQT+Z7a5aNw4DNNbBV1gT/wVb1IPgyAdXKjRgaNkj0C6mGTWJ
         /Wxw==
X-Gm-Message-State: AOAM531tqCgNfWHKdF0vqXlx8auNMpuJPz+fJibRN0FJWchTspk9fIWQ
        a4izn/x58WAF6IMajUyl6X/Q3UxTcAw=
X-Google-Smtp-Source: ABdhPJxmpvfBvedNBMBi9uwqLUpcsx12AwdlkASNXqkxCT5l4tYvZbMRwKDXdnU+d574Ry+yP8dtMg==
X-Received: by 2002:a63:d512:: with SMTP id c18mr6475530pgg.387.1599788197927;
        Thu, 10 Sep 2020 18:36:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-52-163-24.us-west-1.compute.amazonaws.com. [13.52.163.24])
        by smtp.gmail.com with ESMTPSA id l9sm245112pgg.29.2020.09.10.18.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 18:36:37 -0700 (PDT)
From:   Xiaoliang Pang <dawning.pang@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        matthias.bgg@gmail.com, swboyd@chromium.org, yuehaibing@huawei.com,
        tianjia.zhang@linux.alibaba.com, ryder.lee@mediatek.com
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dawning.pang@gmail.com
Subject: [PATCH v3] cypto: mediatek - fix leaks in mtk_desc_ring_alloc
Date:   Fri, 11 Sep 2020 09:36:19 +0800
Message-Id: <20200911013619.9809-1-dawning.pang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the init loop, if an error occurs in function 'dma_alloc_coherent',
then goto the err_cleanup section,
in the cleanup loop, after run i--,
the struct mtk_ring rising[i] will not be released,
causing a memory leak

Signed-off-by: Xiaoliang Pang <dawning.pang@gmail.com>
---
 drivers/crypto/mediatek/mtk-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-platform.c b/drivers/crypto/mediatek/mtk-platform.c
index 7e3ad085b5bd..ebb3bdef0dbe 100644
--- a/drivers/crypto/mediatek/mtk-platform.c
+++ b/drivers/crypto/mediatek/mtk-platform.c
@@ -469,13 +469,13 @@ static int mtk_desc_ring_alloc(struct mtk_cryp *cryp)
 	return 0;
 
 err_cleanup:
-	for (; i--; ) {
+	do {
 		dma_free_coherent(cryp->dev, MTK_DESC_RING_SZ,
 				  ring[i]->res_base, ring[i]->res_dma);
 		dma_free_coherent(cryp->dev, MTK_DESC_RING_SZ,
 				  ring[i]->cmd_base, ring[i]->cmd_dma);
 		kfree(ring[i]);
-	}
+	}while(i--);
 	return err;
 }
 
-- 
2.17.1

