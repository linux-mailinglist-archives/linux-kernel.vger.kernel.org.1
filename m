Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C600271F26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIUJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIUJpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:45:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D3D218AC;
        Mon, 21 Sep 2020 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600681506;
        bh=XLxNaP1rcWQdNU2Ol1FIHxj4pcgpb2lcc9ENab9Y0Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZK3d5Qeh5ire9nvHYWcwWluJKKatmMcf9m4ADjmXE57xGqeq2pAqi6EQZ82qzMfLf
         fYBpGTC6gtbNo0dAPUqA2Rd+XfkBHjFGn2b0SObzICxP5vqVoZAN1wzT/9lCwBihKn
         p/yDrlYLv2ozzMfyidtNc0yVdA/N4se1fPybv/nE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/4] tools/bootconfig: Add testcases for repeated key with brace
Date:   Mon, 21 Sep 2020 18:45:02 +0900
Message-Id: <160068150176.1088739.409481347784771987.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160068147328.1088739.7282405187565509762.stgit@devnote2>
References: <160068147328.1088739.7282405187565509762.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for repeated key with brace parsing issue.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 56284b98d8f0..95eec768b503 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -137,6 +137,18 @@ $BOOTCONF $INITRD > $TEMPCONF
 cat $TEMPCONF
 xpass grep \'\"string\"\' $TEMPCONF
 
+echo "Repeat same-key tree"
+cat > $TEMPCONF << EOF
+foo
+bar
+foo { buz }
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q "bar" $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

