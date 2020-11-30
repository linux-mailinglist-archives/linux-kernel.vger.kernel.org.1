Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0E2C84B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgK3NLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgK3NLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606741779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9d9XdU5Titt5/Nod7XiGF/HEU0E6wP9nIDkj+IZ3V4k=;
        b=XI8j8x9VOz4nlCFBMCooXijzzyIqtMuO79z9AzLccMa9JvRPNWJ8yZQV1CWkoYbykpGgUq
        7uC6ruIRgqbAohRLdde10iZfUHhrqhkv8jihXuMJDzK9cqfLnD96e4JfguFNViEFB/woAQ
        mvP7RDxLjpockhEWsfAGmU3jri/41o8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-U09mH5x6OH2CfQOItCJbPQ-1; Mon, 30 Nov 2020 08:09:36 -0500
X-MC-Unique: U09mH5x6OH2CfQOItCJbPQ-1
Received: by mail-wm1-f70.google.com with SMTP id y187so7411490wmy.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9d9XdU5Titt5/Nod7XiGF/HEU0E6wP9nIDkj+IZ3V4k=;
        b=FDw8nl0tSUdRVpha1DzPnh2xpvnUGGXNCPexHwM4aSA0PMu0NoF+/usIgiu+Kok2Yf
         ScLHzEdwO95+uOSwF2ndE82JY3PjeLjq0FyDmThxqKWFCVbPJEbqcpSDoEWfQDTn1I3g
         znQigEwfqKQALI9YBTRqQWnnD9e2RZPW0VW/NNA22JwFkNFqp4Lv7AiZBcK0lGwdGAzb
         4e+Y34Pt+cLvQbZpU6ptZLK6MfNvbjjcPs6rs6px4OGRG0zGZRGJrU2/hW3kzXqrhucB
         oZsmu+dnB9qTGilV+tF+vl7Iorp07gPDgfAipa9e9r3LLG0cdtcbKwz0XZR6Gn0qjkMZ
         RXIw==
X-Gm-Message-State: AOAM533spWr/RN6tN701vfEmXmXnd5nC6JCcQJ48A6iU27rBhhL/iegb
        abKwfkeXA9CNZriy1FZIsrpHKIAm1RGI5cIVCZYjzSGcAOLsuMlKvDmVLO+uBPElyfbYsTY1exz
        sK2aiKX1q++p5j8eTFhC78hX2wnftm6/+cfIA4D7g
X-Received: by 2002:adf:9124:: with SMTP id j33mr27161814wrj.376.1606741775223;
        Mon, 30 Nov 2020 05:09:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI5bHVV9iUpM10lkXbReXUEb+/HeidvTe40Hr9iIEnn2AgthhzSBOfuxosSg2N7fV2kPKd5d7lseA/lN4L7po=
X-Received: by 2002:adf:9124:: with SMTP id j33mr27161795wrj.376.1606741775025;
 Mon, 30 Nov 2020 05:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org> <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
 <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain> <X8RpFo+5m1i4L5Gn@jagdpanzerIV.localdomain>
 <c96f60f4-f525-2957-6a8a-ae9e3288b04a@infradead.org>
In-Reply-To: <c96f60f4-f525-2957-6a8a-ae9e3288b04a@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 30 Nov 2020 14:09:23 +0100
Message-ID: <CAHc6FU59uNEq4Xz8W7boG6y3+u3F1tz93RKSW+odM38rx37_9A@mail.gmail.com>
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 5:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/29/20 7:37 PM, Sergey Senozhatsky wrote:
> > A quick question, shouldn't there be dummy definitions for
> > the EXPORT_SYMBOL-s? So that external modules can be modprobed
> > and used.
> >
> > Some of posix_acl exported symbols have dummy definitions,
> > others don't.
> >
> > E.g. posix_acl_create() is exported symbol and it's defined for
> > both FS_POSIX_ACL and !FS_POSIX_ACL. While exported set_posix_acl()
> > is defined only for FS_POSIX_ACL config.

This is to keep the amount of ifdefs in the code reasonably low: by
defining posix_acl_create as a dummy inline function like that, inode
creation in filesystems can be implemented without any ifdefs as in
jffs2_init_acl_pre whether or not CONFIG_FS_POSIX_ACL is enabled, for
example. Have a look at different filesystems to see how they avoid
using POSIX ACL code when that feature is disabled.

Note that ext2 / ext4 could be built without POSIX ACL support in the
past. That's at least broken since the following two commits though:

  commit 59fed3bf8a461 ("ext2: cache NULL when both default_acl and
acl are NULL")
  commit 6fd941784b8ac ("ext4: cache NULL when both default_acl and
acl are NULL")

> Hi,
>
> Currently CONFIG_FS_POSIX_ACL differences seem to be handled in
> each source file as needed:
>
> fs/inode.c:#ifdef CONFIG_FS_POSIX_ACL
> fs/inode.c:#ifdef CONFIG_FS_POSIX_ACL
> fs/namei.c:#ifdef CONFIG_FS_POSIX_ACL
> fs/overlayfs/dir.c:     if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !acl)
> fs/overlayfs/inode.c:   if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
> fs/overlayfs/inode.c:#ifdef CONFIG_FS_POSIX_ACL
> fs/overlayfs/super.c:#ifdef CONFIG_FS_POSIX_ACL
> fs/xattr.c:#ifdef CONFIG_FS_POSIX_ACL
> include/linux/evm.h:#ifdef CONFIG_FS_POSIX_ACL
> include/linux/fs.h:#ifdef CONFIG_FS_POSIX_ACL
> include/linux/posix_acl.h:#ifdef CONFIG_FS_POSIX_ACL
> include/linux/posix_acl.h:#endif /* CONFIG_FS_POSIX_ACL */
> include/linux/posix_acl_xattr.h:#ifdef CONFIG_FS_POSIX_ACL
>
> However, I have no objection to your patch.
>
> I am adding Andreas & Al for their viewpoints.

Sergey, what actual problem is your patch trying to solve? It sounds
like this is either theoretical and pointless, or you're trying to
build an external module that uses POSIX ACL functions that shouldn't
be needed when CONFIG_FS_POSIX_ACL is disabled. In the latter case,
the external module will just end up including dead code, so the
module should be fixed instead.

Thanks,
Andreas

