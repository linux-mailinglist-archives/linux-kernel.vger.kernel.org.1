Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC022E1C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGZRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 13:50:59 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:44506 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgGZRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:50:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 07A38181D337B;
        Sun, 26 Jul 2020 17:50:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 51,3.099,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:17:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2892:3138:3139:3140:3141:3142:3315:3352:3622:3865:3867:3870:3871:3872:3874:4321:5007:6691:7903:7904:10004:10400:10848:11026:11232:11658:11914:12296:12297:12438:12555:12679:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21220:21433:21451:21611:21627:21891:30012:30029:30054:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: spot61_29121a526f5a
X-Filterd-Recvd-Size: 2105
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 17:50:56 +0000 (UTC)
Message-ID: <fc092be37e970b0ec474e46e31c13ba1e1fae675.camel@perches.com>
Subject: Re: [PATCH] init/do_mounts: fix a coding style error
From:   Joe Perches <joe@perches.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        zhouchuangao <chuangaozhou@gmail.com>
Cc:     linux@dominikbrodowski.net, pc@cjr.nz, axboe@kernel.dk,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Date:   Sun, 26 Jul 2020 10:50:55 -0700
In-Reply-To: <20200726172109.GV2786714@ZenIV.linux.org.uk>
References: <1594710178-27825-1-git-send-email-zhouchuangao@xiaomi.com>
         <20200726172109.GV2786714@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 18:21 +0100, Al Viro wrote:
> On Tue, Jul 14, 2020 at 03:02:58PM +0800, zhouchuangao wrote:
> > Fix code style errors reported by scripts/checkpatch.pl.
> 
> NAKed-because: excessive deference to checkpatch.pl
> 
> It's not a holy oracle than needs to be appeased, no questions
> asked.  Reference to it is absolutely insufficient reason for
> _anything_ - in effect your commit message could've been
> "just because" for all the information it contains.

Al is right.

Something that could useful is to avoid using printks without
a KERN_<LEVEL> or add KERN_CONT to some continuation printks.

Maybe:
---
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 4f4ceb358055..3f37d859cf2a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -468,8 +468,8 @@ void __init mount_block_root(char *name, int flags)
 	printk_all_partitions();
 	printk("No filesystem could mount root, tried: ");
 	for (p = fs_names; *p; p += strlen(p)+1)
-		printk(" %s", p);
-	printk("\n");
+		pr_cont(" %s", p);
+	pr_cont("\n");
 	panic("VFS: Unable to mount root fs on %s", b);
 out:
 	put_page(page);


