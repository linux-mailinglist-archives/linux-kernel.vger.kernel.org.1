Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E62795C7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgIZBCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:02:25 -0400
Received: from z5.mailgun.us ([104.130.96.5]:56452 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbgIZBCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:02:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601082145; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fckq/ThlM6XG4mVhDa0+0YfnlhrinOmJvlG+wrDIx10=; b=QvyCPjXEfx+ZXH1JiPFcXBBrwBWFitqJdpiVhEVpyK40lH2T67wo/OSmQBjHSlUq/MF8RrOO
 Q6FYkJFPAE2UpPYNFDwpRUyeBavSlPhrqVO2GIFD58ZOiC5g6vb6JdiO+sN0l9AAZKwKjQhf
 WzeaixrkksN8cGvCRl/7ZPYUOoQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f6e92da99ecd993e193d0d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 26 Sep 2020 01:01:14
 GMT
Sender: tingwei=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5980C43382; Sat, 26 Sep 2020 01:01:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E869C433FE;
        Sat, 26 Sep 2020 01:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E869C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] stm class: ftrace: use different channel accroding to CPU
Date:   Sat, 26 Sep 2020 09:00:05 +0800
Message-Id: <20200926010005.14689-7-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200926010005.14689-1-tingwei@codeaurora.org>
References: <20200926010005.14689-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid mixup of packets from differnt ftrace packets simultaneously,
use different channel for packets from different CPU.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/hwtracing/stm/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index c694a6e692d1..3bb606dfa634 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -37,8 +37,10 @@ static void notrace
 stm_ftrace_write(struct trace_export *export, const void *buf, unsigned int len)
 {
 	struct stm_ftrace *stm = container_of(export, struct stm_ftrace, ftrace);
+	/* This is called from trace system with preemption disabled */
+	unsigned int cpu = smp_processor_id();
 
-	stm_source_write(&stm->data, STM_FTRACE_CHAN, buf, len);
+	stm_source_write(&stm->data, STM_FTRACE_CHAN + cpu, buf, len);
 }
 
 static int stm_ftrace_link(struct stm_source_data *data)
@@ -63,6 +65,7 @@ static int __init stm_ftrace_init(void)
 {
 	int ret;
 
+	stm_ftrace.data.nr_chans = roundup_pow_of_two(num_possible_cpus());
 	ret = stm_source_register_device(NULL, &stm_ftrace.data);
 	if (ret)
 		pr_err("Failed to register stm_source - ftrace.\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

