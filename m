Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BDA28A286
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbgJJW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgJJTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:50:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F6C0613AF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 03:57:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1bdf00c1046aa2c3de4fbe.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:df00:c104:6aa2:c3de:4fbe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A2051EC03C1;
        Sat, 10 Oct 2020 12:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602327350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eX9k78SiB9uywyyffjjSXxNZ7jpkkqSmnZRh6G0aYDg=;
        b=Exuo+KUbilRBfjXzzMhFDHuc2eNucTwuPAw1bijtQpEo8CofYWpb9bOQIAkCp7Uu7YiLlt
        MhCvo+1wrJSXuCbIDd62KmptyytKKpy2cnu1y+HT3o1B0gB7PJd1En47UxS2qqVweEHxuT
        /z/2LmGcKJykg6bcqtDWyqDHws3rpC8=
Date:   Sat, 10 Oct 2020 12:55:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201010105547.GB24674@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
 <20201010105421.GA24674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201010105421.GA24674@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--
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
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..d9065ef5d4fe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6858,6 +6858,20 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# document which binutils version supports the actual insn mnemonic so that the naked opcode bytes can be replaced.
+# x86-only.
+		if ($realfile =~ m@^arch/x86/@ &&
+		    $rawline =~ /\.byte[\s0-9a-fx,]+/) {
+
+			my $comment = ctx_locate_comment($file ? 0 : $first_line, $linenr);
+			if ($comment !~ /binutils version [0-9.]+/ms) {
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


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
