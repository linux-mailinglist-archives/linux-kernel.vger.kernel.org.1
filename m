Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE528BAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbgJLOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:23:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60802 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388838AbgJLOXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:23:10 -0400
Received: from zn.tnic (p200300ec2f06920008362ea164c1c332.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:836:2ea1:64c1:c332])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF1DA1EC0354;
        Mon, 12 Oct 2020 16:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602512589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hNG/z6/tE0JeJzB38pp/37BGP/5V7LhnaQ5aT6cUgRA=;
        b=hi8Co7OTGCQtqYIKkMdKTs1o64c6UyE996pnC78n25Dmck/WfqAl6a+afHtB+KSCMvXwWB
        2jaMonaMMh+qXpyxJTcSLLhIixD8I8Mdx5ioyCPlPYhNAqXPsUMZss905/SOY22syv+1Kt
        hF8aM8lPxVMPG6Wvs92Ozpg4OAI6+20=
Date:   Mon, 12 Oct 2020 16:23:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v3] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201012142306.GB22829@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
 <20201010105421.GA24674@zn.tnic>
 <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
 <20201010161112.GC24674@zn.tnic>
 <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
 <20201012142148.GA22829@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012142148.GA22829@zn.tnic>
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
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..e9ead600d685 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -408,6 +408,7 @@ our $Lval	= qr{$Ident(?:$Member)*};
 our $Int_type	= qr{(?i)llu|ull|ll|lu|ul|l|u};
 our $Binary	= qr{(?i)0b[01]+$Int_type?};
 our $Hex	= qr{(?i)0x[0-9a-f]+$Int_type?};
+our $Hex_byte	= qr{(?i)0x[0-9a-f]{1,2}};
 our $Int	= qr{[0-9]+$Int_type?};
 our $Octal	= qr{0[0-7]+$Int_type?};
 our $String	= qr{"[X\t]*"};
@@ -6858,6 +6859,18 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# document which binutils version supports the actual insn mnemonic so that the naked opcode bytes can be replaced.
+# x86-only. Upper limit is rather arbitrary (max insn length on x86) but imposed so as to avoid perl aborts.
+		if ($realfile =~ m@^arch/x86/@ &&
+		    $rawline =~ /\s*\.byte\s+(?:$Hex_byte[,\s]*){1,15}/) {
+
+			my $comment = ctx_locate_comment($file ? 0 : $first_line, $linenr);
+			if ($comment !~ /binutils (?:version )*[0-9.]+/ms) {
+				WARN("MISSING_BINUTILS_VERSION",
+				     "Please consider documenting which binutils version supports these .byte-spelled insn opcodes by adding \"binutils version <num>\" in a comment above them.\n" . $herecurr);
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
