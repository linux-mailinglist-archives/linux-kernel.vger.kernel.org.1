Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C98271F27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIUJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgIUJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:45:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6032193E;
        Mon, 21 Sep 2020 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600681516;
        bh=aNmgr2U4IYve6iy7g+3nCoQTK4biSwRkCcLTaOanvmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8eei236nMmOxZqMogFCtUL/2RSIsZ24Ux0H+mlY7lLc7pHIVHDN8hF+BhLmHNou1
         BZTegAatobudrbThjsjNNKZ7hByhIxVRNw2OqxDUZhSvpuWtSfsrc0iKrNsINY+zXN
         WJPjpfGBE0l6X6B6XI1Dl2waRMjUwsOyEZrWA6zM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/4] tools/bootconfig: Add testcase for tailing space
Date:   Mon, 21 Sep 2020 18:45:11 +0900
Message-Id: <160068151151.1088739.3469541807296024227.stgit@devnote2>
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

Add testcases for removing/keeping tailing space
in the value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 95eec768b503..d295e406a756 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -149,6 +149,19 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
 $BOOTCONF $INITRD > $OUTFILE
 xpass grep -q "bar" $OUTFILE
 
+
+echo "Remove/keep tailing spaces"
+cat > $TEMPCONF << EOF
+foo = val     # comment
+bar = "val2 " # comment
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xfail grep -q val[[:space:]] $OUTFILE
+xpass grep -q val2[[:space:]] $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

