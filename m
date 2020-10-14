Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9403F28E1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgJNNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgJNNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602683354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSNs1Z4597yqqSr/izsI9vDVqZKwJUb3kL7SxhQKXlY=;
        b=d+HWweHrNvf+bsa0qhXDRuZs7uAKxAg4ChipwmR1urR4iPKXU5uIbiiBqkr/gxWJLm3qyn
        yn3xE0ouUWCeCmiLZSQeHbBff+6aMetjE4tkYxn2mQuKqYpQdZG+5jOz9aS5j4yuov/naU
        XkQMV4ic64/kaL4NjOkqdtghoHJVQ0c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-X7k5xdGwM1ydSh5L3q6ZQw-1; Wed, 14 Oct 2020 09:49:09 -0400
X-MC-Unique: X7k5xdGwM1ydSh5L3q6ZQw-1
Received: by mail-ed1-f72.google.com with SMTP id m10so1226695edj.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSNs1Z4597yqqSr/izsI9vDVqZKwJUb3kL7SxhQKXlY=;
        b=k6AxGQ69A2W6OOym7o7jRC2PljAkMDjGDGfg8ryxF9rivW++dQdGBgUrsp7QUWd0mI
         H1C7whMPSmKz4lQSu5xTVGn8I8cGKBm73Txyd3Bo5Nd7OibNYclSvduvvRiRMnaYd1wx
         dXNLPx6mMbyHFrJ4HRLP2c5VL2x6tHNNCLRBK34Kw63W9i4+ug9BuKZr3kaJkcQXI/+U
         ULlN20mm8fq68ipLEccP0Cu9KIfPQ/Mt1TqAKpT9VTQ2FDDFbad5N0y545YBuzRY03b4
         aJOyIsqovmHthoI+n7JdZyaTjXFn5yWuDqcoU9lfueAqBnnsZJkiJm9DcgAzptP/GmB1
         whbQ==
X-Gm-Message-State: AOAM533+k4YE8ozVipHYKJ0lPXpzd0IvEJhzcNGYWcJ5gOuZaSALrLOo
        S/Vb27hKM0cx8PRjs1DkxWtnosR50IU0HG9ItPxPt/cVv/D1mht7xS16Yj9InCkeuJuzUlA+MvM
        En+M3kcjsu0cCA5RMKFdoyz87/WNuUQopWGqXvBWJ
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr5671382ejr.217.1602683348563;
        Wed, 14 Oct 2020 06:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuDBNJnuCIVopNCRDD7xc3d1K1H0uj6mOIIcRgMvx/filL7NU3n8TF2yUT5NzNIGDqSlXeB98NLDgx3q7QzdI=
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr5671356ejr.217.1602683348286;
 Wed, 14 Oct 2020 06:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142724.15032-1-tiwai@suse.de>
In-Reply-To: <20200827142724.15032-1-tiwai@suse.de>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 14 Oct 2020 09:48:32 -0400
Message-ID: <CALF+zOn5Pzuf1zv1_bR_MbX8oJ5UZ-FpCd8KkkMzWOE9n3p7EQ@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH] fs/cachefiles: Drop superfluous readpages
 aops NULL check
To:     Takashi Iwai <tiwai@suse.de>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:10 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> After the recent actions to convert readpages aops to readahead, the
> NULL checks of readpages aops in cachefiles_read_or_alloc_page() may
> hit falsely.  More badly, it's an ASSERT() call, and this panics.
>
> Drop the superfluous NULL checks for fixing this regression.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208883
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1175245
> Cc: <stable@vger.kernel.org> # v5.8
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  fs/cachefiles/rdwr.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> index 3080cda9e824..5b4cee71fa32 100644
> --- a/fs/cachefiles/rdwr.c
> +++ b/fs/cachefiles/rdwr.c
> @@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
>
>         inode = d_backing_inode(object->backer);
>         ASSERT(S_ISREG(inode->i_mode));
> -       ASSERT(inode->i_mapping->a_ops->readpages);
>
>         /* calculate the shift required to use bmap */
>         shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
> @@ -712,7 +711,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
>
>         inode = d_backing_inode(object->backer);
>         ASSERT(S_ISREG(inode->i_mode));
> -       ASSERT(inode->i_mapping->a_ops->readpages);
>
>         /* calculate the shift required to use bmap */
>         shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
> --
> 2.16.4
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-cachefs
>

Agree this should go in as fscache (I am testing with NFS) becomes
unusable without it after 5.8.

It may have flown under the radar due to the in-progress FS-Cache rewrite.

