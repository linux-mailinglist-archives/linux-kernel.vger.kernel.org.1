Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF03039E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391591AbhAZKLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbhAYTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:05:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD84C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:03:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so14096332wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3N9Fc9Oym1a/uSXoPjk2H2RgyHj8WV7XIwzdfEee54=;
        b=aSRERs4AkNneRj0RmPWLV03SycGYdHxwG1cq6GOgodsaPX4VY1olaYz37kZGHA8Vdh
         ctrahRmB7MbwOQao585A4TjlLBdoLU3C/l67U4bz/qwmkaR6cHFxIYMSfIeCdxT4K1a3
         VRUwrlgnZdKVIyhB8meFItX0n6xS5rjc5A5A81xQ9z7d+ErHgdl4Mhl29Is2hTNXG5AD
         OiYo8DudLASRR4Fgoqcu+y38TQmttdkiqJYh2q+giBtn4Rq0+CpjPpG6vF86PcZt5EVm
         jHfkFcfAfc/Paxz0OfHshMxWfZJt9LQYq9D6hgMjSHtU8hWfmvl1ewO1JLtdEE63knJ4
         20nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3N9Fc9Oym1a/uSXoPjk2H2RgyHj8WV7XIwzdfEee54=;
        b=T7KYpPCAeA52rpEhdlNBmZIUXVGkDOKBctopmYXkHbTDfBT7VvYzQ+rnqJOKofPDH5
         QNpHiXhx7YNlqvNs2h47fuY8mSuAaJAhVEHlydV1TNo+kD6C1NYDxJ1wNKiEkzmh+qdL
         M7gMref6SPB3NrsxETu3PhV/P2vCGkNiSDDdAHrC0jpk0L2is8RP6Gw+kpBo974HU5Vw
         oFzLA2M1fGmYiZ0CNJzbuuwrGR1tTosj2VkbcstIJqXMPIoqvHlfd6JEZPrYD88VEDsx
         9JTzO9nkLNklQ+7exl//Fei23QFB0AeymmvtVKh0mWFX4gSmPku6Clo2T+vvvrNENvoe
         8AaQ==
X-Gm-Message-State: AOAM530tgqRM1a2vCRaTFt8e82PeKqYJURKab9sEwak3+Rl4RWefaQ6j
        WJ/vBsxlCcjYK7VWI9lOzTf41A==
X-Google-Smtp-Source: ABdhPJxwcZ2dcN1I/y1hi9Lq/ZxxKwclSEVGgd921GuPKSsEsHU54wwyDcs3IEFHCU6qxvfnrGnyXw==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr2632482wrt.164.1611601399469;
        Mon, 25 Jan 2021 11:03:19 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:18 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 4/6] block, bfq: save also weight-raised service on queue merging
Date:   Mon, 25 Jan 2021 20:02:46 +0100
Message-Id: <20210125190248.49338-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent weight-raising information from being lost on bfq_queue merging,
also the amount of service that a bfq_queue receives must be saved and
restored when the bfq_queue is merged and split, respectively.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 block/bfq-iosched.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e5242b2788a..56ad6067d41d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1029,6 +1029,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	bfqq->io_start_time = bic->saved_io_start_time;
 	bfqq->tot_idle_time = bic->saved_tot_idle_time;
 	bfqq->wr_coeff = bic->saved_wr_coeff;
+	bfqq->service_from_wr = bic->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
 	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
@@ -2775,6 +2776,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		bic->saved_wr_coeff = bfqq->wr_coeff;
 		bic->saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
+		bic->saved_service_from_wr = bfqq->service_from_wr;
 		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
 		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
 	}
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index c913b06016b3..d15299d59f89 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -440,6 +440,7 @@ struct bfq_io_cq {
 	 */
 	unsigned long saved_wr_coeff;
 	unsigned long saved_last_wr_start_finish;
+	unsigned long saved_service_from_wr;
 	unsigned long saved_wr_start_at_switch_to_srt;
 	unsigned int saved_wr_cur_max_time;
 	struct bfq_ttime saved_ttime;
-- 
2.20.1

