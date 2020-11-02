Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469B72A2B8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgKBNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKBNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:32:51 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939BF223BF;
        Mon,  2 Nov 2020 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604323968;
        bh=rtwGrq/TaYEdLUO5tapMlpkFM8hmFTRxeKtt5zjXmBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRqNj3bxHXQQNZF9lH5wpW4GiVyQHAhqGT32RkylvRKByERDZrMs4Y8Go0yP764Yx
         dk9/T6sflk44e4AjwjjW61yvK6rgfTIWoDkunqBYCFfTom6MPSO2IV3HeUB8pFHqzq
         X7LrdSvjMdbmua7ROmc2qOPfDZT1mFodLLUopOLE=
Date:   Mon, 2 Nov 2020 14:33:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Perches <joe@perches.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201102133343.GA1011963@kroah.com>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
 <20201101204834.GF27442@casper.infradead.org>
 <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
 <20201101211910.GG27442@casper.infradead.org>
 <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
 <20201101220604.GI27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101220604.GI27442@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 10:06:04PM +0000, Matthew Wilcox wrote:
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

How can sysfs_emit() be called on a non-page-aligned buffer?  It's being
used on the buffer that was passed to the sysfs call.

And if you are writing multiple values to a single sysfs file output,
well, not good...

> 
> +++ b/fs/sysfs/file.c
> @@ -722,13 +722,13 @@ int sysfs_emit(char *buf, const char *fmt, ...)
>  {
>         va_list args;
>         int len;
> +       int start = offset_in_page(buf);
>  
> -       if (WARN(!buf || offset_in_page(buf),
> -                "invalid sysfs_emit: buf:%p\n", buf))
> +       if (WARN(!buf, "invalid sysfs_emit: buf:%p\n", buf))
>                 return 0;
>  
>         va_start(args, fmt);
> -       len = vscnprintf(buf, PAGE_SIZE, fmt, args);
> +       len = vscnprintf(buf, PAGE_SIZE - start, fmt, args);

That's a bit too 'tricky' for my taste, why is it somehow needed?

thanks,

greg k-h
