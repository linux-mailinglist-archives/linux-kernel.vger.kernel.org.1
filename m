Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED3028BECD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbgJLRJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:09:48 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:49330 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403963AbgJLRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:09:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B9225182251AE;
        Mon, 12 Oct 2020 17:09:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3167:3315:3354:3653:3865:3866:3867:3868:3870:3871:3874:4605:5007:7576:7903:10004:10128:10400:10848:11026:11473:11658:11914:12043:12297:12438:12555:12679:12760:12895:13095:13161:13229:13255:13439:13851:14181:14394:14659:14721:21080:21221:21433:21451:21627:21891:21972:21990:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wish49_450c7ef271fc
X-Filterd-Recvd-Size: 4228
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 17:09:45 +0000 (UTC)
Message-ID: <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
Subject: [PATCH -v4] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     X86 ML <x86@kernel.org>, Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>
Date:   Mon, 12 Oct 2020 10:09:44 -0700
References: <20201009161423.14583-1-bp@alien8.de>
         <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
         <20201010105421.GA24674@zn.tnic>
         <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
         <20201010161112.GC24674@zn.tnic>
         <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
         <20201012142148.GA22829@zn.tnic>
In-Reply-To: <20201012142148.GA22829@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Signed-off-by: Joe Perches <joe@perches.com>
---

v4: trivial neatening of $Hex_byte and adding a mechanism to
    only emit the message once per patched file (Joe)

 scripts/checkpatch.pl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..7568f583701c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -414,6 +414,7 @@ our $Lval	= qr{$Ident(?:$Member)*};
 our $Int_type	= qr{(?i)llu|ull|ll|lu|ul|l|u};
 our $Binary	= qr{(?i)0b[01]+$Int_type?};
 our $Hex	= qr{(?i)0x[0-9a-f]+$Int_type?};
+our $Hex_byte	= qr{(?i)0x[0-9a-f]{1,2}\b};
 our $Int	= qr{[0-9]+$Int_type?};
 our $Octal	= qr{0[0-7]+$Int_type?};
 our $String	= qr{"[X\t]*"};
@@ -2408,6 +2409,7 @@ sub process {
 	my $comment_edge = 0;
 	my $first_line = 0;
 	my $p1_prefix = '';
+	my $warned_binutils = 0;
 
 	my $prev_values = 'E';
 
@@ -2589,6 +2591,7 @@ sub process {
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
 			$in_commit_log = 0;
 			$found_file = 1;
+			$warned_binutils = 0;
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
@@ -2606,6 +2609,7 @@ sub process {
 				      "do not modify files in include/asm, change architecture specific files in include/asm-<architecture>\n" . "$here$rawline\n");
 			}
 			$found_file = 1;
+			$warned_binutils = 0;
 		}
 
 #make up the handle for any error we report on this line
@@ -6954,6 +6958,20 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# document which binutils version supports the actual insn mnemonic so that the naked opcode bytes can be replaced.
+# x86-only. Upper limit is rather arbitrary (max insn length on x86) but imposed so as to avoid perl aborts.
+		if (!$warned_binutils &&
+		    $realfile =~ m@^arch/x86/@ &&
+		    $rawline =~ /\s*\.byte\s+$Hex_byte(?:\s*,\s*$Hex_byte){0,14}/) {
+
+			my $comment = ctx_locate_comment($file ? 0 : $first_line, $linenr);
+			if ($comment !~ /binutils (?:version )*[0-9.]+/ms) {
+				WARN("MISSING_BINUTILS_VERSION",
+				     "Please consider documenting which binutils version supports these .byte-spelled insn opcodes by adding \"binutils version <num>\" in a comment above them\n" . $herecurr);
+				$warned_binutils = 1;
+			}
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on


