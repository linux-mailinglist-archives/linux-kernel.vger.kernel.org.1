Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04E2E0C93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgLVPSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgLVPSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:18:48 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C46C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:18:08 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id s42so4457213uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNvEywE4N7FwZmVI1O0uZ1CSue5bVfV4HsVUoFw6O1k=;
        b=tU997nhp1DAk8WDgVSQidbAlIcd81As9uEyx6upqk/DIAlddNALgnswvNtu7bvf+Er
         GK4+nxPgtY1/UJIFKfsHLhCEFZqM8htZ/nlGdPIKMI3PGI6j4o8dZzTqET5t+DdLSip+
         oB5jVwM5+cWFyOwbDCyXCtNedqJ+Ol3y+57yL9TJGu9cxNtmWtIyy44MiCanfrkDtueS
         pvsSgfh1SwRoAOvijK/0qa45jY0dOznTCXMItKSpLoRzOI5G8JH7pNnL34TdflIswph5
         m7ytV2G6ijG3XjuCcA/w4/D5XbU0Udp2QhiM9Jx9BW2OGlWPJl5DDR9bQf+pTrTAG139
         EYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNvEywE4N7FwZmVI1O0uZ1CSue5bVfV4HsVUoFw6O1k=;
        b=RAxr0Xn2gegX7+o09o1mOEajTmZy3x49+xQFk/WnADGUycrsJimr0VsGrG9HjCbMCo
         NWyJVJ1NLIfr1EjcZpwtboXeoqY34m0o8bK8QlZs4htMCTZ6k9NTTSlJJfT5JX4uyHxl
         l3KLgIcMAenydm5F7F9xdl5AEC53Aiq57qvUxUPNHFI/BR8pq8cHi/PprEWHBS5Wx7jc
         0cEk8TINutVNk3f7u4zcRWBCYCaym/UZa5+5wpILhdQdg9t9K5oUeiGskDY0dvjB5oLy
         6VYkKtMh6BctCZ1vlM+fpRAdSx9fzZY94rk1e5Kf979vTDY2c2c8F7lqu8FHXQpdbHNw
         7imw==
X-Gm-Message-State: AOAM533OiG+IiHt5k1YLT4b6KtOO9vPoLQHXCPDre6/ncCnsYGjbFKoF
        BXVnSYjBNID9v5ZFdZxd6JoRDL5WHscJbopY/cEWAdwtkRI=
X-Google-Smtp-Source: ABdhPJxvdka2CI7hyYHWtvX8AN1FAHBX2wMt8FNrpRzIDAVUo3DNtaC5VrWaErbMv03D8ZDL9yFFr8zY7fapvCgz4NA=
X-Received: by 2002:ab0:2e8e:: with SMTP id f14mr15643141uaa.22.1608650287878;
 Tue, 22 Dec 2020 07:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20201222103249.30683-1-adrianhuang0701@gmail.com>
In-Reply-To: <20201222103249.30683-1-adrianhuang0701@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 22 Dec 2020 20:47:56 +0530
Message-ID: <CAFqt6zaOuJQ9Gg9nyjbN-=e-EkyWiL2n8YKQ-Wzh8Qmm2-icdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: mmap: Remove unnecessary local variable
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 4:03 PM Adrian Huang <adrianhuang0701@gmail.com> wrote:
>
> From: Adrian Huang <ahuang12@lenovo.com>
>
> The local variable 'retval' is assigned just for once in __do_sys_brk(),
> and the function returns the value of the local variable right after
> the assignment. Remove unnecessary assignment and local variable
> declaration.
>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/mmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dc7206032387..482c0c0bbe06 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -189,7 +189,6 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
>                 struct list_head *uf);
>  SYSCALL_DEFINE1(brk, unsigned long, brk)
>  {
> -       unsigned long retval;
>         unsigned long newbrk, oldbrk, origbrk;
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *next;
> @@ -281,9 +280,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>         return brk;
>
>  out:
> -       retval = origbrk;
>         mmap_write_unlock(mm);
> -       return retval;
> +       return origbrk;
>  }
>
>  static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
> --
> 2.17.1
>
>
