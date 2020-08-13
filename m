Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6624323B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHMBrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 21:47:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13847 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHMBrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:47:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597283230; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=DWvh/xe4da4kqEIchXLMEtV/mjQkWQ1/j/n7f+uAWvc=; b=niS2SDM8rrVEb9JzxR/sH7GgwoB8lMQoL7eeeaJ4mWFSdvvzsj2Z3uq7J37RQ2fe9GaUHwAP
 FfombCqMeaohJhoWT80j3f+7ODvWjhqCLNGHOSrvJ4gM+7yQii9vJH9Xq8PFYzPS8alsaVtJ
 31tk0maEgA67te3uXMwh0pKsXjw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f349b5a3f2ce11020e1a561 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 01:46:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B91CC433C6; Thu, 13 Aug 2020 01:46:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EA6CC433C6;
        Thu, 13 Aug 2020 01:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EA6CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: [PATCH v3 0/6] tracing: export event trace and trace_marker
Date:   Thu, 13 Aug 2020 09:45:46 +0800
Message-Id: <20200813014552.23539-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace has ability to export trace packets to other destination.
Currently, only function trace can be exported. This series extends the
support to event trace and trace_maker. STM is one possible destination to
export ftrace. Use separate channel for each CPU to avoid mixing up packets
from different CPUs together.

Change from v2:
Change flag definition to BIT(). (Steven)
Add comment in stm_ftrace_write() to clarify it's safe to use 
smp_processor_id() here since preempt is disabled. (Steven) 

Change from v1:
All changes are suggested by Steven Rostedt.
User separate flag to control function trace, event trace and trace mark.
Allocate channels according to num_possible_cpu() dynamically.
Move ftrace_exports routines up so all ftrace can use them.

Tingwei Zhang (6):
  stm class: ftrace: change dependency to TRACING
  tracing: add flag to control different traces
  tracing: add trace_export support for event trace
  tracing: add trace_export support for trace_marker
  stm class: ftrace: enable supported trace export flag
  stm class: ftrace: use different channel accroding to CPU

 drivers/hwtracing/stm/Kconfig  |   2 +-
 drivers/hwtracing/stm/ftrace.c |   7 +-
 include/linux/trace.h          |   7 +
 kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
 4 files changed, 159 insertions(+), 127 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

