Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E32CD62A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgLCM4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLCM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:56:12 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127FC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:55:32 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id l7so1181795qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rBFG6ExwyAbIDn7yw6rlZcjwORGcSu4dCuu0Ee3L8I=;
        b=qQjFjYli9+L9TytDZLvsO8jw4CdE/09DU0FJMonaWTy6+HawZ+pdLrQ6dzB0JhKR3O
         NmQD/H5CGz5gtOo5vWcAPP1iCJI8Bt7G0ne5PmRv+mStU4ycPrPKfFvY0zLBOq7kPtPv
         Q2oVYDmIPkaSewY3lHi1teDST0LsNJdCkrsNgUsoP6lGxX+NhoO0LIF9v+m1pSmm5TRV
         q64xnI6CmHH345fH0FcQpVy2G1AgBtOT+vOyAI/mlJ9Zpl5ez5VdUdB3/6+MXe5Q1FMq
         JWe/OjUIeJoNAXeY9HD7Mz7vHYZXwTwVxYYWRtNL6VOZbNAu3IOmj+3MNxvizeaNSrxY
         +k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rBFG6ExwyAbIDn7yw6rlZcjwORGcSu4dCuu0Ee3L8I=;
        b=qKFhvgUuZq65pDSuAEZizWlHidDOdSAmC/e/Q8/z2IB3OVyxjrg6+F4h8VCo+lhSn3
         t1GDgZfinxWj/iswUcPvqHFs/VNvRDTJCbZ9n9AH6PtwrssyrhtvpojjmTq+f0xW1Jcz
         y6uFj527/Ac0CVnZWWC4Vw+J9NqvGro6h0D9Q5PpJp2F229v1LOl6nxAbT25/9LtdVbF
         fT0nn5I3IVKKHDJCwnFI9DaYDCNhVTEL1UFkcOeJaf7URJ1HH7aw8UXEufEt+Xmq3L/E
         B3bYmTuOIe4Acljs6m9p+A0oS8WNPnlIP/qz+dmsn67OSKbVNufh9GaQgjxlusUPtT/Z
         W2Lg==
X-Gm-Message-State: AOAM532HEoL4IEhvuV7wuHQyhs4QJs9z4irA4K28s53SPfyib3MKWkeq
        wgovhhjcoqutTH2RDdB8BgeHlHfDvF6LyrHaqnsOgA==
X-Google-Smtp-Source: ABdhPJxe9eyIR4Pm3RQfvudbDipcWUsQIYfzd40249mD0LtLOGYDzvDm2PyyGh9pXcjNBc4CQBmzrrwiuyiPa4fkI5w=
X-Received: by 2002:ac8:5386:: with SMTP id x6mr2974030qtp.43.1607000131342;
 Thu, 03 Dec 2020 04:55:31 -0800 (PST)
MIME-Version: 1.0
References: <00000000000019cd7c05b515da9a@google.com> <7e108ab1-0b07-50dd-5862-a5121eab6094@infradead.org>
 <CACT4Y+YkH042G=+ErWY+dRLs5H0i1ao1xnSeHvGx8x=dn5KH1A@mail.gmail.com>
 <8d5ec04c-4646-3b70-6f6c-ea989e6c2c59@infradead.org> <CACT4Y+ZByhXxObU0cc6apB8-vMzyD6xu1_WAFtGqzximAvokGA@mail.gmail.com>
 <dc76e615-a2fc-64e1-c979-4699d0d57309@infradead.org> <0bc4dbbe-1adb-de9d-641f-bdc2a02efc8b@infradead.org>
In-Reply-To: <0bc4dbbe-1adb-de9d-641f-bdc2a02efc8b@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Dec 2020 13:55:19 +0100
Message-ID: <CACT4Y+bQWBZa0b=sh84rM5TLPTrY-aBLge=eKXEOT=TDZEZxbg@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 5:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/1/20 1:17 PM, Randy Dunlap wrote:
> > On 11/30/20 11:47 PM, Dmitry Vyukov wrote:
> >> On Tue, Dec 1, 2020 at 2:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>
> >>> On 11/30/20 12:43 AM, Dmitry Vyukov wrote:
> >>>> On Mon, Nov 30, 2020 at 5:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>>>
> >>>>> On 11/27/20 4:32 AM, syzbot wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    418baf2c Linux 5.10-rc5
> >>>>>> git tree:       upstream
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=171555b9500000
> >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b81aff78c272da44
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3fd34060f26e766536ff
> >>>>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>>>>>
> >>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>>> Reported-by: syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com
> >>>>>>
> >>>>>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> >>>>>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> >>>>>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >>>>>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> >>>>>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> >>>>>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >>>>>>
> >>>>>>
> >>>>>> ---
> >>>>>> This report is generated by a bot. It may contain errors.
> >>>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>>>>
> >>>>>> syzbot will keep track of this issue. See:
> >>>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> ...
>
> >>>> Hi Randy,
> >>>>
> >>>> I see this bug was reported with a reproducer:
> >>>> https://syzkaller.appspot.com/bug?id=a32ebd5db2f7c957b82cf54b97bdecf367bf0421
> >>>> I assume it's a dup of this one.
> >>>
> >>> Sure, looks the same.
> >>>
> >>>> If you need the image itself, you can dump it to a file in the C
> >>>> reproducer inside of syz_mount_image before mount call.
> >>>
> >>> Yes, got that.
> >>>
> >>> What outcome or result are you looking for here?
> >>> Or what do you see as the problem?
> >>
> >> Hi Randy,
> >>
> >> "WARNING:" in kernel output is supposed to mean a kernel source bug.
> >> Presence of that kernel bug is what syzbot has reported.
> >>
> >> Note: the bug may be a misuse of the "WARNING:" for invalid user
> >> inputs in output as well :)
> >
> >
> > [adding Al Viro]
> >
> > Hi Dmitry,
> >
> > I expect that the "WARNING:" message is being interpreted incorrectly here,
> > but that's a minor issue IMO.
> >
> >       if (info->si_lasti == BFS_MAX_LASTI)
> >               printf("WARNING: filesystem %s was created with 512 inodes, the real maximum is 511, mounting anyway\n", s->s_id);
> >
>
> ...
>
> >
> >
> > However, in testing this, I see that the BFS image is not mounted
> > on /dev/loop# at all.
> >
> > 'mount' says:
> >
> > # mount -t bfs -o loop bfsfilesyz000.img  /mnt/stand
> > mount: /mnt/stand: mount(2) system call failed: Not a directory.
> >
> > (but it is a directory)
> >
> > and I have tracked that down to fs/namespace.c::graft_tree()
> > returning -ENOTDIR, but I don't know why that is happening.
> >
> >
> > Al, can you provide any insights on this?
>
> OK, with Al's help, here is the situation.
>
> If I use a regular file instead of a directory, the mount
> command succeeds.
>
> The printk() from fs/bfs/inode.c that uses the WARNING: string
> is not a WARN() or WARN_ON(). It's just a printk().
>
> <linux/asm-generic/bug.h> says:
>
>  * Do not include "BUG"/"WARNING" in format strings manually to make these
>  * conditions distinguishable from kernel issues.
>
> so if I change fs/bfs/inode.c to use "warning:" or "Warning," or "Note:",
> this little problem should go away.  Is that correct?

Hi,

Yes, any of these prefixes will work (not be considered as a kernel
issue). syzkaller only matches "WARNING:" verbatim. I don't know about
all other kernel testing systems, but at least it's distinguishable.

Maybe also worth adding "bfs:" prefix for cases when people stare at
dmesg afterwards.
