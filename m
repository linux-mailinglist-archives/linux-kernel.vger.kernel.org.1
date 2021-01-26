Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58DC303CED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbhAZMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404481AbhAZKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D620C061797
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e15so2336497wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDB2VePP2gLo3jktXjvGnSm3jDWHWVOh6rC8z0CbRvQ=;
        b=D7x3P3OFR2vff+Yisjrvazi8eadRJNZbJnawBZbQpfFxy4dMa/orEnq0vHCEEDJL5p
         kLf5J9b4uznLltOw5/AuQA7c4JtVJS5tWd3XV2xZCo/QMYerYkgcfBVBJ8m/gt3+9pII
         fVhlxp2QrMCtwfNZoLRG6TGUEXup8VrC6YaIUNfjVr8LmWlbg2NbS7jjmegOFbe7KmRK
         8bTtTWco0Xh45LldthuzzW8S4sL4fQ/ZdfVmAwzTguy8WBcROiEkYlEmabKewjrhpJeE
         S5iKogUo4fst39p5sS8skCcFs1ScgkFe4iJncmXTbaBjfclKz/4Cgitov9ctk+kgVtjS
         Aa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDB2VePP2gLo3jktXjvGnSm3jDWHWVOh6rC8z0CbRvQ=;
        b=FEOopLA4bVVQY+vwI2v8ixby5RQ4Ue1tFnhEwhAF1JsBBi4HsfHQwxt14tnR8/peQj
         fjSsLJNwTbkknM3Ni1mCo/rF4MmJxWHeQZTiRar6EVdEYIwYCmoZnIKdlxK7m6XoLqR0
         bmj+UVgzVBZoQsgRQBP0rvRXKwIQdnjGeUI1ezqg0ayUwBFK9cGgC5/mplUvq4B7QGxn
         Wtv5i3HdDtpmIe6dqp/ksa9xPhcDJWXFp75d1eILWtShPextlFCoSg61hUCWRg/x8I07
         zlfulpz+jBJST9fXl1KOAMGv0xZ9TjFImnB3m+ddCM5S2M9i+euglIOcQXiwrkVAZZQJ
         +5ZA==
X-Gm-Message-State: AOAM530m7CgO2fE4O3mmG5xGQeiHuYIMYUVPzGOgvKamcfTzibyLlDln
        LcK1YuENwdHqD9Ehp+Rvem6W+0ZUCa5/wQ==
X-Google-Smtp-Source: ABdhPJxt0t0zfhum4rHmKwRmfDFrxAJaGG/0X91xEqYzJx6/dtV9+zRIwoFomMvoiUeOP+B2K1NtCQ==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr4150055wmj.165.1611658283791;
        Tue, 26 Jan 2021 02:51:23 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:23 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 5/6] block, bfq: keep shared queues out of the waker mechanism
Date:   Tue, 26 Jan 2021 11:51:01 +0100
Message-Id: <20210126105102.53102-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared queues are likely to receive I/O at a high rate. This may
deceptively let them be considered as wakers of other queues. But a
false waker will unjustly steal bandwidth to its supposedly woken
queue. So considering also shared queues in the waking mechanism may
cause more control troubles than throughput benefits. This commit
keeps shared queues out of the waker-detection mechanism.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0c7e203085f1..23d0dd7bd90f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5825,7 +5825,17 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 			1UL<<(BFQ_RATE_SHIFT - 10))
 		bfq_update_rate_reset(bfqd, NULL);
 	bfqd->last_completion = now_ns;
-	bfqd->last_completed_rq_bfqq = bfqq;
+	/*
+	 * Shared queues are likely to receive I/O at a high
+	 * rate. This may deceptively let them be considered as wakers
+	 * of other queues. But a false waker will unjustly steal
+	 * bandwidth to its supposedly woken queue. So considering
+	 * also shared queues in the waking mechanism may cause more
+	 * control troubles than throughput benefits. Then do not set
+	 * last_completed_rq_bfqq to bfqq if bfqq is a shared queue.
+	 */
+	if (!bfq_bfqq_coop(bfqq))
+		bfqd->last_completed_rq_bfqq = bfqq;
 
 	/*
 	 * If we are waiting to discover whether the request pattern
-- 
2.20.1

