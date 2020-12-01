Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAC2C9897
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgLAHsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgLAHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:48:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F96C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:47:40 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id x25so505898qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qqyEWdRWEg/EjHxEOCLVuoTMAb3qcOPZUsJk/MqvKY=;
        b=tFdmW375ShL7zUn96/zfU9VmdPduNhi4F7NDbl+7vq6HgabLmaYkST2+6ZysRwkE4j
         Z+2nkXUeouX+eazkAElCIYR7gyD0B0gQnOKYo8Esb5UhSJ4fQQJAqTnQgFNHHVUxq5CS
         9XVZFUOghNvTQEbz01H53Ndt85y8S0Iu05RY3zrqX2e2kyc9A7W3BOzsWE6ukivoRFMj
         0a5Ksi3Gj1OXSVLBGw7o1yT382xV3pm9aatBKVAV6PI7RQeKxYgA6v3RRjFVORtHY+rO
         z5egHfZs7b47WP6jAe4k/5hIPPvQaf9BZjciYbWnzjqIJYT+54TD7G5+hAg+vo5bDn4b
         Lv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qqyEWdRWEg/EjHxEOCLVuoTMAb3qcOPZUsJk/MqvKY=;
        b=qVJA0k4OQVhNTII5WBhmaHDFjxbohVWbeyIDcl6S2+69pqdLdBQcWF0vB+XSvtj5rq
         rs6Ej667QhpVO8dfHPGGzpL4tregFWf1A79CskBCT1nUuJArCinnoAcr7QzoJz2//eYD
         f6Riei3CXt2Z1S6XDtSvdstQfxjEaEbJfAgpElip1EooroF5VmZ6aowAWqzqTGneIynL
         BVQdYJBmg0moThBuTF2EAj7S6dYpS6rycQFOzw6BPG+MjIstPU0KnFYW5pWp6RtBc2WW
         O44y+NYK0nAPbSgrLybTfCmVfBVkRr0rH1u2WKaxGazoLNtvaExl0jppzaDXnT3BBH+C
         duNQ==
X-Gm-Message-State: AOAM533WgGqTrCq4EH2h3g9Qiup5Ik5wvBQBJ1qxtHZ6zHbEbnXLvS9M
        Lz1hbO/bC7lvgbmVSK57yXzDbXJBwEqgl59FzG5epQ==
X-Google-Smtp-Source: ABdhPJwTqG+0b13ZG4tpnx8yqnTTo9GlOPx2Ta1rhkx4qY7OPTs3hTLkDh4gUat0wkmLyTBwobd/3ng4mMVAvyjaF4Q=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr1578379qkm.231.1606808859004;
 Mon, 30 Nov 2020 23:47:39 -0800 (PST)
MIME-Version: 1.0
References: <00000000000019cd7c05b515da9a@google.com> <7e108ab1-0b07-50dd-5862-a5121eab6094@infradead.org>
 <CACT4Y+YkH042G=+ErWY+dRLs5H0i1ao1xnSeHvGx8x=dn5KH1A@mail.gmail.com> <8d5ec04c-4646-3b70-6f6c-ea989e6c2c59@infradead.org>
In-Reply-To: <8d5ec04c-4646-3b70-6f6c-ea989e6c2c59@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Dec 2020 08:47:27 +0100
Message-ID: <CACT4Y+ZByhXxObU0cc6apB8-vMzyD6xu1_WAFtGqzximAvokGA@mail.gmail.com>
Subject: Re: WARNING: filesystem loop5 was created with 512 inodes, the real
 maximum is 511, mounting anyway
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/30/20 12:43 AM, Dmitry Vyukov wrote:
> > On Mon, Nov 30, 2020 at 5:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 11/27/20 4:32 AM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    418baf2c Linux 5.10-rc5
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=171555b9500000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b81aff78c272da44
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3fd34060f26e766536ff
> >>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com
> >>>
> >>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> >>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> >>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >>> BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> >>> BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> >>> BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >>>
> >>>
> >>> ---
> >>> This report is generated by a bot. It may contain errors.
> >>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>
> >>> syzbot will keep track of this issue. See:
> >>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>>
> >>
> >> Hi,
> >> Can you provide the BFS image file that is being mounted?
> >> (./file0 I think.)
> >>
> >> --
> >> ~Randy
> >
> >
> > Hi Randy,
> >
> > I see this bug was reported with a reproducer:
> > https://syzkaller.appspot.com/bug?id=a32ebd5db2f7c957b82cf54b97bdecf367bf0421
> > I assume it's a dup of this one.
>
> Sure, looks the same.
>
> > If you need the image itself, you can dump it to a file in the C
> > reproducer inside of syz_mount_image before mount call.
>
> Yes, got that.
>
> What outcome or result are you looking for here?
> Or what do you see as the problem?

Hi Randy,

"WARNING:" in kernel output is supposed to mean a kernel source bug.
Presence of that kernel bug is what syzbot has reported.

Note: the bug may be a misuse of the "WARNING:" for invalid user
inputs in output as well :)
