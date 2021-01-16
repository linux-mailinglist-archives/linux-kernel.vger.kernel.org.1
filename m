Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B053B2F8CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbhAPJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbhAPJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:37:15 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDDFC0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 01:36:34 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id u7so6395926vsg.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAvHsPfI/VEdPtM+kQOblZyCmSSt2Gl4OXKdR3eJhR0=;
        b=d5DkrGYGquY9kH2DGhHXy0iUvM9tP+QXAgc8NcaSlPGRMgIWnK5EiPLaB2qWfBfCRT
         K/V7qYg6yJ8Oq0rjsvjElp7+ONGMe1wqoNY3cGCb8bXpHZtpkxoavUMZXtuUzbg3wfIU
         8iK3U5fddW2bamimvCgYCEbdT2B9PVpWnmflkZ8IyS/8qkvyAugnU7IWQHJDX90xkwCq
         TEkj2iz7DvRQEUAlN8dPCk+TIwdY60uXf5jcLH9DSHwYllgFsPe4YXZbN/kPFP9HORtW
         r+i/YR1BMxCZT7aFZGwn398NdHqZAjwud5QeLgoWs3Usz+Qj6RM32Z3vRtRoybh+qqCy
         egYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAvHsPfI/VEdPtM+kQOblZyCmSSt2Gl4OXKdR3eJhR0=;
        b=FXfxjqxYR3h1jHgtdf0E0E8wE0QZJcPmCDNoFY1GzlRdg656zOOdjRrEae/3tSohx9
         ZKPWCTPJJUcg8VOhsq3L/dK2NPGJtri+9NpYz7uEf8HH7LIX/PCTvYNwbCJ/+uUYkU5m
         tbnO1PO7vaSxQrnjgKGn/SFztEI6XZ720b0xZD1wBJ6g4Rf6zhXdMofIZY4T1TlWlx+S
         +zVEesGfz7BF+DHaMD1KU2BqEqOf8ZyTMEDykd72drYj9ZKXHENA3WxAWGrmDHFeDm8M
         lc+SQW/4jjAJupiHGh0f/GuvXbDifjeXm69orrGk3n/TcQAZVmmRwhKPVfzfQEbPFIqS
         OaqA==
X-Gm-Message-State: AOAM532WtulyF0j6rPwAjV5CyQZC3BMHyuVTIx3vmsKXGbnEIMvmCWUK
        1ONLCwxvg5RtXtD16oeCtrT32HcLCJmDgAL1Ltc=
X-Google-Smtp-Source: ABdhPJwxdq+y3xF2QQ9/oxMd+T1+eQ8NfXzpIPKA5NZ+Cy2AWsotnQeM5wULWhnOVzKwwbK3Zciy9t9fLijL1kpzpms=
X-Received: by 2002:a05:6102:a07:: with SMTP id t7mr13059515vsa.30.1610789793966;
 Sat, 16 Jan 2021 01:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20210116093245.47472-1-linmiaohe@huawei.com>
In-Reply-To: <20210116093245.47472-1-linmiaohe@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 16 Jan 2021 15:06:23 +0530
Message-ID: <CAFqt6zZG_6CVcTEPT2yRcXP6_L+cAfM79Hkx6_5=o5o-yQUExA@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: correct obsolete function name hugetlbfs_read_iter()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 3:03 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The func do_generic_mapping_read() is killed by commit 36e789144267 ("kill
> do_generic_mapping_read"). So replace it with do_generic_mapping_read to
> keep comment uptodate.

s/func/function

replace it with generic_file_buffered_read()  ?

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 23ad6ed8b75f..d02616513b43 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -310,7 +310,7 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
>
>  /*
>   * Support for read() - Find the page attached to f_mapping and copy out the
> - * data. Its *very* similar to do_generic_mapping_read(), we can't use that
> + * data. Its *very* similar to generic_file_buffered_read(), we can't use that
>   * since it has PAGE_SIZE assumptions.
>   */
>  static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
> --
> 2.19.1
>
>
