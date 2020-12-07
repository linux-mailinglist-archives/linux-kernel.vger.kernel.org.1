Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E312D1160
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgLGNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLGNHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:07:15 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4BCC0613D0;
        Mon,  7 Dec 2020 05:06:29 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id t9so7753316ilf.2;
        Mon, 07 Dec 2020 05:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCtv0YByR+6RlAU/Nc+PNAffJQIiNShejB5wWTuZSQQ=;
        b=LqLYEcLWn0hEGhKOOXyejkwOujrKekWleTh+XscKmgOqbV4xGqpJMVaGZu5Gna1I49
         qTCNRxutMsvP9mbGT08seZ+JWrdJdY2t/9CxsZxaTvaLEYzYeM4QUToqP7+/GJgZ9ONF
         ll/Z7kF7RKuvxC3Cq5Of/q47w4RehQHXlexRgZlsPiO4EQ3hyWWEtMzsbZ93zz6pTnGF
         y847zbpst/VNzEkxINH+Lx1QKVSfJ9BDrwC4zs3Vk45/3126xC1dwWLwW3Fo/QYVYoUS
         QeMI2KDBDlSryYzWsqsTaI+doB0nqwM0kKLifma0NXOTjeOobSYiWNFTIKCZgxwGOHYp
         QJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCtv0YByR+6RlAU/Nc+PNAffJQIiNShejB5wWTuZSQQ=;
        b=cjHpLmslXAvQCtMZk55XEChZ53BD24xEoDBJZG2N9NAZXxU1dtA4GUE+UTmX8M+Ibk
         7VA+SbiApBk7j3d0VO3z2Pr+hHjl9GUK/Tg2S5OuMUmxsDDKMhz5uh63ZpYS7Ha2vEf3
         fWk7bcc6+NAa0Mh/UqZV+jwHcaFfW5FiKgqJuWQj8LHtCbxCJWuRtAnEV9XMFYwtWg9E
         Hpbs7qLR7feppPgQLzCOLILEMFnjpRuX7uz35jGhKwTFVVFFso0Ursbz8k98ipsUGkLb
         7J53ZdnGpqA8MVw+ez2CK6smsmxRRdyazj8BbgD/uSDJA+tpN/K538Nq4RN2saY26PbX
         SZfQ==
X-Gm-Message-State: AOAM533bj8TajE+FRdfFO/Mb7lAjdPryyVzpID+wOjEJALTHP/0IWC4G
        vKDjQZzf7SnprxP6+Y59+qMmKorG7v8as082l884MAmpdJ/uQw==
X-Google-Smtp-Source: ABdhPJyOD5ZrPvmAysN1gfPHDyKxXeKJz44fxIBMA4BuEXib+EyEnwCxxbUvqQKIO191ZVxOsEFtmx4ORlNHwXTJHdE=
X-Received: by 2002:a92:a804:: with SMTP id o4mr21737089ilh.125.1607346388641;
 Mon, 07 Dec 2020 05:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20201207123610.18246-1-lukas.bulwahn@gmail.com> <20201207130449.nbt23aholqebbvux@wittgenstein>
In-Reply-To: <20201207130449.nbt23aholqebbvux@wittgenstein>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 7 Dec 2020 14:06:17 +0100
Message-ID: <CAKXUXMyC163hWT-bf=Nbw3KQspYWo_oTCNBYH-Di5ky+NU190A@mail.gmail.com>
Subject: Re: [PATCH] signal: propagate __user annotations properly
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 2:04 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Dec 07, 2020 at 01:36:10PM +0100, Lukas Bulwahn wrote:
> > Commit 3eb39f47934f ("signal: add pidfd_send_signal() syscall") introduced
> > copy_siginfo_from_user_any(), but missed to add the __user annotation to
> > the user pointer that is passed as second argument.
> >
> > Hence, when copy_siginfo_from_user_any() calls copy_siginfo_from_user(),
> > sparse warns:
> >
> >   kernel/signal.c:3716:46: warning: incorrect type in argument 2 (different address spaces)
> >   kernel/signal.c:3716:46:    expected struct siginfo const [noderef] [usertype] __user *from
> >   kernel/signal.c:3716:46:    got struct siginfo [usertype] *info
> >
> > And when pidfd_send_signal() calls copy_siginfo_from_user_any(), sparse
> > warns as well:
> >
> >   kernel/signal.c:3776:58: warning: incorrect type in argument 2 (different address spaces)
> >   kernel/signal.c:3776:58:    expected struct siginfo [usertype] *info
> >   kernel/signal.c:3776:58:    got struct siginfo [noderef] [usertype] __user *info
> >
> > Add the __user annotation to repair this chain of propagating __user
> > annotations.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on current master (v5.10-rc7) and next-20201204
> >
> > Christian, please pick this minor non-urgent clean-up patch.
>
> Thanks for the patch. Unfortunately I already picked up Jann's patch who
> sent it yesterday or this morning:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=pidfd
>

Thanks for letting me know and good to know that Jann is tracking
those sparse warnings as well :)

Lukas
