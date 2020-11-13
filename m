Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA582B1E62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKMPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:14:39 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F617C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:14:39 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id y17so8769156ilg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8tmgLVe0QVnnIRjLRBTov7jcTK3VR1uLeyQMoPGugs=;
        b=TyE5LDersmfncx6i1WEQ31JdjIPHQJ2uJUiW5Q/Ew6uOFY9QD39kvdSniaQuYTyKyn
         r+U9o7ctv2+wydyugdx8uMeSags326bUTrTwfLaD3wBSc3nff6DqYJ9Mq0HdhB8kHBG1
         HkOCjesKHeSVWPpmTKSo9DA/YgbLv3pc42XVt/tZEIATqWgzuY+vnKZPZHR5eEIig7t2
         /91WlHLfUYdtThpHQbm7kjpGDivgtF7Z1T0a07gFn3v/VlXzCu0pTEJGiH5JvlAm1g61
         RUE5uEH+5CoCfXRuVF3pqR8Iln8+y952JTg7unsoUFdDELQsqXo0Im7qv665vx9Xn/gy
         mJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8tmgLVe0QVnnIRjLRBTov7jcTK3VR1uLeyQMoPGugs=;
        b=biQ+1wCHr4O8bu2NMDGTZ0JVY25/+4lBURdjNx7OdoqOksSVNlGWANMnVz/qD8N19C
         Rp4vZqMpgcio5j6rEs4a+bzv3Jtpx0jS0AVsn4T/9WjRFtoFT9vMlsRLwDkG6ShXORDO
         /bheZU72tjqVrIi7mF5a28q7TxzJV+/a++i/QrjxVh98pR56eKGxHGuBkLTv7y8a9fS2
         xd3oBkRprLgRsjhz7bQdstnsJhP+gWUKAli6puepS8TDCBpoEf9gBms2xn0oYZISmqkT
         vXPXAbTSdRiBglZGoZ2HJ2DuINkj7/qzdxsS9GmCFXnu7BpLjDL036Q6fY/gyfiFPVaL
         eoDw==
X-Gm-Message-State: AOAM531ZjaC/eBB9F+I4lZKNNgQ3wRGQxLSXQGghrzCL7Is4tbbN+XcA
        gxUna4CtH73u6k5W3MsRVs9wn+qcpYPydV5lLek=
X-Google-Smtp-Source: ABdhPJxQV4da3rxcBfVIBeHEkfu8gz4/gtZofefwV1S5OTVXHEoanPrftTn0wZeOOa+3Nyv/nVwXdSrnfYhU6pEvtZw=
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr211397ilg.85.1605280478912;
 Fri, 13 Nov 2020 07:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20201113135427.GA167783@rlk>
In-Reply-To: <20201113135427.GA167783@rlk>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 13 Nov 2020 16:14:28 +0100
Message-ID: <CAM9Jb+iB0pbhhh=EwbG0TD2C=2-fQhiW9dUf03gSmOsjNnQ-8g@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem.c: make shmem_mapping() inline
To:     Hui Su <sh_def@163.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> inline the shmem_mapping(), and use shmem_mapping()
> instead of 'inode->i_mapping->a_ops == &shmem_aops'
> in shmem_evict_inode().
>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  include/linux/shmem_fs.h | 2 +-
>  mm/shmem.c               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a5a5d1d4d7b1..154a16fe7fd5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -67,7 +67,7 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>                 unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
>  #ifdef CONFIG_SHMEM
> -extern bool shmem_mapping(struct address_space *mapping);
> +extern inline bool shmem_mapping(struct address_space *mapping);
>  #else
>  static inline bool shmem_mapping(struct address_space *mapping)
>  {
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..7395d8e8226a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1152,7 +1152,7 @@ static void shmem_evict_inode(struct inode *inode)
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>
> -       if (inode->i_mapping->a_ops == &shmem_aops) {
> +       if (shmem_mapping(inode->i_mapping)) {
>                 shmem_unacct_size(info->flags, inode->i_size);
>                 inode->i_size = 0;
>                 shmem_truncate_range(inode, 0, (loff_t)-1);
> @@ -2352,7 +2352,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>         return inode;
>  }
>
> -bool shmem_mapping(struct address_space *mapping)
> +inline bool shmem_mapping(struct address_space *mapping)
>  {
>         return mapping->a_ops == &shmem_aops;
>  }

Reviewed-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
