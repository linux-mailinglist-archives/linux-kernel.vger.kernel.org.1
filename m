Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21412F2147
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbhAKU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:59:50 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:40879 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbhAKU7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:59:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610398771; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=FejdcNeskbNijKqbe186xVWD9/tCQ7On7jSIGSIFwSc=; b=ORQPElTQtT6gY4LAtWx/iVEelWyzH8HoqNSsyriWeRh2wJ+/qcAGBSgJ6Cnm0J8hl72A4JtW
 SwBvK0hlQIVNnVVdvrYZmw/avxh+R7YLMLRtE8w095oHzr1jIRvJt8Vj18AWp8TBQzYZsFcs
 XmLlsHfCGkcmAUc9Li96a7TUlBo=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ffcbc124104d9478d3043a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 20:58:58
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30B2BC43462; Mon, 11 Jan 2021 20:58:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2156EC433CA;
        Mon, 11 Jan 2021 20:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2156EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH] mm: vmscan: support equal reclaim for anon and file pages
Date:   Mon, 11 Jan 2021 12:58:43 -0800
Message-Id: <c617a0c6cb2a7e3bc78998ad7e2bceb22df157c2.1610398598.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing memory reclaim support treating anonymous and
file backed pages equally.
Swapping anonymous pages out to memory can be efficient enough
to justify treating anonymous and file backed pages equally.

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 257cba79a96d..ec7585e0d5f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,8 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
+bool balance_anon_file_reclaim = false;
+
 static void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
 {
@@ -201,6 +203,13 @@ static DECLARE_RWSEM(shrinker_rwsem);
 static DEFINE_IDR(shrinker_idr);
 static int shrinker_nr_max;
 
+static int __init cmdline_parse_balance_reclaim(char *p)
+{
+	balance_anon_file_reclaim = true;
+	return 0;
+}
+early_param("balance_reclaim", cmdline_parse_balance_reclaim);
+
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
@@ -2291,9 +2300,11 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 
 	/*
 	 * If there is enough inactive page cache, we do not reclaim
-	 * anything from the anonymous working right now.
+	 * anything from the anonymous working right now. But when balancing
+	 * anon and page cache files for reclaim, allow swapping of anon pages
+	 * even if there are a number of inactive file cache pages.
 	 */
-	if (sc->cache_trim_mode) {
+	if (!balance_anon_file_reclaim && sc->cache_trim_mode) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

