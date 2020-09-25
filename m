Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095D42781EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgIYHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYHrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:47:17 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14D3C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:47:17 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id e5so429939vkm.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXV/QDHKa4Zo5Eez8O32ppk+cWaKb+v0JrYqKyoz+YI=;
        b=Sc9pkANh/d8ygmcc9uggXdhhy1NJBZmWpnn8TFKFVokPsTeIwkLJGSTmVcxxWooQyu
         xcff1tyLRL3bmlWybmY3CmpAJdmqtCzGnrW8T6yQXY/RGH6jVV6tVCgF6Wn1lAYL+xsI
         1y0EzNl0EKA0478QBBZp9yVIc2NSlG50nrjIkWO2W74b5gSXTgUEqOMI85Zoh2fwp6U1
         0Jp3ytaRlL15wwX8jlsFITgP0rHgvM9qmtcagTHsS+zawYZsDyASHzStcGodMzpxV76Z
         KgP4Bi1MQrYxARUl4RvTN7Lg0Uw3kQCe9+othL8nWVAEOUef+Qwc5LUtRByC3AGyczwk
         K51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXV/QDHKa4Zo5Eez8O32ppk+cWaKb+v0JrYqKyoz+YI=;
        b=Zh7ELTfUpzJkSvOvg3tZz3j59dsgfGpPY1RTqYL81z10jISWGJHsGmAIB8UxhwtzjV
         ZgY+Yz9hc65ZAb8JbZOJckSEjIvLD4P+sQY25Tlc7tv2zzejcsLLVO/Lj4Z2ZbKCQOpM
         Ufg4OAXYY1ZdkJh9mJlDB8G1TmH3Ll6xtTUYyslRaVdSNL4qHi6IVloQLtHMkuVAZSVl
         y7Ne2MvXakIrW0JYyVZMjkKEydX79YNa+JYV/z+7/PxBebH32SAuYdrW89IjFHHY2bNF
         f1FNLFun+BatMhooisBc/LVtPJ2WESyDuW8jZDM3QO/Uf1WTw4bCU4uzb0rCicRQGN2y
         jvfg==
X-Gm-Message-State: AOAM533D/DelOptYeJPnCVyjl+0QfmF4TfJYXuUkEI7Zo28sFGTPYBwk
        awK8o2Y1NAfN0VeOCHd0l61CDdldVFVzMWE7R/wnJcsJVJA=
X-Google-Smtp-Source: ABdhPJzaioabZiNcPUbAzp82FjbWby7nPXWh1td1gumNH3jvwAuQxtXwP0ciEqQ+dq3AbsVJzog1lLDAw+y6odcsVBs=
X-Received: by 2002:a1f:9c04:: with SMTP id f4mr1989049vke.14.1601020036281;
 Fri, 25 Sep 2020 00:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200918112459.918328-1-misch@google.com> <CAMj1kXEJ87J45D_tVZ-o9LJCQrDJig2Gscr=bHr1DMJ0wUOu-A@mail.gmail.com>
In-Reply-To: <CAMj1kXEJ87J45D_tVZ-o9LJCQrDJig2Gscr=bHr1DMJ0wUOu-A@mail.gmail.com>
From:   Michael Schaller <misch@google.com>
Date:   Fri, 25 Sep 2020 09:46:39 +0200
Message-ID: <CALt099LCSyA0u5uPww5XQtBYW_6jJvxSpgxREbmFgbg8GBdxtw@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Replace invalid slashes with exclamation marks
 in dentries.
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Michael Schaller <michael@5challer.de>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 9:05 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 18 Sep 2020 at 13:25, Michael Schaller <misch@google.com> wrote:
> >
> > Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> > their name if the respective EFI variable has slashes in its name. This in
> > turn causes EIO on getdents64, which prevents a complete directory listing
> > of /sys/firmware/efi/efivars/.
> >
> > This patch replaces the invalid shlashes with exclamation marks like
> > kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> > named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
>
> Thanks Michael
>
> Can you resend this with a signed-off-by line please?
>
I've sent a v2 patch in a new mail thread.
> > ---
> >  fs/efivarfs/super.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index 28bb5689333a..15880a68faad 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
> >
> >         name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
> >
> > +       /* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
> > +       strreplace(name, '/', '!');
> > +
> >         inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
> >                                    is_removable);
> >         if (!inode)
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
