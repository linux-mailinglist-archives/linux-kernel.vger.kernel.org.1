Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DE2C8036
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgK3Ios (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgK3Ior (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:44:47 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:44:07 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z3so7594639qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0mUEi/28IkQVF9GAuCUSVe7UjITAIqbPHEi3fCie7U=;
        b=OqDFyGzJbim4+/PMzWDu/FCXoZpTcdIsTWUJ2ioXOCp+8p/UsYtxU/hTLg2zchqzJK
         x/vrCIR8CcTO6G/D5kLqPxriVOlAi2M874fZwX9Qp001mcm4qjLKtQs0VmGlsDlpWo3Y
         g3s08bKIQRmAZ5mpUnx55Jgox1mZQ/fePup2/o/iDwx/nXF0QgYfhwcWUrzrDaeQIL73
         76kRJRUol7Bc3CQ4a2srOQ2d+6vxnV+L17NebmM8Xw99eTDeg0EoNqgLpfEptu9OJaPB
         whgvCTjQBt1bWNzFXPB/EIaxhjS6vJrFS5mLSEXbV+4d/54oa4+SEo1Tl1Ki8HXR3sAl
         p2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0mUEi/28IkQVF9GAuCUSVe7UjITAIqbPHEi3fCie7U=;
        b=Pf8m+WhNXwnttG20c1tzwBaqZk99bqcdxTyWTYpIBIz6KfJ3n+BC/sia+0RWOqJTZb
         IrKAFt72TTCTMtlpc06TUyK6xIQ0iv4I8VIHcypWOmxS9W8IXuLhOOSuFcHxMqq8+YHR
         FPDM5yKHMFvv0qLJppftbtZLVGPxDYE/3G8NTB9asdP7IJWG9zVeXXyqirjOnjn0jufl
         qSD3AM7UKLjAx6jAUFNP1CdyNPYBu6Kh9E4uXez79Wt7JMU/M4hzVdiF8tcULbJ71lZG
         j3ipLiF4LGOzRWHYpFSuoDbaIJY17oBRucZCG84dOE8xhPTvxuECFvqrsztmfyO/IXZB
         umew==
X-Gm-Message-State: AOAM530c/xg8aK+sBVSq5kPuDYpgACEUdKk0ocSOaUtNLe+AjuA7NKO1
        MiGiwantrb5xgrbsxJOSGj4V0eimOW57N+LnOUAEtA==
X-Google-Smtp-Source: ABdhPJxr3v+5lkkSQJiv8LJioPufqGocTYhVIVmZq0VchgmlkTN7puCihgK/5VFKT7lvUrDR+o/gFktdcbSfAc4eTnA=
X-Received: by 2002:aed:2744:: with SMTP id n62mr20847079qtd.67.1606725846523;
 Mon, 30 Nov 2020 00:44:06 -0800 (PST)
MIME-Version: 1.0
References: <00000000000019cd7c05b515da9a@google.com> <7e108ab1-0b07-50dd-5862-a5121eab6094@infradead.org>
In-Reply-To: <7e108ab1-0b07-50dd-5862-a5121eab6094@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Nov 2020 09:43:55 +0100
Message-ID: <CACT4Y+YkH042G=+ErWY+dRLs5H0i1ao1xnSeHvGx8x=dn5KH1A@mail.gmail.com>
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

On Mon, Nov 30, 2020 at 5:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/27/20 4:32 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    418baf2c Linux 5.10-rc5
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=171555b9500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b81aff78c272da44
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3fd34060f26e766536ff
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com
> >
> > BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> > BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> > BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> > BFS-fs: bfs_fill_super(): loop5 is unclean, continuing
> > BFS-fs: bfs_fill_super(): WARNING: filesystem loop5 was created with 512 inodes, the real maximum is 511, mounting anyway
> > BFS-fs: bfs_fill_super(): Last block not available on loop5: 120
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
>
> Hi,
> Can you provide the BFS image file that is being mounted?
> (./file0 I think.)
>
> --
> ~Randy


Hi Randy,

I see this bug was reported with a reproducer:
https://syzkaller.appspot.com/bug?id=a32ebd5db2f7c957b82cf54b97bdecf367bf0421
I assume it's a dup of this one.

If you need the image itself, you can dump it to a file in the C
reproducer inside of syz_mount_image before mount call.

Thanks
