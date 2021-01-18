Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CADA2F9AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbhARIF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733166AbhARIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:05:53 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED60C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:05:13 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id e9so4047310plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EVzoenPv8H7dYCyIKF7TOy5n3fEguS66BXhZey1tjI=;
        b=LKdtGTm893C1HF7CoOyGb81h63hRw96/smPguJTmfSDqF2sa2IUiNXY9WwcBLzNDuP
         55zG/106NZkmX2BAgkaNSvuDefC5ZHxi/s8kDrYLfAZSF4N3g0rU2rC/oEOJULpGStnX
         i3GI6/uX6ScVLIQDRQDu3QYmWYKpOVsGynTgSI3KDlzZRZKdxW9CrEj2onWaZerrC6QJ
         FKZKH1pCoW8aqgiL+vTkmSQ2XYYkCFRxayx9PJJbU37Kp2w1vFi8Lqvr9THJK/HZdRkU
         EAEeMQl9Kka2O+JCxRLdbtqhrblT/XZajQvzzQqhAFVDB+NukUY0trNP33esddEfh1/V
         eL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EVzoenPv8H7dYCyIKF7TOy5n3fEguS66BXhZey1tjI=;
        b=FLVb6PZUwpODpZANkr/oN8XH+6WXuWoDKmf6S3rEK81AO0vYigHpHZpCajoyGNjqbS
         g60U1FTLT9W32BW2TsR4ox3bESIbT0quvJ1IjaCJA6KGPIcHGsPdm0k3taAtFkfeck12
         LJmdSV5m1qP6Hx+QplyMTnFCPeI4JiTOQn2QQ5vsDKO9o9Umb/DctL0Qo08DmbK/dt63
         PjcLbdD9xgJTU57vObgm6VnwPFo65nSh9a19dztAQKZjjaMi9frN5KB/3iziD+c0+CNd
         CInh1ipOffCnPPNPvuBO/lF7vA/jm9w5pUqbzPgTuR/SoY6bcUENXw1kRbmAH2Qr8VY9
         ASxw==
X-Gm-Message-State: AOAM5321GyOFLOsibrn9bAkPfyClW5E1VsJE+QEDuBZ21cc4FKHRXRs6
        ifPk6NvfVLQs39sC9gJ/CTVhBQinARs=
X-Google-Smtp-Source: ABdhPJzmoNMX3Fix04AnkO5H0on0INGwbUknpHeFiaHkIl7dygUyAWLxhsDoy8bBBxVNcjCO3b9dCg==
X-Received: by 2002:a17:902:d50b:b029:de:675f:5b39 with SMTP id b11-20020a170902d50bb02900de675f5b39mr17871756plg.68.1610957113109;
        Mon, 18 Jan 2021 00:05:13 -0800 (PST)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id j6sm2545696pfg.159.2021.01.18.00.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:05:12 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] workqueue: fix annotation for WQ_SYSFS
Date:   Mon, 18 Jan 2021 00:04:55 -0800
Message-Id: <20210118080455.33499-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

'wq_sysfs_register()' in annotation for 'WQ_SYSFS' is unavailable,
change it to 'workqueue_sysfs_register()'.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 26de0cae2a0a..d15a7730ee18 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -311,7 +311,7 @@ enum {
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
 	WQ_HIGHPRI		= 1 << 4, /* high priority */
 	WQ_CPU_INTENSIVE	= 1 << 5, /* cpu intensive workqueue */
-	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see wq_sysfs_register() */
+	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
 
 	/*
 	 * Per-cpu workqueues are generally preferred because they tend to
-- 
2.25.1

