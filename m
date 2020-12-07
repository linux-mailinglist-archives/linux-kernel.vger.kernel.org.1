Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD562D1190
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgLGNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgLGNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:14:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B5C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 05:13:40 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id x25so12380276qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcXnREnURSkKdq31weAS6WOq4nCzKUFj7/GbrV733y4=;
        b=pZ7rT6bRk0Q0Dx6dYPgtE0CMjo5WQdg9StuYz80+siqQWdePj8xnUQTx2F6HTF0bGn
         Mhd1CdVB7tyHoVDf+5KnUGUwHz7P11d2IWKn+KVe9sO/rhomc96Wci4Rlm3Fd/Lftsq3
         YSafw7qZl/AV+DxvPBnVmfGTzGbTjRhZt2tTQ/unLt6eGOQv+KxmQHEuwk/wpehJ8zYu
         550R3kRipLT7T4jCu8w75efEYgrSZpsvsG6i/K3neYtLsZ4vS+A9Xn5IreECWF7tWI9u
         RyK+9EBbv0BK+vzItfJwRlJlvWPVu95Uk2XLksrRrYq++790uT6FD4VlMl5lLLDPPdkx
         8Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcXnREnURSkKdq31weAS6WOq4nCzKUFj7/GbrV733y4=;
        b=Bvs5JakVwv2a1TqMI/Bjnz9Z7/1Rx+d5LkiixuLQbsCr1BxoYeYIAYBX9TN9KgyqJ1
         4r49q5yHKgmlYbKXblz68lcmCBcHmEjWNBTxwoqTjpu4nyVnMnxObKHn74cqjAsxd67n
         nz1jZm+0qRVZOPHyWA1xwi8zKLufmYa34TUDa6P2uJDnIvEnJNuMaM0XIBuVTb+6Thss
         1cISpi6s/jbiAd90PFbrARpicmX+iNElAph/GoDn2cKn0ZH4+jU8wRkN7ebJpasbTj/h
         Z7ivY2JtKal066lLUuU6HK4E3T+GNRngb+dGjXL5LsUVyrNMnoHY6Wbn3fXcSNRyalMd
         atkQ==
X-Gm-Message-State: AOAM531dQV/i5jQmdp+bQHkmnQVCfQSrDpT3/bOJbTe5Scn5hoFQzSvk
        tffSmJDc8yAh7LBvI+tOrIqLj6SbWHFBJM+76J5S5Q==
X-Google-Smtp-Source: ABdhPJyG1dTF7cSNdaSx7miaYTvnhKoYrE/w9Epjl+A/KE/9OFKdWzch71C1SK6A/Np6RHujsldmaYCVwXB/VEncetc=
X-Received: by 2002:a05:620a:12e4:: with SMTP id f4mr24987688qkl.265.1607346819025;
 Mon, 07 Dec 2020 05:13:39 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b7551005b05ae3b8@google.com> <CACT4Y+Zc5W9kGUqjVkkuUTBEsLk-1k3eKF5F78-LioWF6XTR0w@mail.gmail.com>
 <CAK+_RLmGVr=ngG+Tqum==sDLEeEEz11su92EnoQVG6Zgm2gxzg@mail.gmail.com>
 <CACT4Y+Yb9UcpO6g+FMZ+4R1PiadcDqKXj7Em4h8+VMrzCdS=9g@mail.gmail.com> <CAK+_RLk6JBKqYj7mVThm+Nrpaj0OoqkGP6rRtb4PaOmphBMRSw@mail.gmail.com>
In-Reply-To: <CAK+_RLk6JBKqYj7mVThm+Nrpaj0OoqkGP6rRtb4PaOmphBMRSw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Dec 2020 14:13:27 +0100
Message-ID: <CACT4Y+abO+WK7dO7PRhZdbTFQO1VoaJ7qfNMH8J9sZWhBgEjAw@mail.gmail.com>
Subject: Re: WARNING: filesystem loop0 was created with 512 inodes, the real
 maximum is 511, mounting anyway
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     syzbot <syzbot+54b10a5da9e59f1ed979@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:08 AM Tigran Aivazian
<aivazian.tigran@gmail.com> wrote:
>
> On Mon, 28 Sep 2020 at 09:29, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Sep 28, 2020 at 10:23 AM Tigran Aivazian
> > > No, this is not an issue. In the latest change to BFS I added the
> > > following comment to the header fs/bfs/bfs.h, which explains it:
> > >
> > > /* In theory BFS supports up to 512 inodes, numbered from 2 (for /) up
> > > to 513 inclusive.
> > >    In actual fact, attempting to create the 512th inode (i.e. inode
> > > No. 513 or file No. 511)
> > >    will fail with ENOSPC in bfs_add_entry(): the root directory cannot
> > > contain so many entries, counting '..'.
> > >    So, mkfs.bfs(8) should really limit its -N option to 511 and not
> > > 512. For now, we just print a warning
> > >    if a filesystem is mounted with such "impossible to fill up" number
> > > of inodes */
> >
> > There are rules for use of "WARNING" in output required to support
> > kernel testing:
> > https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L67-L80
> > This seems to be triggerable by exteranal inputs and breaks these rules.
>
> Thank you, I didn't know about these rules. Ok, then, since this
> warning does not "need prompt attention if it should ever occur at
> runtime", the easiest solution is to change "WARNING" to lower case
> "warning" in that printk in fs/bfs/inode.c:
>
> --- fs/bfs/inode.c.0 2020-09-28 10:03:00.658549556 +0100
> +++ fs/bfs/inode.c 2020-09-28 10:03:05.408548250 +0100
> @@ -351,7 +351,7 @@
>
>   info->si_lasti = (le32_to_cpu(bfs_sb->s_start) - BFS_BSIZE) /
> sizeof(struct bfs_inode) + BFS_ROOT_INO - 1;
>   if (info->si_lasti == BFS_MAX_LASTI)
> - printf("WARNING: filesystem %s was created with 512 inodes, the real
> maximum is 511, mounting anyway\n", s->s_id);
> + printf("warning: filesystem %s was created with 512 inodes, the real
> maximum is 511, mounting anyway\n", s->s_id);
>   else if (info->si_lasti > BFS_MAX_LASTI) {
>   printf("Impossible last inode number %lu > %d on %s\n",
> info->si_lasti, BFS_MAX_LASTI, s->s_id);
>   goto out1;
>
> If you want to submit this patch to the appropriate place(s), feel
> free to do this -- I approve it. If the comment in asm/bug.h is
> inaccurate and its mention of "BUG/WARNING" implies the lowercase
> "bug/warning" also, then one can remove the prefix "warning: " from
> the patch altogether and proper case "filesystem" to "Filesystem".
>
> Kind regards,
> Tigran
>
> Acked-By: Tigran Aivazian <aivazian.tigran@gmail.com>
> Approved-By: Tigran Aivazian <aivazian.tigran@gmail.com>


#syz fix: bfs: don't use WARNING: string when it's just info.
