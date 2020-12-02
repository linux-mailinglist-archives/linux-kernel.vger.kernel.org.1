Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786362CB615
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbgLBH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgLBH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:59:57 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0BFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:59:17 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id x13so302298qvk.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKHjYvC4xyW9ZBjaFtTXHqY7iKDyfm2iEi7x6t6oZvg=;
        b=g3UcSXytzH37E7xJZX+lHNBwc7eh16vqawxxEMuhEiDPdk4JNLOFGqX5Ni6kRHnQYQ
         iETQHkEnAjCG1shKqCxeZlayprobLmvtHwQy67oVtdk3OPfkYxpdhS0/Ap0doNXw59f2
         Jky3eZ4EWDThlDanAgJ3mH4+TYJq/3Y0j8vVg0fMtCUa6eUIhM3ZLfHUlb2SRVnxy8Mk
         x8jjAs5yPfili+ZN3WsUh9wlHRlqVmO3I+d9iss86F4ZCPgA2J7dEwHcre5sJZcejGeO
         aonTmdr31RHtx5YzTt02mLitiVBCEkn89U8q1/0DcvjFORGD6J2p8FnujGRcrGiPWbQp
         pV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKHjYvC4xyW9ZBjaFtTXHqY7iKDyfm2iEi7x6t6oZvg=;
        b=VnIHr+joesVaJPZZL04tlN7ePwWPQV+bt8WF/UuzpiHO8KuMkK67Fr21ESN+eyCcGF
         Q1QI+Qt8ezXjqpd3H7A9ebeUSXBsHAoLAw3ix1j4ajLY6j3ruNFQYxNni2dup/jDVZ1l
         e1ux2+WYCfQbIBuBM8IdEHVrvVDjDdn+bHyIIe6iS3rVlz3rF5A6xTQVRzfmxIgWFu7o
         XOBw31Qyhur7M4/5JLUxOfvzOxFPP3O9BxdliFSdxUm4vQK5OHDMZFD7ebD62PQYi5oy
         BRjvCNG0ZdX22+T8YmysvBbFHU5J/yxcNX+Av+VDtY5ciE0yTUgZ3IqW992XDadhSCbs
         OVFA==
X-Gm-Message-State: AOAM532b69FTi7FiAcqNRgZeBUTyuGlZEaCNld1birPL8qeNp6jEYVv7
        7/IlpIEwPJaDfQX6sTMtDA7omHeM3RziorPSt1jAbw==
X-Google-Smtp-Source: ABdhPJz4lEoEPcYZfGHvE+oA4nIrP8dprYgpNf9VUKlRmPBF8YdYkADCBHvaJ0OZuFVkFRYDFrFFKREV9MLpUOFqX3I=
X-Received: by 2002:a05:6214:58d:: with SMTP id bx13mr1359270qvb.44.1606895956260;
 Tue, 01 Dec 2020 23:59:16 -0800 (PST)
MIME-Version: 1.0
References: <00000000000019cd7c05b515da9a@google.com> <7e108ab1-0b07-50dd-5862-a5121eab6094@infradead.org>
 <CACT4Y+YkH042G=+ErWY+dRLs5H0i1ao1xnSeHvGx8x=dn5KH1A@mail.gmail.com>
 <8d5ec04c-4646-3b70-6f6c-ea989e6c2c59@infradead.org> <CACT4Y+ZByhXxObU0cc6apB8-vMzyD6xu1_WAFtGqzximAvokGA@mail.gmail.com>
 <dc76e615-a2fc-64e1-c979-4699d0d57309@infradead.org>
In-Reply-To: <dc76e615-a2fc-64e1-c979-4699d0d57309@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Dec 2020 08:59:05 +0100
Message-ID: <CACT4Y+Y5VDT8G0UsBuK=6VQhxwaHc_STGQrZXe6Jj_o-d5+0bQ@mail.gmail.com>
Subject: Re: WARNING: filesystem loop5 was created with 512 inodes, the real
 maximum is 511, mounting anyway
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 10:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/30/20 11:47 PM, Dmitry Vyukov wrote:
> > On Tue, Dec 1, 2020 at 2:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 11/30/20 12:43 AM, Dmitry Vyukov wrote:
> >>> On Mon, Nov 30, 2020 at 5:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>>
> >>>> On 11/27/20 4:32 AM, syzbot wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzbot found the following issue on:
> >>>>>
> >>>>> HEAD commit:    418baf2c Linux 5.10-rc5
> >>>>> git tree:       upstream
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=171555b9500000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b81aff78c272da44
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3fd34060f26e766536ff
> >>>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>>>>
> >>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>
> >>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>> Reported-by: syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com
> >>>>>
> >>>>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> >>>>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> >>>>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >>>>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> >>>>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> >>>>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >>>>>
> >>>>>
> >>>>> ---
> >>>>> This report is generated by a bot. It may contain errors.
> >>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>>>
> >>>>> syzbot will keep track of this issue. See:
> >>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>>>>
> >>>>
> >>>> Hi,
> >>>> Can you provide the BFS image file that is being mounted?
> >>>> (./file0 I think.)
> >>>>
> >>>> --
> >>>> ~Randy
> >>>
> >>>
> >>> Hi Randy,
> >>>
> >>> I see this bug was reported with a reproducer:
> >>> https://syzkaller.appspot.com/bug?id=a32ebd5db2f7c957b82cf54b97bdecf367bf0421
> >>> I assume it's a dup of this one.
> >>
> >> Sure, looks the same.
> >>
> >>> If you need the image itself, you can dump it to a file in the C
> >>> reproducer inside of syz_mount_image before mount call.
> >>
> >> Yes, got that.
> >>
> >> What outcome or result are you looking for here?
> >> Or what do you see as the problem?
> >
> > Hi Randy,
> >
> > "WARNING:" in kernel output is supposed to mean a kernel source bug.
> > Presence of that kernel bug is what syzbot has reported.
> >
> > Note: the bug may be a misuse of the "WARNING:" for invalid user
> > inputs in output as well :)
>
>
> [adding Al Viro]
>
> Hi Dmitry,
>
> I expect that the "WARNING:" message is being interpreted incorrectly here,
> but that's a minor issue IMO.
>
>         if (info->si_lasti == BFS_MAX_LASTI)
>                 printf("WARNING: filesystem %s was created with 512 inodes, the real maximum is 511, mounting anyway\n", s->s_id);
>
>
> If you/we look at fs/bfs/bfs.h, it says:
>
> /* In theory BFS supports up to 512 inodes, numbered from 2 (for /) up to 513 inclusive.
>    In actual fact, attempting to create the 512th inode (i.e. inode No. 513 or file No. 511)
>    will fail with ENOSPC in bfs_add_entry(): the root directory cannot contain so many entries, counting '..'.
>    So, mkfs.bfs(8) should really limit its -N option to 511 and not 512. For now, we just print a warning
>    if a filesystem is mounted with such "impossible to fill up" number of inodes */
>
> so one question is why does syzkaller try to do this at all?

Solely for kernel testing purposes.

> Why not set number-of-inodes to 511 instead of 512 in the BFS image file?
>
> However, in testing this, I see that the BFS image is not mounted
> on /dev/loop# at all.
>
> 'mount' says:
>
> # mount -t bfs -o loop bfsfilesyz000.img  /mnt/stand
> mount: /mnt/stand: mount(2) system call failed: Not a directory.
>
> (but it is a directory)
>
> and I have tracked that down to fs/namespace.c::graft_tree()
> returning -ENOTDIR, but I don't know why that is happening.
>
>
> Al, can you provide any insights on this?
>
> thanks.
> --
> ~Randy
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/dc76e615-a2fc-64e1-c979-4699d0d57309%40infradead.org.
