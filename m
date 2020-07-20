Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F92255DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 04:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGTCV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 22:21:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43015 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgGTCV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:21:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595211716; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ykR2SdK1gJAE3c2jaq1OoL9b+HU9D1OPmYDpnLWtngY=; b=ZFc9bSkXNWs21Vz/MRZGo/T1zk87ouPs3pGZl9hSIRQREqT/s1S5lErQQiMtYiYkfFNaXp4L
 9L8zE9rK2wgBNnEWFyy6E/Q8CA9k2VyU259xuFjJUiG0GSisnkw7s06nrYly1fSc8V4oeEJ8
 gcGUyIhHe0eHcmTlIV61FbIFsbs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f14ffb3c9bd2efa2e36e960 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 02:21:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E521C433CA; Mon, 20 Jul 2020 02:21:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8A56C433C6;
        Mon, 20 Jul 2020 02:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8A56C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing: add trace_export support for trace_marker
Date:   Mon, 20 Jul 2020 10:21:16 +0800
Message-Id: <20200720022117.9375-4-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200720022117.9375-1-tingwei@codeaurora.org>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support to route trace_marker buffer to other destination
via trace_export.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index aef6330836e2..ac18e0ee9246 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6639,6 +6639,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	} else
 		entry->buf[cnt] = '\0';
 
+	if (static_branch_unlikely(&ftrace_exports_enabled))
+		ftrace_exports(event);
 	__buffer_unlock_commit(buffer, event);
 
 	if (tt)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

