Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2586298DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780105AbgJZNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:31:21 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:59740 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1780098AbgJZNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:31:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 07C8612C7;
        Mon, 26 Oct 2020 13:31:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:7903:10004:10400:10848:11232:11658:11783:11914:12043:12297:12438:12663:12740:12895:13069:13311:13357:13439:13894:14096:14097:14181:14659:14721:21080:21433:21451:21627:30029:30030:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: son43_0c10b2927273
X-Filterd-Recvd-Size: 2426
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 26 Oct 2020 13:31:18 +0000 (UTC)
Message-ID: <7c592b6b4cc3bc4e629e35445fa76cf07b5482a6.camel@perches.com>
Subject: Re: [PATCH 1/1] s390: correct __bootdata / __bootdata_preserved
 macros
From:   Joe Perches <joe@perches.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Date:   Mon, 26 Oct 2020 06:31:17 -0700
In-Reply-To: <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
         <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
         <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-26 at 13:49 +0100, Vasily Gorbik wrote:
> Currently s390 build is broken.
> 
>   SECTCMP .boot.data
> error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
>   SECTCMP .boot.preserved.data
> error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
> make[1]: *** [bzImage] Error 2
> 
> Commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")") converted all __section(foo) to __section("foo").
> This is wrong for __bootdata / __bootdata_preserved macros which want
> variable names to be a part of intermediate section names .boot.data.<var
> name> and .boot.preserved.data.<var name>. Those sections are later
> sorted by alignment + name and merged together into final .boot.data
> / .boot.preserved.data sections. Those sections must be identical in
> the decompressor and the decompressed kernel (that is checked during
> the build).
> 
> Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Apologies and thank you.
I believed the robot had done these compilation tests.


