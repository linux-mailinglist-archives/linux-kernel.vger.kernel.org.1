Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5312579A3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHaMqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 08:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:46:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7772068E;
        Mon, 31 Aug 2020 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598877974;
        bh=qo4Tvm0Jrhz3e9pVFUTiSSfPG+ZIdpE0CRzPSDNTv5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/HOZfNRrrCYAIZo5ktOCjcJngewoOaUPhwnlsT12mitdfcuTRmXiiIAPy+jBpcHr
         oZ2dddi0iqlE07z2Piq9nWDVZ3u4poSZHerCSv2RDsZd05TWHkwdWUEqyhKSdNIVnq
         43qngG8mCxu4M/REZrbINzbEQePPQ8+MhyZlEtEg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 5/6] Documentation: tracing: Add %return suffix description
Date:   Mon, 31 Aug 2020 21:46:10 +0900
Message-Id: <159887797048.1330989.6092698289026009625.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159887792384.1330989.5993224243767476896.stgit@devnote2>
References: <159887792384.1330989.5993224243767476896.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description of the %return suffix option for kprobe tracer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/kprobetrace.rst |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c1709165c553..d29d1f9e6721 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -30,6 +30,7 @@ Synopsis of kprobe_events
 
   p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]	: Set a probe
   r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]	: Set a return probe
+  p:[GRP/]EVENT] [MOD:]SYM[+0]%return [FETCHARGS]	: Set a return probe
   -:[GRP/]EVENT						: Clear a probe
 
  GRP		: Group name. If omitted, use "kprobes" for it.
@@ -37,6 +38,7 @@ Synopsis of kprobe_events
 		  based on SYM+offs or MEMADDR.
  MOD		: Module name which has given SYM.
  SYM[+offs]	: Symbol+offset where the probe is inserted.
+ SYM%return     : Return address of the symbol
  MEMADDR	: Address where the probe is inserted.
  MAXACTIVE	: Maximum number of instances of the specified function that
 		  can be probed simultaneously, or 0 for the default value

