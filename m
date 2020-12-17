Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5E2DCD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgLQITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgLQITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:19:40 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB491C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:18:59 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id l14so12910685qvh.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VQg7Qq6tu9zxEiOHWHdVZC+h6E0ef9ck17g1uIq278=;
        b=JiQsm1xH9UW6+PT9gLz89MNIxj6KBYXql+gCE8wkihR9NAvOX7KpOCM/9cefnTv3lR
         q8I4WTdZo+TDkCag7yIKnHY+hhasYZAL6+fohN4tCZyLhBQZg+nJfFZ8MbjO1fZSzSs9
         sKnFb57GeKrVj1XsWwkBxRApKKCiw0IAg3QWpAzIXksF/AyUvXwBiTbpyh0tWPh2bFlV
         OCuS8eyah3aaHvWroPQC07NszabIlb4iPIJMtM70rhFqUSKhqeyIS4SsLXep6pcEX/kN
         r17nqSa7So8qGDQSi/VXcKrJHGGTo+l1gDmrIKA7tbMYmR3rpdJEkAaUkkY1RJwgXmi5
         eQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VQg7Qq6tu9zxEiOHWHdVZC+h6E0ef9ck17g1uIq278=;
        b=NIb9l5dR8mkej9CY054Be8e3QSWrvI2husXa7qapA4skhA9Kw0gjBf4PFr8QyHji5i
         b8eMYlwXRYai3fLjrOr53WojEXbxvoPgCJ7sMpMl3BNktpVWRXJgfaR5coDxmQpjvAA6
         zFhBrR/5jgV29UwifcquciTWsXs2yhvSN/6pg8WPOnzpnqFpAKsWXVSeK36fnawy4o7w
         VA5mYT/GNuG9ZHnKQ4Eg/7P4bBVC3OfNL9wG5aLNg6gplnJ2c9IHQOws8FnkXGwLDITE
         LGI4XlkzFMmyvWE7Z9VC0sTg0pAtWMZtwkFvPP+DHgvebj0yAZbKi9M3cJF2ADmnYI3F
         L9RA==
X-Gm-Message-State: AOAM531zxF6b3aBEAbLkHR9QNv0sUGpPBE9c90ZAVW1etskTtBd4F+VP
        Dn6iBJSd+nHjbvx6JZD+SKo/gB3aNyqLlr7TN4qmHA==
X-Google-Smtp-Source: ABdhPJyMAxUvSxPZNp7c19iP1MJhJ0bR5Yv/kJcGX8Ex7UvCtSI4xwbzgaZS8dJXfg+pTmJTHUo3J0yAza8eKWA295o=
X-Received: by 2002:a0c:b20d:: with SMTP id x13mr47798309qvd.18.1608193138660;
 Thu, 17 Dec 2020 00:18:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f683660598300559@google.com> <0000000000002aca3d05b69503ac@google.com>
In-Reply-To: <0000000000002aca3d05b69503ac@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 09:18:45 +0100
Message-ID: <CACT4Y+Z0=kRUdwOguF5a_E+HyUUsnD3Gw=qx9Z_dao1o41W=ag@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_open (2)
To:     syzbot <syzbot+7ee926c5e237e614ccb1@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 2:40 PM syzbot
<syzbot+7ee926c5e237e614ccb1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Oct 16 12:21:14 2020 +0000
>
>     afs: Fix cell removal
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128ceadf500000
> start commit:   c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ee926c5e237e614ccb1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227c177900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13553f60500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: afs: Fix cell removal
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: afs: Fix cell removal
