Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A12F8CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAPJkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAPJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:40:32 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509E0C061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 01:39:52 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a31so3757285uae.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FhgwJtmgN313McuIkkUvMe9rIKF3WqHs+98mKu1M60=;
        b=BCip+nt0PZQdqiTwQgUWU8yAnfYeCrnfctn2e2b8qBuuakOxgQsiVlSyPKS3jEpO1R
         yvwWZ+41My/TvkfH7HzpFXOVCqNOxfC7blN+MTjW1bG/OITJb2lxL9rSJuRkl3ZimDEk
         ubT+P4zy6GeXgMIu9/Wh8F2v5fWlLtNNepMwXlYoZhNVCliU8BkKeXNAqWdHZCHlrM5X
         jFGehWaEHOfw4V6FnBR0Xth7iZ18rsAUqSmNfF/jIScJmtAA/ZDyhRnw4Qqpl2mJ7+e3
         JFMqGsSXPKVBxlQoIO1L+Krq9Zh8SghboW7P5jNoZmRl1TvDljKGRFrt6XYsTrEYhIW5
         rYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FhgwJtmgN313McuIkkUvMe9rIKF3WqHs+98mKu1M60=;
        b=FXcMn/8d+cKO1zn65D2QviT8+f/2Yjdfy1bShw58vEVXotsxf2TyfylN7gqt0Py8DF
         qEGXXSQgxGrf7vBnkhRJcmgLWpDKhPeRR5b7DF3J722uungCZ/bzzxbZH3oT/3y/zFv+
         MkU+h44EB2chJOy3p7oi0LT+C5s5TnBN4ZAeizwsnnFjTcnI9fOz5VG1+QsuqX/cgtMd
         bX5Ng4Yz9n5da0nmHB3JIL9GFtBa5WVyEMpyF00QWZ1VfcicNt/AytNrQyld24DBHl36
         I9aNaseUqqGHK/5nEQ5lNsZ4L0htP1yOKeCm0/h/9y2dPcGV1jQ8osMbfgS5mmOUmHu7
         IKqw==
X-Gm-Message-State: AOAM532TdBGwbErqcqYayhQegro1AGfHGSsgADhyD0rl3kGjelpTtzB5
        /KUsZW3XQHnh142QQFrRFJqvIeYetCLtE77OGBczN2LO9FI=
X-Google-Smtp-Source: ABdhPJyPgu7/crtRCyOE8M7c7XAIyE0W0AkwTszmGQeeeqgi0JmPfHR7F7jFyj8PriBUBe3FmRIy0OrvxZT7CZ/2Rks=
X-Received: by 2002:ab0:127:: with SMTP id 36mr12484134uak.118.1610789991317;
 Sat, 16 Jan 2021 01:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20210116092644.42697-1-linmiaohe@huawei.com>
In-Reply-To: <20210116092644.42697-1-linmiaohe@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 16 Jan 2021 15:09:41 +0530
Message-ID: <CAFqt6zbE+Fa1E48ijhWjo1pZDXoQUZSj+x3FVauLNefS5G5E7A@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: remove meaningless variable avoid_reserve
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 2:57 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The variable avoid_reserve is meaningless because we never changed its
> value and just passed it to alloc_huge_page(). So remove it to make code
> more clear that in hugetlbfs_fallocate, we never avoid reserve when alloc
> hugepage yet.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/hugetlbfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 88751e35e69d..23ad6ed8b75f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -680,7 +680,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>                  */
>                 struct page *page;
>                 unsigned long addr;
> -               int avoid_reserve = 0;
>
>                 cond_resched();
>
> @@ -717,7 +716,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>                 }
>
>                 /* Allocate page and add to page cache */
> -               page = alloc_huge_page(&pseudo_vma, addr, avoid_reserve);
> +               page = alloc_huge_page(&pseudo_vma, addr, 0);
>                 hugetlb_drop_vma_policy(&pseudo_vma);
>                 if (IS_ERR(page)) {
>                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> --
> 2.19.1
>
>
