Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE63824E1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHUUDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 16:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:03:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE7F2072D;
        Fri, 21 Aug 2020 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598040218;
        bh=yqh1mdXpcSLnQ7YmrqYC/jS5nW+Rhe7nFWcK9Uz415c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VwpreOGQ0XVfittG9uiZKaO2QGduoOPGTakL0fyyd5UQouefUlXlEqRUvyk0YRGpW
         UPrvpEBOSLctgylICILjSGmQd0rt2dagEc3p5E/mi1Ho/F001o2VnbBzKtp8UBzn8D
         twXYtNfvFKqRz98L9ZlGahczx9N43sfxeZHnqQaM=
Date:   Fri, 21 Aug 2020 13:03:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     syzbot <syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
Subject: Re: KASAN: use-after-free Read in do_madvise
Message-Id: <20200821130337.f4d1f5cd665ab149e1f43ed5@linux-foundation.org>
In-Reply-To: <CAHbLzkqM-x0aD59z0mFRW37JsxRPL+5xKRRfU1qY18LKksQ3ZQ@mail.gmail.com>
References: <000000000000e44b7d05ad6624df@google.com>
        <CAHbLzkqM-x0aD59z0mFRW37JsxRPL+5xKRRfU1qY18LKksQ3ZQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 10:15:45 -0700 Yang Shi <shy828301@gmail.com> wrote:

> It looks the vma is gone. The below patch should be able to fix it:
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index dd1d43cf026d..d4aa5f776543 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -289,9 +289,9 @@ static long madvise_willneed(struct vm_area_struct *vma,
>          */
>         *prev = NULL;   /* tell sys_madvise we drop mmap_lock */
>         get_file(file);
> -       mmap_read_unlock(current->mm);
>         offset = (loff_t)(start - vma->vm_start)
>                         + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> +       mmap_read_unlock(current->mm);
>         vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
>         fput(file);
>         mmap_read_lock(current->mm);

Oh geeze.  Can you please send this along as a real patch, cc:stable,
Fixes: 692fe62433d4c?  Please cc Jan!
