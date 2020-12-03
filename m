Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7C2CD633
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgLCM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgLCM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:57:07 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C922DC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:56:26 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 4so851366qvh.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 04:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4evJuu83jR5uUwu2NJjS0IVDP3YkHWoJ2j+paDL26Q=;
        b=Du8ds4V/xtuMtSnniOp3eImxwdDDEtH67c6aFatiheMSWm2uCMmBy0lrNNeu3qAIby
         Xx1fqfk19IKE7ZFXwTC4Fny0xbUjtnk28kVFrLfM6786DuU47qsMrrsTggsUuJzpzDrR
         RcC97y4I8SNWnzhvdJRadtdc+pxNrbgDzsELyCrURWvOWXB8HPnatnceghFP5ocxe029
         bCM1kTGzFiNx+49U3KhhtV3VIoZoAUNYxVJ2av8KDa7P+uIzR2sqwMSXPN6RFGUfGpV6
         IXmH2m9YCOCyRtp1/BoGh+MS+XwimEV1B1ae93p9SmTQdjsTIWJl5B8knRpK5kzX34in
         4hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4evJuu83jR5uUwu2NJjS0IVDP3YkHWoJ2j+paDL26Q=;
        b=Vko42Op7kQ2olJPzje+zB1mdnNfiQp4hqYjAcYbmOUJgUq1DV7yrBUKlmOIPoLv5+L
         enV4PlWDHxZJXUy/ef+Azg8kvK6nmc2EGrZqtTKL4SLeb9PTnqiIIqUt5xB72u7O13KR
         m3Mb1+BWv5fo6PGg2Wm30Hu7J7/MFaIihykAx3nO+9FsjMcdDL/sCoF2iDXscqHEgxnG
         cIg3yahjWJaF2Vb51U2rTxXA5HB/ktb0hXCCIMn4HXcyMk0skL+sln7WCnQMx1YnEozT
         I+4V7a0NcUSQgrnm3GrNoDS4RyhbnpqyKilejK2QlPaKHhxOD6QNMTTnW8dyfYiw5wjC
         wa/A==
X-Gm-Message-State: AOAM533Q+P3RSDDzsSBPXgJryhqZM96FigX6NBSEwTn7NFdOD75u5Lsv
        G01UCDgzv4f4qo4LW12jDQej7el0YVyILLVDFc3FbXBtsu4GcQ==
X-Google-Smtp-Source: ABdhPJwiOd1UDAtZEZdB0WUaESzAqz5+GdlxUwkQsdfZwsXkU0rD7XgaF5u5zCw0Jw0D8TzMPjob+i+8fnGZH9jh+lA=
X-Received: by 2002:a05:6214:20a3:: with SMTP id 3mr2896827qvd.13.1607000185708;
 Thu, 03 Dec 2020 04:56:25 -0800 (PST)
MIME-Version: 1.0
References: <00000000000019cd7c05b515da9a@google.com> <7e108ab1-0b07-50dd-5862-a5121eab6094@infradead.org>
 <CACT4Y+YkH042G=+ErWY+dRLs5H0i1ao1xnSeHvGx8x=dn5KH1A@mail.gmail.com>
 <8d5ec04c-4646-3b70-6f6c-ea989e6c2c59@infradead.org> <CACT4Y+ZByhXxObU0cc6apB8-vMzyD6xu1_WAFtGqzximAvokGA@mail.gmail.com>
 <dc76e615-a2fc-64e1-c979-4699d0d57309@infradead.org> <0bc4dbbe-1adb-de9d-641f-bdc2a02efc8b@infradead.org>
 <CACT4Y+bQWBZa0b=sh84rM5TLPTrY-aBLge=eKXEOT=TDZEZxbg@mail.gmail.com>
In-Reply-To: <CACT4Y+bQWBZa0b=sh84rM5TLPTrY-aBLge=eKXEOT=TDZEZxbg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Dec 2020 13:56:14 +0100
Message-ID: <CACT4Y+ZH7W5_eLVXLyrGkX3AOPY3gQFYw_+36knC2KDjdmCefg@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 1:55 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Dec 3, 2020 at 5:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 12/1/20 1:17 PM, Randy Dunlap wrote:
> > > On 11/30/20 11:47 PM, Dmitry Vyukov wrote:
> > >> On Tue, Dec 1, 2020 at 2:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >>>
> > >>> On 11/30/20 12:43 AM, Dmitry Vyukov wrote:
> > >>>> On Mon, Nov 30, 2020 at 5:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >>>>>
> > >>>>> On 11/27/20 4:32 AM, syzbot wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> syzbot found the following issue on:
> > >>>>>>
> > >>>>>> HEAD commit:    418baf2c Linux 5.10-rc5
> > >>>>>> git tree:       upstream
> > >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=171555b9500000
> > >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b81aff78c272da44
> > >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3fd34060f26e766536ff
> > >>>>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >>>>>>
> > >>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> > >>>>>>
> > >>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >>>>>> Reported-by: syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com
> > >>>>>>
> > >>>>>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> > >>>>>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> > >>>>>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> > >>>>>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> > >>>>>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> > >>>>>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> > >>>>>>
> > >>>>>>
> > >>>>>> ---
> > >>>>>> This report is generated by a bot. It may contain errors.
> > >>>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
> > >>>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >>>>>>
> > >>>>>> syzbot will keep track of this issue. See:
> > >>>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > ...
> >
> > >>>> Hi Randy,
> > >>>>
> > >>>> I see this bug was reported with a reproducer:
> > >>>> https://syzkaller.appspot.com/bug?id=a32ebd5db2f7c957b82cf54b97bdecf367bf0421
> > >>>> I assume it's a dup of this one.
> > >>>
> > >>> Sure, looks the same.
> > >>>
> > >>>> If you need the image itself, you can dump it to a file in the C
> > >>>> reproducer inside of syz_mount_image before mount call.
> > >>>
> > >>> Yes, got that.
> > >>>
> > >>> What outcome or result are you looking for here?
> > >>> Or what do you see as the problem?
> > >>
> > >> Hi Randy,
> > >>
> > >> "WARNING:" in kernel output is supposed to mean a kernel source bug.
> > >> Presence of that kernel bug is what syzbot has reported.
> > >>
> > >> Note: the bug may be a misuse of the "WARNING:" for invalid user
> > >> inputs in output as well :)
> > >
> > >
> > > [adding Al Viro]
> > >
> > > Hi Dmitry,
> > >
> > > I expect that the "WARNING:" message is being interpreted incorrectly here,
> > > but that's a minor issue IMO.
> > >
> > >       if (info->si_lasti == BFS_MAX_LASTI)
> > >               printf("WARNING: filesystem %s was created with 512 inodes, the real maximum is 511, mounting anyway\n", s->s_id);
> > >
> >
> > ...
> >
> > >
> > >
> > > However, in testing this, I see that the BFS image is not mounted
> > > on /dev/loop# at all.
> > >
> > > 'mount' says:
> > >
> > > # mount -t bfs -o loop bfsfilesyz000.img  /mnt/stand
> > > mount: /mnt/stand: mount(2) system call failed: Not a directory.
> > >
> > > (but it is a directory)
> > >
> > > and I have tracked that down to fs/namespace.c::graft_tree()
> > > returning -ENOTDIR, but I don't know why that is happening.
> > >
> > >
> > > Al, can you provide any insights on this?
> >
> > OK, with Al's help, here is the situation.
> >
> > If I use a regular file instead of a directory, the mount
> > command succeeds.
> >
> > The printk() from fs/bfs/inode.c that uses the WARNING: string
> > is not a WARN() or WARN_ON(). It's just a printk().
> >
> > <linux/asm-generic/bug.h> says:
> >
> >  * Do not include "BUG"/"WARNING" in format strings manually to make these
> >  * conditions distinguishable from kernel issues.
> >
> > so if I change fs/bfs/inode.c to use "warning:" or "Warning," or "Note:",
> > this little problem should go away.  Is that correct?
>
> Hi,
>
> Yes, any of these prefixes will work (not be considered as a kernel
> issue). syzkaller only matches "WARNING:" verbatim. I don't know about
> all other kernel testing systems, but at least it's distinguishable.
>
> Maybe also worth adding "bfs:" prefix for cases when people stare at
> dmesg afterwards.

Oh, sorry, there are already enough prefixes (BFS-fs: bfs_fill_super():).
