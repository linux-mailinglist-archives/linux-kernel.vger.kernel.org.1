Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0743D1B1177
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgDTQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728659AbgDTQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:25:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99410C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:25:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so4125298plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/HuxgmmHlqReW6h8RDiDPaUU+foeFL9gMHI9mR80zQ=;
        b=oLc3AJ2zDSkJUS41so2hjSzJWNKd+wQTQRY105W2+x1kDo67B9HBOmeWMj71MixgMx
         Or9Sk5sj3rNm2US+gKQTp3Pa4AgxhFV4SqxT7+A6HxzfaKFMFsWyQbXAeSfmPoABqpNl
         Co26ffksskFcKs3YvP8b3uw/2SKxJVLuMvcn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/HuxgmmHlqReW6h8RDiDPaUU+foeFL9gMHI9mR80zQ=;
        b=qWkNOK75uah+RI/om0jlUMuQfZ6T3pmtRP3hIj1iQoh5H6n8boWxxgkKeyIuJMyX1t
         IXm60v5qNYzlDFT3JuGuDeAbqpu5RLe55zLFA6g1gw1Y95HyeFngst1z12nD5S5OZ7HH
         yuwTukJQsPUdIysnNCbf/YP0hErVqhFryY5YQ1Q5ss7HPNBiLqAGRV3N1TPm1VHSQkiP
         s0CQ9Fge/lzDQli/sBwP0vCVuVeQDTqQknT24uprIJbJs+r3SnCgjCjqyjBcf1m9uRFo
         YW7xJHisDppLymDXqWWP1DONxejx0u92qjcqODMUESQ8G+IfqnbWAMqFvc/Di1jkUpQ8
         o9Ug==
X-Gm-Message-State: AGi0PuYX7MDUmNFADDsBpPuGRJGwF4bRYNKp3gZq3Zd9KlqfPLSNImh9
        22N7HOI+DQ7xVf3EXeC9M9ubew==
X-Google-Smtp-Source: APiQypKpCrNnEeTYcINBy79o3eKcejCinyX6OW/b2TJcQxL+18Xe1Dv9nBf3MYUu730zR6e0r+X2hA==
X-Received: by 2002:a17:90a:710a:: with SMTP id h10mr213647pjk.152.1587399924208;
        Mon, 20 Apr 2020 09:25:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p64sm93150pjp.7.2020.04.20.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:25:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        sqazi@google.com, groeck@chromium.org,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
Date:   Mon, 20 Apr 2020 09:24:51 -0700
Message-Id: <20200420092357.v5.1.I1f95c459e51962b8d2c83e869913b6befda2255c@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420162454.48679-1-dianders@chromium.org>
References: <20200420162454.48679-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In blk_mq_dispatch_rq_list(), if blk_mq_sched_needs_restart() returns
true and the driver returns BLK_STS_RESOURCE then we'll kick the
queue.  However, there's another case where we might need to kick it.
If we were unable to get budget we can be in much the same state as
when the driver returns BLK_STS_RESOURCE, so we should treat it the
same.

It should be noted that even if we add a whole bunch of extra kicking
to the queue in other patches this patch is still important.
Specifically any kicking that happened before we re-spliced leftover
requests into 'hctx->dispatch' wouldn't have found any work, so we
really need to make sure we kick ourselves after we've done the
splicing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---

Changes in v5:
- Rebase atop commit 5fe56de799ad ("...Put driver tag...when no budget")

Changes in v4: None
Changes in v3:
- Note why blk_mq_dispatch_rq_list() change is needed.

Changes in v2: None

 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7785df2c944..1c4bedf500c5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1206,6 +1206,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	bool no_budget_avail = false;
 
 	if (list_empty(list))
 		return false;
@@ -1224,6 +1225,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		hctx = rq->mq_hctx;
 		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
 			blk_mq_put_driver_tag(rq);
+			no_budget_avail = true;
 			break;
 		}
 
@@ -1320,13 +1322,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *
 		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
 		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.
+		 * that could otherwise occur if the queue is idle.  We'll do
+		 * similar if we couldn't get budget and SCHED_RESTART is set.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE))
+		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
+					   no_budget_avail))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);
-- 
2.26.1.301.g55bc3eb7cb9-goog

