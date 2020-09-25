Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A358C278208
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgIYHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:54:42 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E06C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:54:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a16so844439vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nc1cpnSDlXbRzr8P9/b6kU8iAwX3SL3yb53UV8YCftU=;
        b=qJP0sGkoc8edOSz39jUh0rluYSenlnPU2VduqGsi87wrrctSyvZKfb9GLSAGz2mQS6
         VblprWT+zHNfBXXK/XGIeJOjypJ9mkr0DNtkT4NG7wY4HZekj6i56LKt0O067MsAq2KI
         CNtQDeZPO33Y0IijYDI+dAc0RRnWJTgMex1/bqIuuj6NwljXihyjJSSmahQ0fOWXgyH/
         0Ab9uCwjlAyiuCovYyfyI7JmtNWsWg8e6ZBkDYX4vIQQzW8nWW1InwOhZl/0Nak46bO9
         j+mOg4uNz5Lu9nl62SXcS0fC/4MHdhHmYElIhkDpJg5FabYMzecs64PtBfAQ7/6pdOTp
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nc1cpnSDlXbRzr8P9/b6kU8iAwX3SL3yb53UV8YCftU=;
        b=Yb51HohUee6mb/+dgqBSWKoklDabqUR0ZejdyGd42f0uXxPn2SXv/5S4oq7/d2QoEn
         7ZNWI+oAJX/TECocJ//XL/lSV30Qf20+Aa3hyGxWuntvwFgDnuvFGlhXihDYz5I3OW71
         RPt/KA5/UpHZuXzcx89IlauiJ9MBKzIzQBNMsHKjYVUMEvtgG6asJ0f4mr9c3sou6DET
         DZXujSdm5puxM+KPjvCeFK6g+MgBKV4yWqxU688cbzSFIKVBmh/d9TFGqytrTQ6tcDod
         SSm1cYabz023l97gehKh3+NWlcJh0YVKmq36MCNatPfznGYfvZ3kcwj/J8+Q4E1ZAf44
         LNhA==
X-Gm-Message-State: AOAM532teXQRNmF/CEX2Z6pQZRE1ODBZOD7Z9KGUZm95MRkCrEUncCtM
        nr4ApNyBvSPSKGjEdYS9/dX0QjZDbrlAIxApmNz5O7mlyTM=
X-Google-Smtp-Source: ABdhPJzSyc9kVqTopVZTnS96i0P46m7wUwLEItWfoSiad2St+F/CNOKcmRfLpAXNv+nTbXgEFNOALl3yWPQLrEoxrDI=
X-Received: by 2002:a67:f511:: with SMTP id u17mr2376263vsn.2.1601020480605;
 Fri, 25 Sep 2020 00:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200925074502.150448-1-misch@google.com> <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
In-Reply-To: <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
From:   Michael Schaller <misch@google.com>
Date:   Fri, 25 Sep 2020 09:54:04 +0200
Message-ID: <CALt099+4UNaVGoeHNOfErEtBwyUuV_ZhSRFkLKksPdWnrdednQ@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Replace invalid slashes with exclamation
 marks in dentries.
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

On Fri, Sep 25, 2020 at 9:49 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 25 Sep 2020 at 09:45, Michael Schaller <misch@google.com> wrote:
> >
> > Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> > their name if the respective EFI variable has slashes in its name. This in
> > turn causes EIO on getdents64, which prevents a complete directory listing
> > of /sys/firmware/efi/efivars/.
> >
> > This patch replaces the invalid shlashes with exclamation marks like
> > kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> > named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
> >
> > Signed-off-by: Michael Schaller <misch@google.com>
>
> Thanks
>
> > Tested-by: Michael Schaller <misch@google.com>
>
> I will drop this - in general, it is assumed that you test your own
> patches before sending them to the list, so this is implicit. Also,
> tested-by's given on the list tend to carry more weight than ones that
> are givenin private and added to the patch by the authors themselves.
>
Makes sense. Is anything else needed from my side?
>
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
