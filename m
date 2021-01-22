Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B872FFC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 07:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAVGD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 01:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbhAVGDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:03:24 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 22:02:44 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y19so8966667iov.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 22:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qXQuyZ5AnJgQXgaVGzEkLYjWJnbxmXFPixed8rmyBZQ=;
        b=nAo+xdXdrcKp/sE3VNF0zxrruu7TWNF6jLRDkXbR44l2DAk0VoJJOKUhbE4uw4d7Wn
         zwoYh0tCfd3CT8lBST76GWCD1CNza+Dsa8CAxsr09GYcfGB3GD8pye/bgEsnT946qxGe
         ijlsFjyIxNnrOZKRVoQRrbUwzk9yQWbm31W3qGpMicGVJ2W281dvFWraMvUit2J+inWv
         o12Jarr9bWTRI10wS9qH1/Wat2ixCosHUYNuh8n0Jm75uRdf0ZUsYua3a+cH9XZ7ukZn
         c5puTqgDOfice+O4ovzZZigIN3JRSzoP0EB9aUnJZtngpb3nlCFYvpKORdnMlqM0MLJH
         bbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qXQuyZ5AnJgQXgaVGzEkLYjWJnbxmXFPixed8rmyBZQ=;
        b=OYF4Sbb0ghbUgw2fw1dfR6ZMR3cYyUKV7Ow5uKVI+CX+/RTRkQtIPEXu7fSS5Mq9VY
         ajYMcQZQSWuT8qMwjuVZpsujr/hAs5wgGynsjcC/DJ8ZOXirvaiDk0iAEvereAYmRF8L
         YmicQsAs4tm91qg+uYStrG4BdNfrCVe2jIQo8g5nK8jdW+t0SmsdXNLX2StFhmKmb7Og
         lcGotMtBZ5wkfLzWzkezrLT+2Z66dQfwGfHOfSxr8aYfT+9YBGiW6Qf0Or0V5kJc4I50
         Ma0f6olzdtutWmD8VnVkGJRs1ae2UWaTlh9H7nS0TN9knhqGzKtzasaC4fOkS2Pv7t/x
         ooNA==
X-Gm-Message-State: AOAM532ADWaStZO300eOtZ4BjzEqt8LMSA3FjWZqJ2hJsLxo+m+3UQ9p
        /hAQKNJAwHI/sXAbzisfg3jpNr7onTtVB/e8qVCsYWh3liY=
X-Google-Smtp-Source: ABdhPJyUhmGekKM6c0ZXIXMQMZ83NxbQVhfFGEBcB/n2h/cGq7ukPteoPdMefyHZKPE6v/nJ9I/xnhYno3cWhi74TLw=
X-Received: by 2002:a6b:8b84:: with SMTP id n126mr2367709iod.189.1611295363844;
 Thu, 21 Jan 2021 22:02:43 -0800 (PST)
MIME-Version: 1.0
References: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
 <CAKXUXMwcNqd61O2t23zyMSBrCNuHi98uym1LLZQZOZO5NOR3Jg@mail.gmail.com> <CAD-N9QWsu8d_ubihGD0B1xf5YWv=WTw6iy4uNhV-73jA9xYbjw@mail.gmail.com>
In-Reply-To: <CAD-N9QWsu8d_ubihGD0B1xf5YWv=WTw6iy4uNhV-73jA9xYbjw@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 22 Jan 2021 07:02:33 +0100
Message-ID: <CAKXUXMw2DqYFBzEpo-6F+_yOTY_+F88Tb_oK69ztkJWhQ72ZVA@mail.gmail.com>
Subject: Re: "possible deadlock in console_lock_spinning_enable" and "possible
 deadlock in console_unlock" should be duplicate crash behaviors
To:     =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:47 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudongliangabc=
d@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 8:49 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> w=
rote:
> >
> > On Thu, Jan 21, 2021 at 6:37 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudonglian=
gabcd@gmail.com> wrote:
> > >
> > > Dear kernel developers,
> > >
> > > I found that on the syzbot dashboard, =E2=80=9Cpossible deadlock in
> > > console_lock_spinning_enable=E2=80=9D[1] and "possible deadlock in
> > > console_unlock"[2] should share the same root cause.
> > >
> > > The reasons for the above statement:
> > > 1) the stack trace is the same, and this title difference is due to
> > > the inline property of "console_lock_spinning_enable";
> > > 2) their PoCs are the same as each other;
> > >
> > > If you can have any issues with this statement or our information is
> > > useful to you, please let us know. Thanks very much.
> > >
> > > [1] =E2=80=9Cpossible deadlock in console_lock_spinning_enable=E2=80=
=9D -
> > > https://syzkaller.appspot.com/bug?id=3D2820deb61d92a8d7ab17a56ced58e9=
63e65d76d0
> > > [2] =E2=80=9Cpossible deadlock in console_unlock=E2=80=9D -
> > > https://syzkaller.appspot.com/bug?id=3D39ea6caa479af471183997376dc7e9=
0bc7d64a6a
> > >
> > >
> >
> > Dongliang, what is the purpose of this activity?
>
> Lukas,
>
> We are conducting some research on the crash deduplication (or
> identifying unique bugs) of kernel crash reports. We would like to
> share some results from our research to facilitate the bugfix in the
> syzbot dashboard.
>
> >
> > Why do inform the kernel maintainers that two issues share the root cau=
se?
> >
> > How does this activity contribute to fixing the bugs? Why does it
> > become easier to fix the issue/create a patch with the information you
> > provide?
>
> I do this for three reasons:
>
> (1) I think the reports sharing the same root cause may expedite the
> patching processing and help generate more complete patches. After
> patching bugs in one case, we can close the other cases quicker.
> Without these reports, one developer might be misled to develop an
> incomplete patch due to a lack of understanding of the underlying bug
> [1].
> (2) I think it might help maintainers to better assess the severity of
> the bug and thus could prioritize their effort.
> (3) Multiple reports might better help maintainers diagnose the bug's
> root cause.
>
> [1]  https://groups.google.com/g/syzkaller-bugs/c/9u_hEFvNbLw/m/CO9bfF8zC=
QAJ
>
> > (Honestly, I do not see how it does. I believe if anyone becomes
> > active and fixes the issue due to either one of the two reports, the
> > one report would be closed by the reported-by tag and the other report
> > would simply disappear after time because it could never be reproduced
> > and hence, syzbot would close it.)
> >
> > Would it not be more reasonable to fix issues rather than identifying
> > duplicates in the automatically filled and managed database?
>
> Yes, fixing issues or bugs is the ultimate goal. However, crash
> deduplication does benefit the bugfix process, and can reduce the
> heavy burden on the kernel developers. To make our analysis more
> useful, we will try our best to add some root cause analysis and how
> to fix the underlying bug.
>

Well, I am not really convinced, but I guess you will convince me when
(thanks to your feature) all bugs reported by syzbot are quickly fixed
and quickly closed.

good luck :)

Lukas
