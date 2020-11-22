Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53D2BC32B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 03:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgKVChd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 21:37:33 -0500
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:57476 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgKVChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 21:37:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B9DA1100E7B42;
        Sun, 22 Nov 2020 02:37:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3873:4321:5007:6119:7514:7903:10004:10400:10848:11232:11658:11914:12294:12297:12438:12555:12740:12760:12895:13439:14181:14659:14721:21063:21080:21221:21451:21611:21627:21774:30030:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: step08_1801d0827359
X-Filterd-Recvd-Size: 3257
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Nov 2020 02:37:30 +0000 (UTC)
Message-ID: <1823e72eb92280d30457dda49e0a0036dee15dd3.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add fix option for LOGICAL_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 18:37:29 -0800
In-Reply-To: <20201121210442.17299-1-yashsri421@gmail.com>
References: <a6ee46ce01747627196478ff2a965d48dd4eed73.camel@perches.com>
         <20201121210442.17299-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-22 at 02:34 +0530, Aditya Srivastava wrote:
> Currently, checkpatch warns if logical continuations are placed at the
> start of a line and not at the end of previous line.
> 
> E.g., running checkpatch on commit 3485507fc272 ("staging:
> bcm2835-camera: Reduce length of enum names") reports:
> 
> CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
> previous line
> +	if (!ret
> +	    && camera_port ==
> 
> Provide a simple fix by adding logical operator at the end of previous
> line and removing from current line, if both the lines are additions
> (ie start with '+')
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> changes in v2: quote $operator at substitution
> 
> changes in v3: add a check for previous line ending with comment;
> If so, insert $operator at the last non-comment, non-whitespace char of the previous line
> 
> changes in v4: improve the matching mechanism by matching line termination at comment or white space;
> insert the operator before comments (if any) separated by a whitespace;
> append the comment and its pre-whitespace after the inserted operator (if comment was present),
> ie if no comment was present nothing will be inserted after the operator

nak. I gave you a hint to the match string to use.

$prevline =~ /[\s$;]*$/

this matches either /* foo */ or // foo comment styles
(or optional blanks before EOL)

Try something like:
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..3c78cf0c219f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3434,8 +3434,15 @@ sub process {
 
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
-			CHK("LOGICAL_CONTINUATIONS",
-			    "Logical continuations should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("LOGICAL_CONTINUATIONS",
+				"Logical continuations should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add logical operator to the previous line, remove from current line
+				$prevline =~ /([\s$;]*$)/;
+				substr($fixed[$fixlinenr - 1], $-[0]) = " $operator" . substr($prevrawline, $-[0],$+[0]);
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop

