Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC142C4938
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgKYUob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgKYUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:44:30 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C672C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:44:30 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id v185so794953vkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul7l8NTuGyp3MPqaSRmckdYGCH2RD65M+GA28ibecYo=;
        b=bZp8t3mlmVlKUf+27Fr2mLeI6FfPLIu/o9LyNnM9kV27HgQX2QIk0++Eo1+hicCLMY
         qFS5UAN7drXTl/G5iUESSLM4fHF6JTHfeydKM52AHPFxbO++BHrXv8X61O7uaL0Lzf5q
         JvuUbfyl8EuDOd305QPGWj6rS0sNtxI1Oow90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul7l8NTuGyp3MPqaSRmckdYGCH2RD65M+GA28ibecYo=;
        b=jiY8XljtxcqxZp5YMhyVEqHHgD4gEcWaokA4HCaMBvI2KbjXURwm9TrLDeOXE1l1AW
         wJpoB1CFvthObdhy01ceU8XLrz1fGqzulzfM4guCE6VSiCPwOpkTkpLIh+h+epkHGEBm
         7ELQkNR7X+yrqg0P+l8pHYv0osTeHh/ZvQUJ3mbcrVTjLggbaFAP7NnGmrdZwQHvpxgJ
         bs/5JN4vMQz9Q3P91IkIe8SOu2i0FdkqMrc5MF/zzPJ+IxGgpyolpLfJ2czRE4eDe5pe
         FCdSMXpJluZScUEsHPr33u0suce2RUHVjbUplPb5EBxcS6joJ++SCYtNfRIPTej8wosz
         mVdQ==
X-Gm-Message-State: AOAM531iSaQly/G611ysL/XKrhz/TjqzicXk8L9OEr15zknSGVYdQklN
        lqPwCbyEPhZ2c1e3IEtLmMnAIDwgWuIiEy2fIRDiTA==
X-Google-Smtp-Source: ABdhPJyTsN2QPlJo3E7rh6Rj2Y9Fl1tgPcRvuT2xqkIEM5W16CZEJ4PykDdQOQJ6DbBdB9V7zbYpyHdFD+O7GIdeWnc=
X-Received: by 2002:a1f:e7c2:: with SMTP id e185mr3732205vkh.23.1606337069449;
 Wed, 25 Nov 2020 12:44:29 -0800 (PST)
MIME-Version: 1.0
References: <1927370.1606323014@warthog.procyon.org.uk> <fdf89cef-1350-e387-4d59-e6951255dbf0@redhat.com>
In-Reply-To: <fdf89cef-1350-e387-4d59-e6951255dbf0@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Nov 2020 21:44:18 +0100
Message-ID: <CAJfpegtL=T1mc6TDZdM1PaTUwv9Z8UyR8p171TK0d-0VS_E1hQ@mail.gmail.com>
Subject: Re: UAPI value collision: STATX_ATTR_MOUNT_ROOT vs STATX_ATTR_DAX
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Related to this, nothing sets STATX_ATTR_DAX into statx->attributes_mask,
> anywhere in the kernel.
>
> The flag is set into statx->attributes in vfs_getattr_nosec(), but that
> does not know whether the particular filesystem under query supports dax
> or not.
>
> This is related to my other email about exactly what attributes_mask
> means, so should STATX_ATTR_DAX be set in statx->attributes_mask only
> in the filesystems that support dax?
>
> (And should that be done only if CONFIG_DAX is turned on, etc?)

I think the mask/flag combinations should mean:

mask:off, flag:off -> value unknown
mask:off, flag:on -> N/A
mask:on, flag:off -> value is off
mask:on, flag:on -> value is on

So mask should be off iff STATX_ATTR_DAX will not be set even if DAX
is enabled on a particular inode (such as on an old kernel not
supporting STATX_ATTR_DAX).

Thanks,
Miklos
