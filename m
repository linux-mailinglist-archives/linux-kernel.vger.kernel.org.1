Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FD28B143
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgJLJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:16:42 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgJLJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:16:41 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKKIZ-1klTnU3jqR-00LpWs for <linux-kernel@vger.kernel.org>; Mon, 12 Oct
 2020 11:16:40 +0200
Received: by mail-qv1-f51.google.com with SMTP id t20so8077367qvv.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 02:16:39 -0700 (PDT)
X-Gm-Message-State: AOAM531lWakvT11//kso2w/vUgNQsXKo76qj0R9H8znnZMv+PpSSgKnf
        /wYydIwxuExWXIPhG0XK0IUQBnFN23xe24nM4tY=
X-Google-Smtp-Source: ABdhPJyjbd3z2377x4FuP1FBq7UMVo+WDBeHGILAwQYfvFNPNFZ5hS5CFKemTggI0xsyYp71ceWxP5wO6z0wpLdGk+Q=
X-Received: by 2002:a0c:9b9e:: with SMTP id o30mr6859283qve.16.1602494198843;
 Mon, 12 Oct 2020 02:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000903b5c05b1732a75@google.com> <CAK8P3a3p7Ueydagr4yshr8RKGzLivJZwEh0TxfipuHYRkN9Wcw@mail.gmail.com>
 <CACT4Y+aXuBZbvwM1xJNPhG+dHCdjt_Are=p6wRwOk-DFHEGz2Q@mail.gmail.com>
In-Reply-To: <CACT4Y+aXuBZbvwM1xJNPhG+dHCdjt_Are=p6wRwOk-DFHEGz2Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Oct 2020 11:16:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28w8kw9MJVx_Cada3c8tQBHT0xXheS2EmGdRgT=2jp6Q@mail.gmail.com>
Message-ID: <CAK8P3a28w8kw9MJVx_Cada3c8tQBHT0xXheS2EmGdRgT=2jp6Q@mail.gmail.com>
Subject: Re: general protection fault in qp_release_pages
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     rgerganov@vmware.com,
        syzbot <syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yum7ZFPL3PfTD8gX6of6DsGQYURqqNOKPyXrHYhDg6alk8sU2a9
 gFQJz+B4qwY2vplHa2qKwcDy72XQmecPodkSni06KmNUHLsJ+vPq7Wk5F0gY780Tq3naEBk
 +s6BAG9yrgYDIUgoKXKVwPSv+LF/1/b+keisKMaiQNqJspwXgqFsjYcW+A5NFgTjfr1nic8
 ZchSyAFgFzTcAJs3C7+Ew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kleoYoxVBX0=:Z3DjFHVMJdY8IDZ0fEYvx6
 UczQ0mnjt2rt/tLAMBpFJpYXq2l6gBfhNzsKDd7QLJYptQEA3fwys5KjHUuyc5uWG0wjod7gM
 Y3YxD9E5B46UUG84jNDht/ZrzVdHRjAGRKPmRRIyjb0kqVz9c/TgH8JJ/Fbt5WMyBivT8wUTn
 XyJytzF4cZGAM9OgYmBwFVDlcNC6xhcY0KKGgcpgcvsdLuPAa2MDtHjEvrn8cz5NrkCz1n0Ct
 JYbGEj7JvMTxy1ZW6eBNqCBZdqt/6DtpJO+1OKd1PGPP5I7hGL3B+okwBnwf0LxkytCh3SWwv
 5KUG+eG1vBZLzb1Q7jmJd7PxXhPZx8shHdKQm0aiGEvjmTGpWJauETFlc/MU8YWnr11gdP5EV
 YmNCGzaPJk5H6D2plvXEYjEoCw6pXKBuR97EB2JmSv6LBG3RAqztFAUulNW5vYyYLNUTf98QA
 B//f8PArULg/IWqSgWu5Sz0QosQJTmPotNWEDQIjIWTpGFlWe7cWNJuFwDiNdQDRk9VSgSTdG
 MSwzVpT/7u1YB7bi8CrZlrFZPS3xp+JvhtrEbzWOcl+6+H51QrhI0TSHKSUK9b8zCQKAFkMg5
 apmYbab5Fqv8ma56TDaswX966JySUrIaW7DD+b3tTM05Dri2U7F1uhyTAc/ALewElzGzZX1Xz
 dfb8t/RB/fc/YONRAZvtYBilrLHuDYBmT4bNoef+FNYaF+At2/hnhm7dPw4hCFBaVX737cCsF
 1u9z4obda3mt/OFuagKsNdangF38WlJ5B1cM7Zcsr5XkhbRupraM01Km9n7UTee9I6ErZMvYR
 t8w5MgBQph81ap5Fi0U7avHBwsi8vEYUi1e9wr6qu1n/uZLfYjHSrcOPClphBy36hmY3j5N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:14 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Oct 12, 2020 at 10:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Oct 12, 2020 at 8:11 AM syzbot
> >
> > Adding everyone from the git history that did meaningful changes in the past
> > for this driver, as there is no specific maintainer file entry for
> > them to further
> > investigate.
>
> Hi Arnd,
>
> There is already a recorded fix for this on the dashboard:

Ok, good.

> https://syzkaller.appspot.com/bug?extid=f58fe4bb535845237057
> VMCI: check return value of get_user_pages_fast() for errors

Ah, I actually looked at linux-next, which included the fix. I had
never before looked at the dashboard, good to know where to find
this information.

If this is something that happened to others as well, could the
email report be changed to point out bugs that are already
fixed in linux-next but not in mainline?

     Arnd
