Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEE2830A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:13:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:10318 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:38 -0400
IronPort-SDR: YymGvdGs5fCHJz/3YfgtmQIlr7zstedT6lucsHehIRF4N8oe+OR51WOQpHIk7IHpMg+AhWo1LT
 dCGOVUs0/aQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227479249"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227479249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:13:33 -0700
IronPort-SDR: mWb6OJVElXXWaD1oPGRH8LnwKdGsBTiFfdVmqyMpvQ2FS4zHLuYv/WCI3FBaqn/MFb5hHCbqnR
 2DRtE/5lDPcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="309718077"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 00:13:32 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/8] stm class: ftrace: Change dependency to TRACING
Date:   Mon,  5 Oct 2020 10:13:12 +0300
Message-Id: <20201005071319.78508-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
References: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

We will support copying event trace to STM. Change
STM_SOURCE_FTRACE to depend on TRACING since we will
support multiple tracers.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index d0e92a8a045c..aad594fe79cc 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -71,7 +71,7 @@ config STM_SOURCE_HEARTBEAT
 
 config STM_SOURCE_FTRACE
 	tristate "Copy the output from kernel Ftrace to STM engine"
-	depends on FUNCTION_TRACER
+	depends on TRACING
 	help
 	  This option can be used to copy the output from kernel Ftrace
 	  to STM engine. Enabling this option will introduce a slight
-- 
2.28.0

