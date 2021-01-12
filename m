Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE22F34DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392672AbhALP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392630AbhALP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:56:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B54C0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:56:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1so1838709pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H005wFskUm0fffFd0zmrYHQ7pBh0u+Y3LHdyVNVPfGs=;
        b=Fsb/xyI5hBzsbnvjIKQPUJusZUB0ijs/BvhAiLXDDLwuu8e3f4DJlnqwPnPgktHeU1
         F5YciCW40jWjKtP1VYAPjT1V0+rDoyueeSrsBvfr0vJjHrp7/VsELEdi/LtAcvVTGRvL
         E/RIhjo24Ip2tJGvJ4vkoIyF60V7nmwhgF3NFuLFAe36h8ZHmFRf+Tg15/I+qUyRzjus
         pbJt4tr4HTt3g+pc2sEbkqma+RnlpKW7o5q2KK68zG+goGkk8F5fkJg4mK4mSiYrQ8F0
         AcRWc8baEtwsmfzirP1A4OFuS7V/By/HMUxquuciCa3UbDF9fbVR57YtCHnaH9PnGaue
         ucoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H005wFskUm0fffFd0zmrYHQ7pBh0u+Y3LHdyVNVPfGs=;
        b=IUEO8jZrUGy3UUidDT7CCa8O+X+TpntRnRwvAebiU9IblB5qB+y8s290H2pe4oe7Cr
         ziU9AyEfajk99A5FvydiXsaiXu50n7HHtTKmHFsHSLzihWROZJmhCoFizuKxfXQJO28o
         /veZwaKbNTc4KpE0Olb1hB10c7j6zptlBwTWPQczn/5mDQopk3VEABj5W+SSrAwf1V1r
         rCKJCzG6rH0oaGbx7tOfSEXTl8uifi4hJ65oqYL5zb8ZyF55YDbO+0qmFJxrKkiLI+LL
         UO5ItLtTFg6N3ZwI3ms9grrPJU+ldjVRlDIRRrqtKtmuPD+ruJWRap3db5qMx8rf7k3T
         MVRQ==
X-Gm-Message-State: AOAM531OCJ45ozXlRjzLSdyafMRGEYhJkwet9UUUFBDbFvxQ/V1Mob8f
        ZFdw8uX2sPJ1m/XLmWS+apXKpA==
X-Google-Smtp-Source: ABdhPJzGctaYgQNBR0F36gr9a4FArKjUNS1hB8kiuKu0TXtSNzkNQ3L0JUOYu27MDw5eCInpvxTrvQ==
X-Received: by 2002:a17:902:8203:b029:dc:3371:6b04 with SMTP id x3-20020a1709028203b02900dc33716b04mr5348424pln.81.1610466964538;
        Tue, 12 Jan 2021 07:56:04 -0800 (PST)
Received: from localhost.localdomain (ec2-18-163-5-123.ap-east-1.compute.amazonaws.com. [18.163.5.123])
        by smtp.gmail.com with ESMTPSA id u68sm3516417pfu.195.2021.01.12.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:56:03 -0800 (PST)
From:   Li Feng <fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH v2] blk: avoid divide-by-zero with zero granularity
Date:   Tue, 12 Jan 2021 23:55:02 +0800
Message-Id: <20210112155502.426331-1-fengli@smartx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112152951.154024-1-fengli@smartx.com>
References: <20210112152951.154024-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the physical_block_size and io_min is less than a sector, the
'granularity >> SECTOR_SHIFT' will be zero.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 include/linux/blkdev.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..ffffb04ad113 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1485,7 +1485,11 @@ static inline int queue_alignment_offset(const struct request_queue *q)
 static inline int queue_limit_alignment_offset(struct queue_limits *lim, sector_t sector)
 {
 	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
-	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
+	unsigned int alignment;
+	if (granularity >> SECTOR_SHIFT == 0)
+		return 0;
+
+	alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
 		<< SECTOR_SHIFT;
 
 	return (granularity + lim->alignment_offset - alignment) % granularity;
-- 
2.29.2

