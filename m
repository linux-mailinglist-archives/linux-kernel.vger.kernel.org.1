Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32A295F87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899435AbgJVNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:16:57 -0400
Received: from z5.mailgun.us ([104.130.96.5]:15070 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442003AbgJVNQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:16:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603372614; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Ipi9ynr+xEPqZ69xhwJ6Rw5nRW7OtUtZcKIzdGosVlM=; b=ZNFH3MsAtB3COEd3crRJYp+9Uq3RzvI/l+rqeNBMdMS0MUx1f6kMCg5IE75tfSIkIoNjjw0m
 IhQBJ9YPlW31ST9Z40BnygYUqytXAxji1GWbciUCs5HshIVS/3/XsY2njaBJJNLmJIRN6Dma
 JY233nU/+JJl2Qmv3VsEK09t9Ts=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f918620d63768e57b18fbfc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Oct 2020 13:16:16
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EC5EC433FF; Thu, 22 Oct 2020 13:16:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 761D5C433C9;
        Thu, 22 Oct 2020 13:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 761D5C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     glider@google.com, dan.j.williams@intel.com, broonie@kernel.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        vjitta@codeaurora.org, Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
Subject: [PATCH] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Date:   Thu, 22 Oct 2020 18:45:46 +0530
Message-Id: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Lal <ylal@codeaurora.org>

Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.

Aim is to have configurable value for  STACK_HASH_SIZE,
so depend on use case one can configure it.

One example is of Page Owner, default value of
STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
Making it configurable and use lower value helps to enable features like
CONFIG_PAGE_OWNER without any significant overhead.

Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 lib/Kconfig      | 9 +++++++++
 lib/stackdepot.c | 3 +--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 18d76b6..b3f8259 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -651,6 +651,15 @@ config STACKDEPOT
 	bool
 	select STACKTRACE
 
+config STACK_HASH_ORDER_SHIFT
+	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
+	range 12 20
+	default 20
+	depends on STACKDEPOT
+	help
+	 Select the hash size as a power of 2 for the stackdepot hash table.
+	 Choose a lower value to reduce the memory impact.
+
 config SBITMAP
 	bool
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2caffc6..413c20b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -142,8 +142,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	return stack;
 }
 
-#define STACK_HASH_ORDER 20
-#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
+#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER_SHIFT)
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

