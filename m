Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2342C84DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgK3NO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgK3NO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606742010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3QMImLUzsUxdD3lrxokZ6OLsGo9+qiElCnfZdbpvzA=;
        b=UECHBboa2pJ07GYWLO2EQfvVgESjKBetXPTXMhUNV1i9qB4Ss6da9ZfrBpcta1bxcR6BMH
        ShUcrJf77c6T237uFzYKqsndydiFpwW1i/KSbBn367tuMoruiDZ4+HHAei0V4CZDlDtiy7
        86zygyDa/LWtJRh7unfMCCdEb4j0LWQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-DQxZP_vYMRilDJNHNa_ZRg-1; Mon, 30 Nov 2020 08:13:28 -0500
X-MC-Unique: DQxZP_vYMRilDJNHNa_ZRg-1
Received: by mail-wm1-f72.google.com with SMTP id k128so7415437wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3QMImLUzsUxdD3lrxokZ6OLsGo9+qiElCnfZdbpvzA=;
        b=B0h9jnzCR63hfrUa9rfz2FqVI0w2XeNZVR8ALFNxfxkOCANl46iEm2kzBGU5YO+kYq
         xkxE4JGmEK7JXJcXcKPX+4kOTmjljWPCxRMoj3OO/uLLZyl4sFuZaoFKuQTXPvBP64eR
         ikosa4o6XooOg+JcgUdrfM+ZLQYrCBGafXWlDkaBxc1S1s1AKbWcaTWl5cLSXJi5wRhr
         5Bnxwng1Dq1xy6U/kBb3BGCWXkrlw6qi8Ty/iB/Up5tMipJ+ZtebsASiMVWrw/H5+0Iu
         cuRXfebyZicwI293kI1YQ7Up4tAma0JCNf+yXIUKQnG1lmFys7vZOYnnJ7cVZ5cQywpC
         MQTw==
X-Gm-Message-State: AOAM532jkW6Ao6kxk1sW1BFYOCyzIl6KdQ7tiAUwn3tJ8l0j+0XuCl4A
        EG1pv0gm4rGDidZmsDzOgkGB3j9HmX0xJCa256s23/CJN3hpPBMyLNnOGncdueXquOlOotYpgk7
        rQFSzimwKvrxrLvzNQaVM1pxO0scOjSBSjGx//Yic
X-Received: by 2002:a5d:6250:: with SMTP id m16mr29212889wrv.400.1606742006900;
        Mon, 30 Nov 2020 05:13:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+aZi6ISnIXF20bS+IivTvzdVJ4geNjK6nyaq0wAVc1EAbO9JFv+Lh1s3TZuUclVgKh0naMbZF5Jvbjm89YIY=
X-Received: by 2002:a5d:6250:: with SMTP id m16mr29212862wrv.400.1606742006654;
 Mon, 30 Nov 2020 05:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org> <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
 <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain> <X8RpFo+5m1i4L5Gn@jagdpanzerIV.localdomain>
 <c96f60f4-f525-2957-6a8a-ae9e3288b04a@infradead.org> <CAHc6FU59uNEq4Xz8W7boG6y3+u3F1tz93RKSW+odM38rx37_9A@mail.gmail.com>
In-Reply-To: <CAHc6FU59uNEq4Xz8W7boG6y3+u3F1tz93RKSW+odM38rx37_9A@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 30 Nov 2020 14:13:15 +0100
Message-ID: <CAHc6FU6Tt6HXLv39PzdrUgh8=tS4=OLSh6dSUnbbkGgR7yMX_Q@mail.gmail.com>
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

On Mon, Nov 30, 2020 at 2:09 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> Note that ext2 / ext4 could be built without POSIX ACL support in the
> past. That's at least broken since the following two commits though:
>
>   commit 59fed3bf8a461 ("ext2: cache NULL when both default_acl and
> acl are NULL")
>   commit 6fd941784b8ac ("ext4: cache NULL when both default_acl and
> acl are NULL")

Scratch that, this is in fs/ext[24]/acl.c which is only included when
CONFIG_FS_POSIX_ACL is defined.

Thanks,
Andreas

