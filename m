Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F202A2205
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgKAWOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 17:14:09 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:59800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727009AbgKAWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 17:14:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 186A01802913A;
        Sun,  1 Nov 2020 22:14:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 20,1.5,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3291:3353:3622:3865:3867:3868:3871:3873:3874:4321:4605:5007:6119:7875:10009:10400:10848:11026:11232:11658:11783:11914:12043:12297:12740:12895:13069:13095:13311:13357:13439:13894:14659:14721:21080:21095:21433:21627:21740:21939:21990:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:18,LUA_SUMMARY:none
X-HE-Tag: worm98_430afcb272aa
X-Filterd-Recvd-Size: 3024
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Nov 2020 22:14:06 +0000 (UTC)
Message-ID: <27e4de6beb414838f42e826b694438f10d7871e4.camel@perches.com>
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Nov 2020 14:14:05 -0800
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
> On Sun, Nov 01, 2020 at 01:43:13PM -0800, Joe Perches wrote:
> > > Why did you change this?
> > 
> > Are you asking about the function argument alignment or the commit message?
> 
> The indentation.  Don't change the fucking indentation, Joe.
> 
> > > Look, this isn't performance sensitive code.  Just do something simple.
> > > 
> > > 		if (shmem_huge == values[i])
> > > 			buf += sysfs_emit(buf, "[%s]",
> > > 					shmem_format_huge(values[i]));
> > > 		else
> > > 			buf += sysfs_emit(buf, "%s",
> > > 					shmem_format_huge(values[i]));
> > > 		if (i == ARRAY_SIZE(values) - 1)
> > > 			buf += sysfs_emit(buf, "\n");
> > > 		else
> > > 			buf += sysfs_emit(buf, " ");
> > > 
> > > Shame there's no sysfs_emitc, but there you go.
> > 
> > I think what's there is simple.
> 
> Again, you're wrong.
> 
> > And your suggested code doesn't work.
> > sysfs_emit is used for single emits.
> > sysfs_emit_at is used for multiple emits.
> 
> Oh, ugh, sysfs_emit() should be able to work on a buffer that isn't
> page aligned.  Greg, how about this?
> 
> +++ b/fs/sysfs/file.c
> @@ -722,13 +722,13 @@ int sysfs_emit(char *buf, const char *fmt, ...)
>  {
>         va_list args;
>         int len;
> +       int start = offset_in_page(buf);
>  
> 
> -       if (WARN(!buf || offset_in_page(buf),
> -                "invalid sysfs_emit: buf:%p\n", buf))
> +       if (WARN(!buf, "invalid sysfs_emit: buf:%p\n", buf))
>                 return 0;
>  
> 
>         va_start(args, fmt);
> -       len = vscnprintf(buf, PAGE_SIZE, fmt, args);
> +       len = vscnprintf(buf, PAGE_SIZE - start, fmt, args);
>         va_end(args);
>  
> 
>         return len;
> 


