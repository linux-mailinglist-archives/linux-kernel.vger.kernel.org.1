Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465AE2A2204
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 23:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKAWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 17:13:56 -0500
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:59954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727009AbgKAWN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 17:13:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 51BFF100E7B42;
        Sun,  1 Nov 2020 22:13:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:10004:10400:10848:11026:11232:11658:11783:11914:12296:12297:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wash01_230fb5d272aa
X-Filterd-Recvd-Size: 1888
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 22:13:53 +0000 (UTC)
Message-ID: <2abb3c694107764dea1e118566eb3c6c331404fc.camel@perches.com>
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Nov 2020 14:13:52 -0800
In-Reply-To: <20201101220604.GI27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
         <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
         <20201101204834.GF27442@casper.infradead.org>
         <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
         <20201101211910.GG27442@casper.infradead.org>
         <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
         <20201101220604.GI27442@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-01 at 22:06 +0000, Matthew Wilcox wrote:
> Oh, ugh, sysfs_emit() should be able to work on a buffer that isn't
> page aligned.  Greg, how about this?
> 
> +++ b/fs/sysfs/file.c
> @@ -722,13 +722,13 @@ int sysfs_emit(char *buf, const char *fmt, ...)
>  {
>         va_list args;
>         int len;
> +       int start = offset_in_page(buf);

I thought of that originally and didn't want to implement it that
way as it allows sysfs_emit to be used on non-page aligned buffers.

Using two functions makes sure the buf is always page aligned and
so buf should never defectively be passed in unaligned.


