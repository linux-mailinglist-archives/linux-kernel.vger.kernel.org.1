Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0639F2A49B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgKCPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgKCP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D8C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a9so18973954wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtstZ8Ss1ZAgmytvl8BCDCnRUt17GN9LrR/wkx5bkhc=;
        b=JaziDNI2dZRnNVL5YCwTqVWJum+QZWTUU+vs6VYmxJT7BLEQH5posc6/WC0AWBKwwX
         4EA5q8jb1aDG1Qx8mSIZIvnF38Fmo9qbDB+CflrTNa5NulvbCNZXnBF9VEZQT8KG7DxU
         6+3I7zAk4NLRGqNIWxSsf7NVHdlBanIQn/093/L5uzkRt/gwwkBjtCbRLH8IZ9FOlvIe
         4mAv1E7ipUbKi6Ug07SR2idrs0IX2STzlguTxLvcvRsHMYITCo9255Iv6zU2eRFF1R3e
         NrSz765fBbjXJUk3Nfjy2gOSshWI1nJKMnhi+SZ6rf/XcpwkS7M6bwWro1jkNr6bymOa
         aDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtstZ8Ss1ZAgmytvl8BCDCnRUt17GN9LrR/wkx5bkhc=;
        b=A7u4rJYpotyGgFq0FAwOqU9CvpVmd86e//Jh9Zyj/bbPgN399s3A2FsyqIWeDJUJO2
         XujLvVcVmTUNGKJGC6fI4cZPWNPyDsRsDLqFiyCi7J2k1QvX/Vt4tolZGhCm525nRaZN
         1m2w4+7gDjYoQWr51wYaDNNlCo5HaUeKHtAKaLVlHfY7xcJIy5DFl8fIJAFuf8nkD5p/
         3A7Vpf/gt12Q/sI3Ts5aclitCqLWiGJBGks/JpyE/DC75jz5BTxCNahhNaG8HxQUolbo
         F4IHdrChiBylXuXWL7hgjXFBTriLARH4zv6AH/gnqDYsey0NuJRrGwLdEaZP46P1GkWD
         3AhQ==
X-Gm-Message-State: AOAM5334W5EY5ZQfiRZbg2UXIv9Kmgs1EHKnU4pOr8g/XFyX0qtY+jG3
        9EN9AijdMqtYWrz/X3YZlmgM9g==
X-Google-Smtp-Source: ABdhPJwfFIvO98y22nwny1fM75XJYeVuQtBFhjTRJDvug6VV5vIaDlVpdV8Lsm6ohJKNfWsYSxQtRg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr25707250wre.87.1604417382870;
        Tue, 03 Nov 2020 07:29:42 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/25] soc: fsl: qbman: qman: Remove unused variable 'dequeue_wq'
Date:   Tue,  3 Nov 2020 15:28:38 +0000
Message-Id: <20201103152838.1290217-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/fsl/qbman/qman.c: In function ‘qman_shutdown_fq’:
 drivers/soc/fsl/qbman/qman.c:2700:8: warning: variable ‘dequeue_wq’ set but not used [-Wunused-but-set-variable]

Cc: Li Yang <leoyang.li@nxp.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/fsl/qbman/qman.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 9888a70618730..62b182c3a8b04 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2622,7 +2622,7 @@ int qman_shutdown_fq(u32 fqid)
 	union qm_mc_command *mcc;
 	union qm_mc_result *mcr;
 	int orl_empty, drain = 0, ret = 0;
-	u32 channel, wq, res;
+	u32 channel, res;
 	u8 state;
 
 	p = get_affine_portal();
@@ -2655,7 +2655,7 @@ int qman_shutdown_fq(u32 fqid)
 	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ);
 	/* Need to store these since the MCR gets reused */
 	channel = qm_fqd_get_chan(&mcr->queryfq.fqd);
-	wq = qm_fqd_get_wq(&mcr->queryfq.fqd);
+	qm_fqd_get_wq(&mcr->queryfq.fqd);
 
 	if (channel < qm_channel_pool1) {
 		channel_portal = get_portal_for_channel(channel);
@@ -2697,7 +2697,6 @@ int qman_shutdown_fq(u32 fqid)
 			 * to dequeue from the channel the FQ is scheduled on
 			 */
 			int found_fqrn = 0;
-			u16 dequeue_wq = 0;
 
 			/* Flag that we need to drain FQ */
 			drain = 1;
@@ -2705,11 +2704,8 @@ int qman_shutdown_fq(u32 fqid)
 			if (channel >= qm_channel_pool1 &&
 			    channel < qm_channel_pool1 + 15) {
 				/* Pool channel, enable the bit in the portal */
-				dequeue_wq = (channel -
-					      qm_channel_pool1 + 1)<<4 | wq;
 			} else if (channel < qm_channel_pool1) {
 				/* Dedicated channel */
-				dequeue_wq = wq;
 			} else {
 				dev_err(dev, "Can't recover FQ 0x%x, ch: 0x%x",
 					fqid, channel);
-- 
2.25.1

