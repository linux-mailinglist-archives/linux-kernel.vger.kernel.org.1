Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF732830B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgJEHN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:13:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:10324 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgJEHNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:41 -0400
IronPort-SDR: id8Soz7zA92BXdqaoDMGpERuktJ3nTg9niXFZV5Q/cpfND+gSRGov71NZFNYfwzOHncYHZ0wvt
 gB4huswXsXtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227479274"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227479274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:13:41 -0700
IronPort-SDR: IcldlMVyM+NQUsdKy5wTeNDMrDqLmpOdQ6fXq7pcWAHAvB0YcUCGZ8p4W/UQ5CmlJvzQBo+F3G
 aPtuoSf5HJow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="309718096"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 00:13:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 5/8] stm class: ftrace: Enable supported trace export flag
Date:   Mon,  5 Oct 2020 10:13:16 +0300
Message-Id: <20201005071319.78508-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
References: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Set flags for trace_export. Export function trace, event trace
and trace marker to stm.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index ce868e095410..c694a6e692d1 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -46,6 +46,8 @@ static int stm_ftrace_link(struct stm_source_data *data)
 	struct stm_ftrace *sf = container_of(data, struct stm_ftrace, data);
 
 	sf->ftrace.write = stm_ftrace_write;
+	sf->ftrace.flags = TRACE_EXPORT_FUNCTION | TRACE_EXPORT_EVENT
+			| TRACE_EXPORT_MARKER;
 
 	return register_ftrace_export(&sf->ftrace);
 }
-- 
2.28.0

