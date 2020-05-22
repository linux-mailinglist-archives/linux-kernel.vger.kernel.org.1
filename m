Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9211DDD04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 04:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgEVCJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 22:09:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:48478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgEVCJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:09:19 -0400
IronPort-SDR: CmyCDUZaaGYzlWXTSZfrIPDhl4NdZHGmecfa03/ZI/EXGvKBVeun/eg/FWzzTb6PrvvpTF5R8A
 4/vYOke7X9CQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 19:09:18 -0700
IronPort-SDR: vmV4daX14cR5AwmGWa3zYyINUlwFhc2vyKwTy2o4laLzvJMo2a6DxXs9TW6oPcDwiwiNlh2/X9
 BtU8rk5UwYMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; 
   d="scan'208";a="254157193"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 21 May 2020 19:09:18 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B4004301A90; Thu, 21 May 2020 19:09:18 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf script: Don't force less for non tty output with --xed
Date:   Thu, 21 May 2020 19:09:14 -0700
Message-Id: <20200522020914.527564-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

--xed currently forces less. When piping the output to other scripts
this can waste a lot of CPU time because less is rather slow.
I've seen it using up a full core on its own in a pipeline.
Only force less when the output is actually a terminal.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 56d7bcd12671..c4c6a00e0341 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3286,7 +3286,10 @@ static int parse_xed(const struct option *opt __maybe_unused,
 		     const char *str __maybe_unused,
 		     int unset __maybe_unused)
 {
-	force_pager("xed -F insn: -A -64 | less");
+	if (isatty(1))
+		force_pager("xed -F insn: -A -64 | less");
+	else
+		force_pager("xed -F insn: -A -64");
 	return 0;
 }
 
-- 
2.25.4

