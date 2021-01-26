Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A16D303BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbhAZLlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404522AbhAZKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7979C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f16so2024233wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0MXCokkbnaIDoDqUI9Wq5P/6nCekdb4/ZayF5jaU44=;
        b=vj1b6NidgsO3AAvLOcErxLumqmJkTgHblZ2YHQzhzjKBenORxnL05KJV+vzV+/H4M1
         qD6TVraUtAGqfx+BhiM51UH0O0bGE8/UfsSJZnn5kKjpc5/sATZAj7MKszmX3BfeSGaL
         39KVXY5Igy9YDb4tUpgwnvpqoBk/6P7U1l5wAsmey3oYSlYUM6wELOk9KKELCJhtF4Yc
         hIQU5oavrd7La/YTBNrrkM61cRzuzJvruQS8Po/Zl4YyakHcj19xuU4V79xaFl2bf1I+
         9Xo4QuJu7tg4OS/Rco/9Y/OQQS3ntIOFkCISszXN+onU2Mb7mnabTUXTUvfUZ3Sqhm52
         hD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0MXCokkbnaIDoDqUI9Wq5P/6nCekdb4/ZayF5jaU44=;
        b=b5kB5GF5aWka/pCC/OgH8GYlZM5fkU9RSIfbMRpsDZmUd+xFu+/8PuLHrGnWuWRmrY
         8a+NgjKQiG3X5yK3+EaJOfsqYeQkf2Jhtpc3pBCk9QEsMh3JefmvDMon+rSzLk9WO1Ah
         5A4tlUD/4HOe5E3kw8zznwXv3NGa8uQIQih7U6DfNuFMaL3e/lqar3tTBQI+qeXQySLU
         prj/UWL+zGcd3Dgzxj2BCO5k/OlFGXJt3vPoKtmNG6kWGMP7cgmTOsdwFcDN+ytOeEan
         U1vuYahZDjpzh5YxCnNjW8JDQrv7WxXV0x7rHwCSGhqYRiRxWfvsFc7vzCRH7hixiIai
         IAAQ==
X-Gm-Message-State: AOAM532O7DxOABZzh3SNST0QpiLmDWbgXar5tFvTklHhTcy07WeIvUJX
        bI4uGRG26fLiUGn78yRS7Q2j/Q==
X-Google-Smtp-Source: ABdhPJzK8Zs6frbsR2txsRD/xENvh79/znuNQXhGsBjUQ+py4BQ16PPJQWOtSdFqV0GvmIo8IjaV+g==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr4071206wmg.160.1611658282468;
        Tue, 26 Jan 2021 02:51:22 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:22 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 4/6] block, bfq: fix weight-raising resume with !low_latency
Date:   Tue, 26 Jan 2021 11:51:00 +0100
Message-Id: <20210126105102.53102-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the io_latency heuristic is off, bfq_queues must not start to be
weight-raised. Unfortunately, by mistake, this may happen when the
state of a previously weight-raised bfq_queue is resumed after a queue
split. This commit fixes this error.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c5bda33c0923..0c7e203085f1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1010,7 +1010,7 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
-	unsigned int old_wr_coeff = bfqq->wr_coeff;
+	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
 
 	if (bic->saved_has_short_ttime)
@@ -1031,7 +1031,13 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	bfqq->ttime = bic->saved_ttime;
 	bfqq->io_start_time = bic->saved_io_start_time;
 	bfqq->tot_idle_time = bic->saved_tot_idle_time;
-	bfqq->wr_coeff = bic->saved_wr_coeff;
+	/*
+	 * Restore weight coefficient only if low_latency is on
+	 */
+	if (bfqd->low_latency) {
+		old_wr_coeff = bfqq->wr_coeff;
+		bfqq->wr_coeff = bic->saved_wr_coeff;
+	}
 	bfqq->service_from_wr = bic->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
-- 
2.20.1

