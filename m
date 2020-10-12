Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0777A28B1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgJLJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:51:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:51:35 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N4NHS-1kIj7j1dHq-011RZv for <linux-kernel@vger.kernel.org>; Mon, 12 Oct
 2020 11:51:33 +0200
Received: by mail-qt1-f172.google.com with SMTP id h12so11606443qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 02:51:33 -0700 (PDT)
X-Gm-Message-State: AOAM530QXkHEZavWM406ZHLsQRGHQVtowGPX95acLyTChsaBeWfOqc7A
        ChzcgY6OA/Ds0HkuckUbEbozieWxOPL3sNKnOmg=
X-Google-Smtp-Source: ABdhPJybgNBURAnNmdKZmxiX+3KSvJNk/TfkwLVvpPfBSt5CrIghcCsbWwMabbtD4jdqQ2V4VyvBbYst7godEzyDlDw=
X-Received: by 2002:ac8:4808:: with SMTP id g8mr8829765qtq.18.1602496292175;
 Mon, 12 Oct 2020 02:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000903b5c05b1732a75@google.com> <CAK8P3a3p7Ueydagr4yshr8RKGzLivJZwEh0TxfipuHYRkN9Wcw@mail.gmail.com>
 <CACT4Y+aXuBZbvwM1xJNPhG+dHCdjt_Are=p6wRwOk-DFHEGz2Q@mail.gmail.com>
 <CAK8P3a28w8kw9MJVx_Cada3c8tQBHT0xXheS2EmGdRgT=2jp6Q@mail.gmail.com> <CACT4Y+ZR9LMRHHYazd7okt0HpA+WjXDpXW9VM50KM7ozd1m+bQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZR9LMRHHYazd7okt0HpA+WjXDpXW9VM50KM7ozd1m+bQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Oct 2020 11:51:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Grz==fg5vqVSc3jGpzQa7AV1m_B0F7QYaVWJ0mnVu4w@mail.gmail.com>
Message-ID: <CAK8P3a1Grz==fg5vqVSc3jGpzQa7AV1m_B0F7QYaVWJ0mnVu4w@mail.gmail.com>
Subject: Re: general protection fault in qp_release_pages
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>, rgerganov@vmware.com,
        syzbot <syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AiARtFx/gkuu9+go/WjpFn8N9bIpztKFHXvAVsjWmJL3xEK/8M2
 zXhIAZuELsYkmd4oLxfrv+lLiWdL7IyjW34mAzTl6OD5wqF+iiTo89ZBlgRIA/OKPHUwXcs
 UAl8d6lMjJy1bBO07/PNTnqMLbvHmhGiyaddA+VI3lMo95y+ORTFoUL7AuKrtpR1i80+Nzr
 sSQtcBbBkBKImiNL6JUOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yeVbYDXWCfw=:6qkrMgG/YghZ8iOQUEktTN
 34dXvJ7ztBj613nBe8T5Wc5l4s2Pb8U7rBsKeSGtpx6+mg2CjAN8AK1Y6+2ZYqoKvyRHqy839
 a1RYv26RVOtscE174/oDWSyeUSbgfkI1eKen1tDFMP5p+CID4JRFd//zkM1Mt1Cfs8eeofIkr
 iJJ/b9zW12tv6z/JsU1DnZPHGn5Hh40MaOKICLwFke2lNfVvmmOgFDnoJYvqW6Ei1fMHwhu7W
 GV0YZ98zvV4Iqtpc1T305aUijMKENjUjO1m/8FjO3uD8MBxFwoaWJl94kuZwpOWkK1/uTvM/l
 81i0yhg2QM/kBenbzQeR7zJOqdj9t5cFC3ARmI2rWUtc11L4Liqvsnrs3yTAiR7qIO1ldFkPM
 AFis/74juAnV1XXtstW8nXx+yU1PR8J9mxcx4VWCzUf72iXbyVoyhLVOFnqX+QeJ2dRtEvG15
 KpOZ6gPzcQD+zkK1t9cSZejzmg+w6eFtlit7C9EoGv+cTNZ+Sp/SVVsaUlPbcyNxvzOW0oX1r
 p2YYYj0q61geGH43xkN8IMNBJxvqCFoJ57q0pGjs0+YNMCmYjIXWUzsfPh62xtRiAftMH/jeV
 A1CrTiA3PzPb6zJaWWaJ+slxpBzZC8wXkcI/XXm2btiE2jq10uun7ylMp3cwVPHMc+Tbdf0hU
 Q1FsDuhEzK65MaKY14oyyc7oDpVW/m+FftF8gXFVe+L5NfoxCLMQMKbzj4Oax2+qtFZwNj3Px
 pXFvu1PUiZU0YW4LSJEg6l7hgvUaYs4xK+A4N43mO9c9gYIwBUkr53AeIhR5PLD2KmL4pE/oC
 0m8LAqV2h7v8iavmYA/fDbVTjqOf73dOlR/CBMMuA2bjQ/CFMVp8TsDTaqsrPOJ8faIrhTqgB
 hR4672fSXaCUjeFTcgMEvm5aLgQrf5PrRzUMC+zf35V8mH3/1DDOQ9COYwpIfKHlbPt2gZ9gm
 fR4YWlue84KeWjY/tYmQz/hgwyD2A4rgrLGiHuhuxp1C75uNnuA6f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:29 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Oct 12, 2020 at 11:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > There is already a recorded fix for this on the dashboard:
> >
> > Ok, good.
> >
> > > https://syzkaller.appspot.com/bug?extid=f58fe4bb535845237057
> > > VMCI: check return value of get_user_pages_fast() for errors
> >
> > Ah, I actually looked at linux-next, which included the fix. I had
> > never before looked at the dashboard, good to know where to find
> > this information.
> >
> > If this is something that happened to others as well, could the
> > email report be changed to point out bugs that are already
> > fixed in linux-next but not in mainline?
>
> When syzbot mails a report, it does not know about any fixes by definition.
>
> There is a pending feature request to notify when a fix becomes known:
> https://github.com/google/syzkaller/issues/1574

Ok, I see.

> However:
> 1. This will double the number of emails from syzbot, not sure if it
> will be welcome.

It's only doubled if you assume that all bugs get fixed, right?
Probably good to stay hopeful on that ;-)

> 2. This probably only makes sense for fixes that are auto-discovered
> in git trees. While this one came from a user email, it was just not
> sent to the same thread/recipients (the common problem of replying to
> emails you did not receive). So it would not help in this case.
> 3. There is lots of other dynamic info on the dashboard (more crashes,
> where it happens, how frequently, when started/stopped). It's not
> feasible to send an email for every update (there can be 100K
> crashes), so the dashboard needed to be looked at in some cases
> anyway.
>
> Do you see any potential improvements in this context?

I would personally prefer the extra emails here. Usually by the
time I decided to ignore a thread, getting more replies to it
doesn't bother me. I understand others may feel differently here.

Making the dashboard link more prominent, or pointing out in
the email that it can contain newer information might help,
though I probably would have missed that as well, as I tend
to look at the oops output first. This was the first time I recall
that I looked at the reproducer source, which I found very
useful, but had probably missed in the past as well.

      Arnd
