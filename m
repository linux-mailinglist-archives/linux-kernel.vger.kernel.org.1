Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B862E82BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 02:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbhAABTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 20:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAABTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 20:19:07 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 17:18:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t8so11927282pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 17:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=foZBlrKxB8gBRtjlRxYiJcTq8wypAcWuqr7ZpTl2A0k=;
        b=Rfoken1PV7rGkYBJ5weqYytKX8S/zcxO0ia8saAJ3ykOcIT2KKUCXvvAx6jnNoAbdX
         TTU/l8N+KQUtTXY9C3NWFkrHosHSZ7p2X35jALREQZ2iEtSQqaa6etK5DQ48j/Nn/oMJ
         isI0t4bTuiKA+XHSFqf0LCU240xpDJYj3srio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=foZBlrKxB8gBRtjlRxYiJcTq8wypAcWuqr7ZpTl2A0k=;
        b=KxNPhg5jUgWCydxkU4F3/6V1zUFmhKBuBj5WQNal5965qccs8fLLVHnGc8EJyKTKnd
         fhm41WXgxiTMODq21ggOaoNqjpNkvA2gNpJMjQ8XPwmq+IWfBiffXP/kddInvPn+J+k3
         s29NMGGly6DOgyCrDRKqdMd5Km8AbJ+QaAOU4nOSoyef5ekRd3i5fCaYQ6nZ9jUq7fXL
         XF9kAqnKUiq/FKN3zqsQ1dveYBVK7rEg/t4Us3ko+hmMGqvbqNGt+F0eF313aBqkDMLZ
         kj3DTPh7lLiecvVsLf4srR0OlNU1FYhPrFxQfE4qhSvrXs/L4ycyLq5FAq64WIcDoLZK
         289Q==
X-Gm-Message-State: AOAM532keW79LPm3bxhtJao5NltkstEf7PdUB4yZqAjJ6bjID8R2aZKl
        I2eNZyUSf1J7OskM2U86iM7wUw==
X-Google-Smtp-Source: ABdhPJxJfEbMYxXYmG186OwzL5Scx22mHsVOvuqoxZaksXriPg6QzcmoXo3arTjW5b3Ce4DY9J67pg==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr3370263pgf.254.1609463905545;
        Thu, 31 Dec 2020 17:18:25 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-c087-3969-64de-57a6.static.ipv6.internode.on.net. [2001:44b8:1113:6700:c087:3969:64de:57a6])
        by smtp.gmail.com with ESMTPSA id l190sm46749759pfl.205.2020.12.31.17.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 17:18:24 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
In-Reply-To: <365031.1608567254@warthog.procyon.org.uk>
References: <365031.1608567254@warthog.procyon.org.uk>
Date:   Fri, 01 Jan 2021 12:18:20 +1100
Message-ID: <87a6tt1mlf.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> CONFIG_FORTIFIED_SOURCE=y now causes an oops in strnlen() from afs (see
> attached patch for an explanation).  Is replacing the use with memchr() the
> right approach?  Or should I be calling __real_strnlen() or whatever it's
> called?

You certainly shouldn't be calling __real_strnlen().

memchr() is probably the right answer if you want a small fix.

However, as Linus suggested, the 'right' answer is to re-engineer your
data structures so that the string operations you do don't overflow
their arrays.

Kind regards,
Daniel

>
> David
> ---
> From: David Howells <dhowells@redhat.com>
>
> afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
>
> AFS has a structured layout in its directory contents (AFS dirs are
> downloaded as files and parsed locally by the client for lookup/readdir).
> The slots in the directory are defined by union afs_xdr_dirent.  This,
> however, only directly allows a name of a length that will fit into that
> union.  To support a longer name, the next 1-8 contiguous entries are
> annexed to the first one and the name flows across these.
>
> afs_dir_iterate_block() uses strnlen(), limited to the space to the end of
> the page, to find out how long the name is.  This worked fine until
> 6a39e62abbaf.  With that commit, the compiler determines the size of the
> array and asserts that the string fits inside that array.  This is a
> problem for AFS because we *expect* it to overflow one or more arrays.
>
> A similar problem also occurs in afs_dir_scan_block() when a directory file
> is being locally edited to avoid the need to redownload it.  There strlen()
> was being used safely because each page has the last byte set to 0 when the
> file is downloaded and validated (in afs_dir_check_page()).
>
> Fix this by using memchr() instead and hoping no one changes that to check
> the object size.
>
> The issue can be triggered by something like:
>
>         touch /afs/example.com/thisisaveryveryverylongname
>
> and it generates a report that looks like:
>
>         detected buffer overflow in strnlen
>         ------------[ cut here ]------------
>         kernel BUG at lib/string.c:1149!
>         ...
>         RIP: 0010:fortify_panic+0xf/0x11
>         ...
>         Call Trace:
>          afs_dir_iterate_block+0x12b/0x35b
>          afs_dir_iterate+0x14e/0x1ce
>          afs_do_lookup+0x131/0x417
>          afs_lookup+0x24f/0x344
>          lookup_open.isra.0+0x1bb/0x27d
>          open_last_lookups+0x166/0x237
>          path_openat+0xe0/0x159
>          do_filp_open+0x48/0xa4
>          ? kmem_cache_alloc+0xf5/0x16e
>          ? __clear_close_on_exec+0x13/0x22
>          ? _raw_spin_unlock+0xa/0xb
>          do_sys_openat2+0x72/0xde
>          do_sys_open+0x3b/0x58
>          do_syscall_64+0x2d/0x3a
>          entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Daniel Axtens <dja@axtens.net>
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 9068d5578a26..4fafb4e4d0df 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -350,6 +350,7 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
>  				 unsigned blkoff)
>  {
>  	union afs_xdr_dirent *dire;
> +	const u8 *p;
>  	unsigned offset, next, curr;
>  	size_t nlen;
>  	int tmp;
> @@ -378,9 +379,15 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
>  
>  		/* got a valid entry */
>  		dire = &block->dirents[offset];
> -		nlen = strnlen(dire->u.name,
> -			       sizeof(*block) -
> -			       offset * sizeof(union afs_xdr_dirent));
> +		p = memchr(dire->u.name, 0,
> +			   sizeof(*block) - offset * sizeof(union afs_xdr_dirent));
> +		if (!p) {
> +			_debug("ENT[%zu.%u]: %u unterminated dirent name",
> +			       blkoff / sizeof(union afs_xdr_dir_block),
> +			       offset, next);
> +			return afs_bad(dvnode, afs_file_error_dir_over_end);
> +		}
> +		nlen = p - dire->u.name;
>  
>  		_debug("ENT[%zu.%u]: %s %zu \"%s\"",
>  		       blkoff / sizeof(union afs_xdr_dir_block), offset,
> diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
> index 2ffe09abae7f..5ee4e992ed8f 100644
> --- a/fs/afs/dir_edit.c
> +++ b/fs/afs/dir_edit.c
> @@ -111,6 +111,8 @@ static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
>  			      unsigned int blocknum)
>  {
>  	union afs_xdr_dirent *de;
> +	const u8 *p;
> +	unsigned long offset;
>  	u64 bitmap;
>  	int d, len, n;
>  
> @@ -135,7 +137,11 @@ static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
>  			continue;
>  
>  		/* The block was NUL-terminated by afs_dir_check_page(). */
> -		len = strlen(de->u.name);
> +		offset = (unsigned long)de->u.name & (PAGE_SIZE - 1);
> +		p = memchr(de->u.name, 0, PAGE_SIZE - offset);
> +		if (!p)
> +			return -1;
> +		len = p - de->u.name;
>  		if (len == name->len &&
>  		    memcmp(de->u.name, name->name, name->len) == 0)
>  			return d;
