Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5401A1CBC03
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 02:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgEIA6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 20:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgEIA6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:58:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA9221974;
        Sat,  9 May 2020 00:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588985910;
        bh=o0oOWkkVx9b7PKne5AE+R9D6GHpCKQaRAe27yC1DLyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOHVbB2gUBXJwOeGoZjU1DsAG+TG6dg60mcwUkE7E5FnDHnfKdzL30OMhOVFnNTeV
         53qqXsJ6UGT8L17TBI74hU6JdyZhROna74QNF+RRW7Qf9XTcnonZwYr/L1kIiLc5Lk
         00KQ49SD2RCuz5jTXSsDt6BX9+iob2EVeb+pLg3c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: [PATCH] tools/bootconfig: Add a summary of test cases and return error
Date:   Sat,  9 May 2020 09:58:25 +0900
Message-Id: <158898590533.22749.10269622752797822320.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509091107.eb4f517a93ff2e0ae5e64b93@kernel.org>
References: <20200509091107.eb4f517a93ff2e0ae5e64b93@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add summary lines of test cases and return an error
code if any test case fails so that tester don't have
to monitor the output.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 81b350ffd03f..eff16b77d5eb 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -124,9 +124,16 @@ for i in samples/good-* ; do
   xpass $BOOTCONF -a $i $INITRD
 done
 
+
+echo
+echo "=== Summary ==="
+echo "# of Passed: $(expr $NO - $NG - 1)"
+echo "# of Failed: $NG"
+
 echo
 if [ $NG -eq 0 ]; then
 	echo "All tests passed"
 else
 	echo "$NG tests failed"
+	exit 1
 fi

