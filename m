Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3842715A4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgITQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:20:37 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:41372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726311AbgITQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:20:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3C8AB18224D7E;
        Sun, 20 Sep 2020 16:20:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3653:3867:3870:3871:3874:5007:7903:10004:10400:10848:11026:11658:11914:12297:12555:12760:13069:13095:13221:13229:13255:13311:13357:13439:14181:14394:14659:14721:21080:21433:21627:21660:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tramp39_4902a322713d
X-Filterd-Recvd-Size: 1866
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Sep 2020 16:20:35 +0000 (UTC)
Message-ID: <b6afa04112d450c2fc120a308d706acd60cee294.camel@perches.com>
Subject: [PATCH -next] checkpatch: Fix git "fatal" warning if file argument
 outside kernel tree
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        Julia Lawall <julia.lawall@inria.fr>, apw@canonical.com
Date:   Sun, 20 Sep 2020 09:20:34 -0700
In-Reply-To: <cca15cb7889f25ab010300a3e7e55dd63478c1fc.camel@perches.com>
References: <alpine.DEB.2.22.394.2009201346560.2966@hadrien>
         <cca15cb7889f25ab010300a3e7e55dd63478c1fc.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bcf4271d4bc3 ("checkpatch: allow not using -f with files that
are in git") in linux-next causes checkpatch to emit a fatal message:

fatal: <file>: '<file>' is outside repository at '<kernel_dir>'

Fix that by sending git's error output to /dev/null instead.

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3e474072aa90..469f8e7456df 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -981,7 +981,7 @@ sub git_is_single_file {
 
 	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
 
-	my $output = `${git_command} ls-files -- $filename`;
+	my $output = `${git_command} ls-files -- $filename 2>/dev/null`;
 	my $count = $output =~ tr/\n//;
 	return $count eq 1 && $output =~ m{^${filename}$};
 }


