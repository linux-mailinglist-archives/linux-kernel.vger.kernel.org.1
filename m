Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756EE2E03B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgLVBNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:13:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA6C0613D3;
        Mon, 21 Dec 2020 17:12:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y24so10709516edt.10;
        Mon, 21 Dec 2020 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GliYyH7yy7ye5oeDSopSLd690B1DZ40po/a9jbBg3Ek=;
        b=PGO9qu6T57IQ4Nfj6h3qO4kRsdkl8rrwYhKiqqGXq+aSjNdZyKFlWX0AQkGkbQdZ1d
         w9Bx+f8qwBf+UUaWxgOn4gvr5r4Fhibf69V1VmELYjxj9zGZeyR+CJjN93/Ae1FtFnk5
         Fe1wngC2dw/SAHOfCbLpEkdp0sOCSGgMhiwnEpsGe9HHMjcyoGAXAEtLhHwpd1FdSr7y
         x1GE3BCJvDF+YA4jLDPbz1tBd182z4ekXTbIg4qnfUvpbTP8Oy2TM4Q9Mw4SDhjmOKlL
         MHwGk7FBQEvJ0DWUMsBZpRzn4qA8G6VIrtuDgYW/pFf3mBRX1mOhf/BcjTyY2AFihH7G
         d8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GliYyH7yy7ye5oeDSopSLd690B1DZ40po/a9jbBg3Ek=;
        b=tcdt9CC8r0BwJVu7DDGvfHFffQS21lTzJzoZveZq3CNZsaTSGxje7i/0RjPiZzv6bW
         lWJwsbzZLf/hjHKXh0tAFCaDtsDmNEEr7VUb2gIHcZjFA2barqeLUgvw7W6F3qiJZmGb
         1h9ZPQ8doX0Na/KjdHQ1Sx0k3C//kInuK5E6t/Z7v/mUi67tqk8GWy6RLuW13vmWsxvz
         S1Ye9vNUoWm3SDJ9bWf7CSMWNKVvNFRnnXUY8+/beUI9qzEcmtYk8h94gk2cq9ChZXBY
         KNGJfvc5xHYD+6Cb7F3pIvexfWn8ihS57ZJan51RhTzO4nE9a0T/wtCP+O/LFZM/c9Nz
         6tqg==
X-Gm-Message-State: AOAM530nhxDFmThxoGNhA23SIOJWdYCPeH/pPkRKJ69Y7JU4cYugQxuC
        MDntZ4QNFjY8QrUqLTaXPLA1GzLvVS6gF9M+bYg=
X-Google-Smtp-Source: ABdhPJzVOecyNYG+T5AvEZ2NZACOGkQW0lcuS/RsS/USm1j9Qv3jcTv1wvsyViPvDQmdYhhLG55i3DXRU74tCjAcu+k=
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr18341443edt.213.1608599562140;
 Mon, 21 Dec 2020 17:12:42 -0800 (PST)
MIME-Version: 1.0
References: <1607144496-10635-1-git-send-email-cainiao666999@gmail.com> <20201221095721.6bebfb28@lwn.net>
In-Reply-To: <20201221095721.6bebfb28@lwn.net>
From:   Mingzhe Yang <cainiao666999@gmail.com>
Date:   Tue, 22 Dec 2020 09:12:10 +0800
Message-ID: <CAAY4BKP9HJse43ixR3txu1o=-j4ubgXoXEALaNOZcFQUxVhMgw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: x86: update the thread_info's position
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a million!
I truly appreciate your review!

On Tue, Dec 22, 2020 at 12:57 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Sat,  5 Dec 2020 13:01:36 +0800
> Mingzhe Yang <cainiao666999@gmail.com> wrote:
>
> > Prior to kernel 4.9 the thread_info structure was at the bottom of
> > the kernel stack. kernel 4.9 moved it into the task_struct.
> >
> > See commits c65eacb ("sched/core: Allow putting thread_info into
> > task_struct"), 15f4eae ("x86: Move thread_info into task_struct")
> > and 883d50f ("scripts/gdb: fix get_thread_info").
> >
> > Signed-off-by: Mingzhe Yang <cainiao666999@gmail.com>
> > ---
> >  Documentation/x86/kernel-stacks.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kernel-stacks.rst
> > index 6b0bcf0..e9097f3 100644
> > --- a/Documentation/x86/kernel-stacks.rst
> > +++ b/Documentation/x86/kernel-stacks.rst
> > @@ -15,7 +15,8 @@ Like all other architectures, x86_64 has a kernel stack for every
> >  active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
> >  These stacks contain useful data as long as a thread is alive or a
> >  zombie. While the thread is in user space the kernel stack is empty
> > -except for the thread_info structure at the bottom.
> > +except for the thread_info structure at the bottom (since kernel 4.9,
> > +the thread_info structure has been moved into task_struct).
>
> So this has been sitting in my inbox for a bit, sorry.  This seems worth
> fixing, but is this the correct fix?  The documentation should reflect the
> current kernel, rather than what once was with a "(it's not actually that
> way anymore)" note.  Is the kernel stack truly empty now?  If so we should
> just say that; otherwise say what's lurking there in current kernels.
>
> Thanks,
>
> jon
