Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4CB288E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbgJIQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbgJIQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:15:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF69C0610E1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:14:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bdf00ed72b3de4c017840.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:df00:ed72:b3de:4c01:7840])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C34031EC04CB;
        Fri,  9 Oct 2020 18:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602260077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=nnEPQNpLGSaLe9mZ/XstKFUEQMIioD5Q/ribgrPsNJo=;
        b=k59frIa63mCkUJfLkuxH9l8BLn29dPZjzvXgD9AVrv4/YQnFFzlFy+wii2HZ8EnUDkCWRy
        fvyXaIQsagfb5ljA3FSL17uM/og+sI9HLcQHi3Pyz1hyfom7T/OY0gaibXTzFsZ00czhGk
        mh1s8RgfeCLMHh7cN7jE8EahFBhyKbY=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] checkpatch: Check for .byte-spelled insn opcodes documentation on x86
Date:   Fri,  9 Oct 2020 18:14:23 +0200
Message-Id: <20201009161423.14583-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Instruction opcode bytes spelled using the gas directive .byte should
carry a comment above them stating which binutils version has added
support for the instruction mnemonic so that they can be replaced with
the mnemonic when that binutils version is equal or less than the
minimum-supported version by the kernel.

Add a check for that.

Requested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..cfa81f1640cd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6858,6 +6858,18 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# document which binutils version supports the actual insn mnemonic so that the naked opcode bytes can be replaced.
+# x86-only.
+		if ($rawline =~ /(\.byte[\s0-9a-fx,]+)/ && $realfile =~ "^arch/x86/") {
+			my $comment = ctx_locate_comment(0, $linenr);
+			if (! $comment || ($comment !~ /binutils version [0-9.]+/ms)) {
+				WARN("MISSING_BINUTILS_VERSION",
+				     "Please document which binutils version supports these .byte-spelled\n" .
+				     "\tinsn opcodes by adding \"binutils version <num>\" in a comment" .
+				     " above them.\n" . $herecurr);
+			}
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.21.0

