Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8C292E48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgJSTTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:19:05 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:43194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727681AbgJSTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:19:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AC31418029210;
        Mon, 19 Oct 2020 19:19:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3742:3865:3866:3868:3870:3871:3874:4321:5007:6119:7903:7974:8957:9007:10004:10400:10482:10848:11026:11473:11658:11914:12043:12297:12438:12555:12760:13069:13161:13229:13311:13357:13439:13548:14093:14097:14181:14394:14659:14721:19901:19997:21080:21221:21451:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sock23_240113c27239
X-Filterd-Recvd-Size: 2522
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Oct 2020 19:19:03 +0000 (UTC)
Message-ID: <4b863be68e679546b40d50b97a4a806c03056a1c.camel@perches.com>
Subject: [PATCH] checkpatch: Prefer static const declarations
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Oct 2020 12:19:02 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are about 100,000 uses of 'static const <type>' but about
400 uses
of 'static <type> const' in the kernel where type is
not a pointer.

The kernel almost always uses "static const" over "const static"
as there is a compiler warning for that declaration style.

But there is no compiler warning for "static <type> const".

So add a checkpatch warning for the atypical declaration uses of.

	const static <type> <foo>
and
	static <type> const <foo>

For example:

$ ./scripts/checkpatch.pl -f --emacs --quiet --nosummary -types=static_const arch/arm/crypto/aes-ce-glue.c
arch/arm/crypto/aes-ce-glue.c:75: WARNING: Move const after static - use 'static const u8'
#75: FILE: arch/arm/crypto/aes-ce-glue.c:75:
+	static u8 const rcon[] = {

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..f82ec64f4fc7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4207,6 +4207,18 @@ sub process {
 			}
 		}
 
+# check for const static or static <non ptr type> const declarations
+# prefer 'static const <foo>' over 'const static <foo>' and 'static <foo> const'
+		if ($sline =~ /^\+\s*const\s+static\s+($Type)\b/ ||
+		    $sline =~ /^\+\s*static\s+($BasicType)\s+const\b/) {
+			if (WARN("STATIC_CONST",
+				 "Move const after static - use 'static const $1'\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bconst\s+static\b/static const/;
+				$fixed[$fixlinenr] =~ s/\bstatic\s+($BasicType)\s+const\b/static const $1/;
+			}
+		}
+
 # check for non-global char *foo[] = {"bar", ...} declarations.
 		if ($line =~ /^.\s+(?:static\s+|const\s+)?char\s+\*\s*\w+\s*\[\s*\]\s*=\s*\{/) {
 			WARN("STATIC_CONST_CHAR_ARRAY",


