Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FF28D906
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgJNDx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:53:57 -0400
Received: from one.firstfloor.org ([193.170.194.197]:45292 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgJNDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:53:57 -0400
Received: from firstfloor.org (c-71-237-255-61.hsd1.or.comcast.net [71.237.255.61])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by one.firstfloor.org (Postfix) with ESMTPSA id A57DE867AC;
        Wed, 14 Oct 2020 05:53:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1602647634;
        bh=IvSJzn3yWoUP/GyBlqGqnpCQnt/EbyNHsOXph78SSr4=;
        h=From:To:Cc:Subject:Date:From;
        b=Jpw73wFED6y/ifpsEnmi0wX+EQnShcgkwdVoNEnWqybbGBGza21AQ4fV1JnKT0n19
         sbhca9F0ir0VqEjV07eY24hdKYn4vk8OfY5lGkUOaOUrKUkCwfcUBoM8Xi9k4aJMoC
         2SMMXfdto+ubwDugkMq9b+Ci2+j2ehiTJ9IWqD9c=
Received: by firstfloor.org (Postfix, from userid 1000)
        id D2B1CA8667; Tue, 13 Oct 2020 20:53:52 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        Andi Kleen <andi@firstfloor.org>, adrian.hunter@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf: Improve PT documentation slightly
Date:   Tue, 13 Oct 2020 20:53:46 -0700
Message-Id: <20201014035346.4772-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the higher level --insn-trace etc. perf script options.

Include the howto how to build xed into the manpage

Cc: adrian.hunter@intel.com
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index d5a266d7f15b..cc2a8b2be31a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -112,6 +112,32 @@ The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
 in transaction, respectively.
 
+perf script also supports higher level ways to dump instruction traces:
+
+	perf script --insn-trace --xed
+
+Dump all instructions. This requires installing the xed tool (see XED below)
+Dumping all instructions in a long trace can be fairly slow. It is usually better
+to start with higher level decoding, like
+
+	perf script --call-trace
+
+or
+
+	perf script --call-ret-trace
+
+and then select a time range of interest. The time range can then be examined
+in detail with
+
+	perf script --time starttime,stoptime --insn-trace --xed
+
+While examining the trace it's also useful to filter on specific CPUs using
+the -C option
+
+	perf script --time starttime,stoptime --insn-trace --xed -C 1
+
+Dump all instructions in time range on CPU 1.
+
 Another interesting field that is not printed by default is 'ipc' which can be
 displayed as follows:
 
@@ -1093,6 +1119,10 @@ To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
 
 	perf script --itrace=oe
 
+XED
+---
+
+include::build-xed.txt[]
 
 SEE ALSO
 --------
-- 
2.28.0

