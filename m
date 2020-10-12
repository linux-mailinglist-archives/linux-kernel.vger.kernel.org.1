Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72E28B18B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgJLJ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgJLJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:29:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 02:29:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ev17so8089515qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hx1JxtMpGOBSkvdiTGALFPxyGJvgmhTvMTBp0XSjrI4=;
        b=Tl9rF0B+WZ9zXfdHdek6SO9b9G50iTzazFdS8GxCK9MzOMhjPxWG0jb6mkBeYwcolY
         sAGIUTojwWqSEfmYxLrUs58D5kSzqk7Aha7lKEqHlT5gaj+2DzgtmD8B86xFbPeIbr+c
         HyrGPjsZmqWYYLOxLbpSQwR5bh5ikhi9yzfA8GidMCE8523Y7/Bshv47vpRbNIx1AH2O
         WZqPYLkm4VqHo17nNmHRxkMJWLN/M94Qf2wBJzkI7ZnGZli0WYa3a9rjqF+WCQwgWHYq
         GUkzsHjCuHwOJR/q+gItI2Hf9BWfI4WrlXT9uPwWqlXwhXnIHsTtccALdmOkQvl38Eh+
         ieeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hx1JxtMpGOBSkvdiTGALFPxyGJvgmhTvMTBp0XSjrI4=;
        b=fPPckaBeuB9vl2F40Q1bJZROsKamPROO0xydb86YyD3O9lWf8dFFX4p0Sc1y/JHb15
         0hFLggiy9EITJKRjVCTM6brw9sUsqHdvYz+wlYBHaVrkzGpu5ihE83PuFVIuiO5dEbO3
         Q0DL2N5yP4gmcnK1K9iX2RQG7UZV4AILmgDlNlW+RSh6uGV1+a+0JBApoulBKpoeF34h
         2O8tBq1ghH2OLd7wFrBM2g9VhIfJHtVEDCTjYbVlHMFl3RiDoslji543vp/pWrdLP1mk
         G6RyP4rarQFbEKaO18f9nk5YJJPhYeRz/hujswos0MJvPLoXeSars4KZX1Oln68Ql/R1
         Nmag==
X-Gm-Message-State: AOAM533HKoUF7sTkLtI+Tmr/RvES6UXMjGsYiYj2ulyFd2reJLTs3QNu
        afiXIjz3s/tK2xH4Ftiz1YBzkmhbZsus6PfoMg6GXw==
X-Google-Smtp-Source: ABdhPJxQqBkaKsbjXs5AHi2ivpzhyL+UQ/VYvlfrtZska+XY7zzsso3Es5Rqg3N7kBXnI7jdrAR0jjlb99FYC58RbJo=
X-Received: by 2002:a05:6214:184c:: with SMTP id d12mr24976264qvy.11.1602494986800;
 Mon, 12 Oct 2020 02:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000903b5c05b1732a75@google.com> <CAK8P3a3p7Ueydagr4yshr8RKGzLivJZwEh0TxfipuHYRkN9Wcw@mail.gmail.com>
 <CACT4Y+aXuBZbvwM1xJNPhG+dHCdjt_Are=p6wRwOk-DFHEGz2Q@mail.gmail.com> <CAK8P3a28w8kw9MJVx_Cada3c8tQBHT0xXheS2EmGdRgT=2jp6Q@mail.gmail.com>
In-Reply-To: <CAK8P3a28w8kw9MJVx_Cada3c8tQBHT0xXheS2EmGdRgT=2jp6Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 12 Oct 2020 11:29:35 +0200
Message-ID: <CACT4Y+ZR9LMRHHYazd7okt0HpA+WjXDpXW9VM50KM7ozd1m+bQ@mail.gmail.com>
Subject: Re: general protection fault in qp_release_pages
To:     Arnd Bergmann <arnd@arndb.de>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     rgerganov@vmware.com,
        syzbot <syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 12, 2020 at 10:14 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Oct 12, 2020 at 10:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Oct 12, 2020 at 8:11 AM syzbot
> > >
> > > Adding everyone from the git history that did meaningful changes in the past
> > > for this driver, as there is no specific maintainer file entry for
> > > them to further
> > > investigate.
> >
> > Hi Arnd,
> >
> > There is already a recorded fix for this on the dashboard:
>
> Ok, good.
>
> > https://syzkaller.appspot.com/bug?extid=f58fe4bb535845237057
> > VMCI: check return value of get_user_pages_fast() for errors
>
> Ah, I actually looked at linux-next, which included the fix. I had
> never before looked at the dashboard, good to know where to find
> this information.
>
> If this is something that happened to others as well, could the
> email report be changed to point out bugs that are already
> fixed in linux-next but not in mainline?

When syzbot mails a report, it does not know about any fixes by definition.

There is a pending feature request to notify when a fix becomes known:
https://github.com/google/syzkaller/issues/1574

However:
1. This will double the number of emails from syzbot, not sure if it
will be welcome.
2. This probably only makes sense for fixes that are auto-discovered
in git trees. While this one came from a user email, it was just not
sent to the same thread/recipients (the common problem of replying to
emails you did not receive). So it would not help in this case.
3. There is lots of other dynamic info on the dashboard (more crashes,
where it happens, how frequently, when started/stopped). It's not
feasible to send an email for every update (there can be 100K
crashes), so the dashboard needed to be looked at in some cases
anyway.

Do you see any potential improvements in this context?
