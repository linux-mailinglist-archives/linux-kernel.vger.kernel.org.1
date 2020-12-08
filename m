Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3316E2D3223
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgLHS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:27:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D8C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:26:54 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so14662602pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7D2HqY1JKxrM7aJb3nroXXXqA1ZMjjPluN2mhdyvKo=;
        b=QbTqa4XVzzXAdXNpa304Il124Uo61WdscqLgPT4RvN2oBSw7XMUcdFchGwydvmOHK8
         wFHFTYFgneEDnFusai3K1pwLCEyy4idPwbG7Oc5fI9A2yg1VCATK90PA3ehXaDSs0WzA
         gGWIZj7KGgLwxqHhjBaiKYNy9PIj/lxZUOI9eoR1NyU2UdncGw+TsX5UQR8Khh8As9VI
         ro/Pa3KOJNYa7/4mSXEG07SATh67bSz4azEr/QWA4WRm3rh8UnTWIbxzpYpD6wTxIyn9
         CJ0yvGgKp3u/fe9Hcy+/ex5Pwr4S21x39f/H/c2678qPzCCqUEujGGbQGqpyvCQz5L/G
         +7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7D2HqY1JKxrM7aJb3nroXXXqA1ZMjjPluN2mhdyvKo=;
        b=XW49Y2xx46uMMrYWc+WlcOoPsuK+WEfNzg3GzrbGk1NFNyE93QSxm+qflJNcfGZxfr
         UUMbia7DbbUQYqTY7jqrHLb740EVGfNrB0R785f/Y0uWlZo6ZrIpQyuFTSu1dpTgW8CJ
         NvffFqR94merrTTrT2KNM5DSi+4Io1RNDrukjWKvzSgp0qEuGVg0Vi89xCZWyITHuHMH
         sWtiymS7oqLUmwABpFHp9wG0dCJkoC//h4w/Y5TI9QYA/thZyNaPf/MF5kxkoSNvXTNB
         JSDEmQt3pVFxqv7AvE/sEeaA3odnLUr3jpsPboMTkilHN0YX0XQQMKfBCrvYy2M/8e3F
         83EQ==
X-Gm-Message-State: AOAM5328wML026OZFY6N9oqeQMCOeHA88ChKLTV66PYDv1Nq8YUf9vCW
        mQ67Y9X5DudUW/GgxL8y8hRbkQ==
X-Google-Smtp-Source: ABdhPJwCvA4V7v/PzB3mEiWSPfELFIBTwlVNQBw2r0gmO8pyFyUjFSsGqQObB9PXeSm+MxptpaeXnA==
X-Received: by 2002:a17:90b:204:: with SMTP id fy4mr5374684pjb.57.1607452014185;
        Tue, 08 Dec 2020 10:26:54 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id nm6sm3966801pjb.25.2020.12.08.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:26:53 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] coresight: tmc-etr: Fix barrier packet insertion for perf buffer
Date:   Tue,  8 Dec 2020 11:26:49 -0700
Message-Id: <20201208182651.1597945-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
References: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When the ETR is used in perf mode with a larger buffer (configured
via sysfs or the default size of 1M) than the perf aux buffer size,
we end up inserting the barrier packet at the wrong offset, while
moving the offset forward. i.e, instead of the "new moved offset",
we insert it at the current hardware buffer offset. These packets
will not be visible as they are never copied and could lead to
corruption in the trace decoding side, as the decoder is not aware
that it needs to reset the decoding.

Fixes: ec13c78d7b45 ("coresight: tmc-etr: Add barrier packets when moving offset forward")
Reported-by: Al Grant <al.grant@arm.com>
Tested-by: Mike Leach <mike.leach@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a31a4d7ae25e..bf5230e39c5b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1552,7 +1552,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	/* Insert barrier packets at the beginning, if there was an overflow */
 	if (lost)
-		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
+		tmc_etr_buf_insert_barrier_packet(etr_buf, offset);
 	tmc_etr_sync_perf_buffer(etr_perf, offset, size);
 
 	/*
-- 
2.25.1

