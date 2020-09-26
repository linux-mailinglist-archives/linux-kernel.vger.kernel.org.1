Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9412795C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgIZBBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:01:05 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:27992 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbgIZBBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:01:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601082062; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=inVwG+lgLK3y69RPi+2kZXAeaXX0aKhf2C3eywTtfvc=; b=B96tJkgTx3/1twMd041hrGfkwBLQtMFIqdDebw8ytxyVEZKHchI4199JrlhYuKflW5wVTUEW
 x0wn6cnETMyxmcMo7CcELRyJBDmtMY2nanpthrjRsGR+4DV05ptPFH9Tf01KwWw5a0QStOIh
 kIZP3aXS2+pOfjIOG3m8gUWQgR4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f6e92bf09b3131964fceb9e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 26 Sep 2020 01:00:47
 GMT
Sender: tingwei=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B317CC433C8; Sat, 26 Sep 2020 01:00:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43463C433C8;
        Sat, 26 Sep 2020 01:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43463C433C8
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
Subject: [PATCH v4 0/6] tracing: export event trace and trace_marker 
Date:   Sat, 26 Sep 2020 08:59:59 +0800
Message-Id: <20200926010005.14689-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace has ability to export trace packets to other destination.
Currently, only function trace can be exported. This series extends the
support to event trace and trace_maker. STM is one possible destination to
export ftrace. Use separate channel for each CPU to avoid mixing up packets
from different CPUs together.

Change from v3:
Round up number of channels to power of 2. (Alex)

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

