Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B859300B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbhAVSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbhAVSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:24:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1381C061351
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:20:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ke15so8959031ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+AQjI2U+yUBUU1UOk70xCwlbSNDVtJV8+/awv6Dy3Q=;
        b=V4DkIqgNIUIMmsH+yc3SlpEZgRr19v1NIqn67hxQj1/aTppMKXCa2++83nZgto3fzp
         UEpy6hK97Snnp0msOrhNnhyIb4d8K3eS+CaqBQ5UgNhhbuSGJpL+TNtKEEphNWjLAbaU
         hOMGOI1yDJJTRh5sc8UivSLVmAQn4FXvLgNrEGYdvhM47pUf6GbRS/LiVibq1TWej+QY
         pU7TrAvta4eyLMyY3MftWefyuR3khOcmvm8lXFYsax4+/tMDGDOfPEw/qpJQHo12Yq00
         ZS/FR8XM4rihUZOcGN3W5UugLOw+b557adMUoKecDAkg8CPlWT9JkhM/xB97FfmqinDo
         U9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+AQjI2U+yUBUU1UOk70xCwlbSNDVtJV8+/awv6Dy3Q=;
        b=WK418jp6OSGgbXXaQwrtgmQ7xmHYErO5U09gkHcCdQEjJ5gGxk8B5agnRs2oOIEQMI
         nPCqPT8W3Tl3vUBAKq8BA2t+BFFghJYlmJB4wNgDspE/KalH5Io7EzzFooboDdvEpace
         jeH6EYgFBOIe+ZsSBU6VKCTRDjyqFFN+AXEJVMcOnFNpVWygGDWucAjWP4TEzsELRG3+
         +5m3s6NfS5LRHC/Y2uzzNlKt3CW73uhC862Lud4NUjUdpb+C+wb8ZQXovKbw6VZd/bUL
         yuLopHjBiuRc4ih2xyGxPBZQ29Rzf0TzBMHyUXEBboyMwtm+4XmXXA1YrZHxfsTlgbch
         Bbkg==
X-Gm-Message-State: AOAM5338RPvKjDxop2qf3TGLKioH/Sdo1EA1UHlnInMdLlP5qSttma5h
        1yOvh7X/FN34DssaIZmJmZa5IZRGgX600A==
X-Google-Smtp-Source: ABdhPJy6LPrplZSe7WQBdHSUg6UYki3rzLptrGfgDNJw04ZfImNmWt4qs7xjWf9VO391VfV81YvB/w==
X-Received: by 2002:a17:907:1b10:: with SMTP id mp16mr3889169ejc.482.1611339639461;
        Fri, 22 Jan 2021 10:20:39 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:38 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 4/6] block, bfq: do not raise non-default weights
Date:   Fri, 22 Jan 2021 19:19:46 +0100
Message-Id: <20210122181948.35660-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ heuristics try to detect interactive I/O, and raise the weight of
the queues containing such an I/O. Yet, if also the user changes the
weight of a queue (i.e., the user changes the ioprio of the process
associated with that queue), then it is most likely better to prevent
BFQ heuristics from silently changing the same weight.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 43e2c39cf7b5..161badb744d6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1671,15 +1671,19 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * - it is sync,
 	 * - it does not belong to a large burst,
 	 * - it has been idle for enough time or is soft real-time,
-	 * - is linked to a bfq_io_cq (it is not shared in any sense).
+	 * - is linked to a bfq_io_cq (it is not shared in any sense),
+	 * - has a default weight (otherwise we assume the user wanted
+	 *   to control its weight explicitly)
 	 */
 	in_burst = bfq_bfqq_in_large_burst(bfqq);
 	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
 		!BFQQ_TOTALLY_SEEKY(bfqq) &&
 		!in_burst &&
 		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
-		bfqq->dispatched == 0;
-	*interactive = !in_burst && idle_for_long_time;
+		bfqq->dispatched == 0 &&
+		bfqq->entity.new_weight == 40;
+	*interactive = !in_burst && idle_for_long_time &&
+		bfqq->entity.new_weight == 40;
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-- 
2.20.1

