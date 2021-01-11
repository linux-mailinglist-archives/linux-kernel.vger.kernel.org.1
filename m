Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C62F0B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAKD4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbhAKD4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:56:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B555C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:55:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t6so8825118plq.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPpO7uwACT3qF76CIRKljdkA+kPcxYirzS1ReRG4ryw=;
        b=D7iHpQeGTDnVoH9/flTLwTFSYaUm54qf7IynZXyHFYm720oL5f+7+tRKw0bOd5ce3f
         9mT/lB9YGVKtFHhginEetjesTh/GKxEIr8C9xswUxLb9ioPmFPCo1cNEFgvR7JStEy/V
         sgrH9gmOYhIeWuPBNHcUGche0qKNI5OcIzmw/EKj+MpCZDoUef1njI6jxlkHFwL2XDab
         za6ybei3hJjcCmbI8ASFrpQocT7XjVKML35rQgxgJE/C/5orYnlEW7qliqYx1fRbo8NG
         tDjBmKDVzUsau0SKYdruz5iCn9USoGJDkb0VsGwgnVrsbYTInc3gDdRqasXpRrRY8+jt
         tgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPpO7uwACT3qF76CIRKljdkA+kPcxYirzS1ReRG4ryw=;
        b=S967zg5612nWUrjf713pOSRzJw85f0TtZRDfpCR0h0gZgcrBZGadfb+2b9T+MRtLM5
         OlJPvrrwbGrca897D7h8rZ728wACBs5oErZsiJ9gOcu28+ncdGglIIYmq+gP46fOwyzR
         5mWY3xspf6t6zOvTeaxnshmpNcgKtQRurGylf/veGbeklHKdPG8D2YslzsfE2jhk0Xfb
         VLkbgmajWmGmej7v10A5AIy/Y0e8AfaZNcQXLaYPnwhPwr2iP9LLOv0dwUxe1SLCkP1w
         nP37s0KP0hwouWeTBx/9yML7nwqpDawUx0Fwq8A0QCWdqnceiQZ48DkOjlu/KDABx+zj
         ggoQ==
X-Gm-Message-State: AOAM532WdAvuWwWDyk/AkWGH5oKvkoWPvaPh9vwAO7b9NnUZb8cnZBht
        m1FWf15ixFChMh3U2tZs7iqD8VDCLgKaIg==
X-Google-Smtp-Source: ABdhPJwl35ZrGzmHXShiHiqPQiBkrSw7ny6eJKPY4CSl86weSLiskU4c5Wq630Qbbp6ZFqn8qyiYcA==
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr15990966pjb.136.1610337358822;
        Sun, 10 Jan 2021 19:55:58 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.9])
        by smtp.gmail.com with ESMTPSA id o32sm19187816pgm.10.2021.01.10.19.55.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 19:55:58 -0800 (PST)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Subject: [PATCH] mm/vmstat.c: erase latency in vmstat_shepherd
Date:   Mon, 11 Jan 2021 11:55:26 +0800
Message-Id: <20210111035526.1511-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

Many 100us+ latencies have been deteceted in vmstat_shepherd()
on CPX platform which has 208 logic cpus. And vmstat_shepherd is
queued every second, which could make the case worse.

Add schedule point in vmstat_shepherd() to erase the latency.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Reported-by: Bin Lai <robinlai@tencent.com>
---
 mm/vmstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index f8942160fc95..b538199883b5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1953,6 +1953,8 @@ static void vmstat_shepherd(struct work_struct *w)
 
 		if (!delayed_work_pending(dw) && need_update(cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
+
+		cond_resched();
 	}
 	put_online_cpus();
 
-- 
2.21.0

