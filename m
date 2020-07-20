Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81F2255DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGTCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 22:22:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12405 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgGTCWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:22:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595211721; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mziV6dw1w86ytw+21xecioLH5sETgcRtWY7LRJxfINk=; b=qEvGlo6b2sjuHa0AnTyuG9n4QDJ4pBV8ZeMXCQ9hN7BVamGFkxo/hIqYoz60xDTG4sjC2/7O
 f01V7dH/yXmkCHQpLPG7z4EAChITTP5Ghk9p3qbXf1HojQpXQap7jVt0n14RwI102X6nM+4M
 qCo9y2ZLh9fUcUCZvatjEz1s5EY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f14ffb78e36ecda3058b4e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 02:21:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E0AAC433C6; Mon, 20 Jul 2020 02:21:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A53ADC433C9;
        Mon, 20 Jul 2020 02:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A53ADC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] stm class: ftrace: use different channel accroding to CPU
Date:   Mon, 20 Jul 2020 10:21:17 +0800
Message-Id: <20200720022117.9375-5-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200720022117.9375-1-tingwei@codeaurora.org>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid mixup of packets from differnt ftrace packets simultaneously,
use different channel for packets from different CPU.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/stm/ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index ce868e095410..6c3bce11c8d3 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -10,7 +10,7 @@
 #include <linux/stm.h>
 #include <linux/trace.h>
 
-#define STM_FTRACE_NR_CHANNELS 1
+#define STM_FTRACE_NR_CHANNELS NR_CPUS
 #define STM_FTRACE_CHAN 0
 
 static int stm_ftrace_link(struct stm_source_data *data);
@@ -37,8 +37,9 @@ static void notrace
 stm_ftrace_write(struct trace_export *export, const void *buf, unsigned int len)
 {
 	struct stm_ftrace *stm = container_of(export, struct stm_ftrace, ftrace);
+	unsigned int cpu = smp_processor_id();
 
-	stm_source_write(&stm->data, STM_FTRACE_CHAN, buf, len);
+	stm_source_write(&stm->data, STM_FTRACE_CHAN + cpu, buf, len);
 }
 
 static int stm_ftrace_link(struct stm_source_data *data)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

