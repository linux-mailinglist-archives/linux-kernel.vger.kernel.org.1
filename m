Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1026A4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIOMTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgIOMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:07:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F398C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:28 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so2940962otg.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=env5k57Q3iDKc/itBKH8quADcpsLZfJkDZ1gvdFdfhQ=;
        b=oi9suBhZHifrZJZobgVzg01Ov+w+BwXTSay5uu7jGu5TSv6qHHUwWyUMslm68trKNH
         odDvETXxfUwVLL/o4nrW4a7yjOlwx5KrUu7KylVDsgeKEdvFoBi8FsAE0zuel4EvFU6R
         +2hbzaGJknu4dAlAehMcNc3fwov3a4AGFk87m1fAPPHYDNczb/+uv4He4R6BMmB9W7oV
         yuQTBJX92BW8xY5kXvVII7127XOkXxnvLB1QpqYjbfIhJrfuRGd0m3oS32ZJT1Wctllf
         3suTppOujdp+ACM73BKtt3jAqdw1k4NbKeaGnG6DkiP07pmCVPbTCMzZhYHElrinQVHO
         fsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=env5k57Q3iDKc/itBKH8quADcpsLZfJkDZ1gvdFdfhQ=;
        b=KhVwRfQcMSKwYIq44sFlH9yyCMDlomPYWY93jQilm8Lfh1qMXwRK+oFlosktDojNmQ
         vZ6hd9v2nm6QyvbdgDVPUtB3anik5Wwll3mttdN9cXn8oQ2cximCZoQIjcRA+ipKJab7
         C4ruKJYlSal6grybzOX/yXRrdrwx7PNUixUnpSGIz4kTxxkk1XwOUl+gkaLd3cZQxskb
         lEYNJuAj/F72vINAYyXDOx4gWW9xO42ncV+DlHL7n/qDtcYgRU7Z/lC1M7oA0vDOW1eK
         PYEfZUbaesuWUMXnxOJjQY2JSw3Qv9PvxHPc1hautwOTtZtSpJ/5UaJjQEGuOkjcXrBv
         ercA==
X-Gm-Message-State: AOAM533DNWLAnAuqN/jUQMF4djaHUVv+aT+fehtpz+8MwCtslzmd73Ls
        rzshx/Hox3vfGQ/GgmradP0=
X-Google-Smtp-Source: ABdhPJy40UvHB6b98V32By+Gw8Npa2Tt3FrAiV7hKaeS44YIxL+bQ82Jcu9AQTnhsBdrrUTpKkz+lw==
X-Received: by 2002:a05:6830:2141:: with SMTP id r1mr12131476otd.314.1600171047667;
        Tue, 15 Sep 2020 04:57:27 -0700 (PDT)
Received: from localhost.localdomain ([111.205.198.3])
        by smtp.gmail.com with ESMTPSA id y17sm5373055otq.68.2020.09.15.04.57.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:57:27 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V7 3/4] softirq: Rewrite softirq processing loop
Date:   Tue, 15 Sep 2020 19:56:08 +0800
Message-Id: <20200915115609.85106-4-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200915115609.85106-1-qianjun.kernel@gmail.com>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

Simplify the softirq processing loop by using the bitmap APIs

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5a627cd..cbb59b5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -260,9 +260,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	unsigned long old_flags = current->flags;
 	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	unsigned long pending;
+	unsigned int vec_nr;
 	bool in_hardirq;
-	__u32 pending;
-	int softirq_bit;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -283,15 +283,13 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	local_irq_enable();
 
-	h = softirq_vec;
-
-	while ((softirq_bit = ffs(pending))) {
-		unsigned int vec_nr;
+	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
 		int prev_count;
 
-		h += softirq_bit - 1;
+		__clear_bit(vec_nr, &pending);
+
+		h = softirq_vec + vec_nr;
 
-		vec_nr = h - softirq_vec;
 		prev_count = preempt_count();
 
 		kstat_incr_softirqs_this_cpu(vec_nr);
@@ -305,8 +303,6 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
-		h++;
-		pending >>= softirq_bit;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
-- 
1.8.3.1

