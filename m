Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2403D1B5369
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 06:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgDWEYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 00:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWEYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:24:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F641C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:24:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j20so3330307edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1DMwknr8Mv5esWhXjaUd0WNvn+/fUVQmBus68SdeKI=;
        b=Ttz2w7rbGa7bL4xh9pO5D01ts9bopo8zmXqwhb6SJpuJqdNz8GT63pO+DS3o5rFExI
         91FDNSYgk46tTG7Z7myPIWIqQOs9vaczQphPBJwn1EJSP3KphnVypF5PWJUyTfiS1+ju
         I3mogJgoyAiEEbYmdzuht+uXeeqbjhAf9VKrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1DMwknr8Mv5esWhXjaUd0WNvn+/fUVQmBus68SdeKI=;
        b=gWgTSBhrryypkf0XfjNQjd58nbdSzoOPlDW7rwyN9wdY2eqg2XYZV8rjiHsHcwQLfJ
         UL156K3yg+69wIdYzk7NMlhzOfnbVZKvD3+bj8GLDW3swob9Wciz/rM2WX9P2sykohTu
         smVkoFekoBqoUMjvkKSk9XfdI++OaqVTvr9QzqZb4kPepdGFPcNct7/6xmT5b2NNasj1
         LDUepv2x7wAR/lU+zAHThuHo83r86c75CZECwsXaKIBUY6R3PTq88I91lz83u2gimu80
         Js7WrBD3O9/wVKCEpSwxKrgVu2ANAr6hxntcuIOdHH/SPQpOJU52EzhFZ6tyu6d88tcW
         6MQQ==
X-Gm-Message-State: AGi0PubUgmTEbkE/ecgfcoS/mV+MJjUKzTsBbuBBAqgFXD1Lt92aFEb8
        9xAeaNwg9V1Vviq2BNp9a4Iw48nHbkRkbK5PUWpveA==
X-Google-Smtp-Source: APiQypIEFE4myQJwMnY76Nzh2FYKbEqny6z5ZXE6PB4mX15k5Pi4QVY5srwSRvGlAuVTRyIy9W6Eg4K1/Y9vK968Cqw=
X-Received: by 2002:a05:6402:22ed:: with SMTP id dn13mr1254167edb.212.1587615865963;
 Wed, 22 Apr 2020 21:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587531463.git.josh@joshtriplett.org> <9873b8bd7d14ff8cd2a5782b434b39f076679eeb.1587531463.git.josh@joshtriplett.org>
 <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
 <CAJfpegt=xe-8AayW2i3AYrk3q-=Pp_A+Hctsk+=sXoMed5hFQA@mail.gmail.com> <20200423004807.GC161058@localhost>
In-Reply-To: <20200423004807.GC161058@localhost>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Apr 2020 06:24:14 +0200
Message-ID: <CAJfpegtSYKsApx2Dc6VGmc5Fm4SsxtAWAP-Zs052umwK1CjJmQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>, io-uring@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 2:48 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Wed, Apr 22, 2020 at 09:55:56AM +0200, Miklos Szeredi wrote:
> > On Wed, Apr 22, 2020 at 8:06 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > >
> > > [CC += linux-api]
> > >
> > > On Wed, 22 Apr 2020 at 07:20, Josh Triplett <josh@joshtriplett.org> wrote:
> > > >
> > > > Inspired by the X protocol's handling of XIDs, allow userspace to select
> > > > the file descriptor opened by openat2, so that it can use the resulting
> > > > file descriptor in subsequent system calls without waiting for the
> > > > response to openat2.
> > > >
> > > > In io_uring, this allows sequences like openat2/read/close without
> > > > waiting for the openat2 to complete. Multiple such sequences can
> > > > overlap, as long as each uses a distinct file descriptor.
> >
> > If this is primarily an io_uring feature, then why burden the normal
> > openat2 API with this?
>
> This feature was inspired by io_uring; it isn't exclusively of value
> with io_uring. (And io_uring doesn't normally change the semantics of
> syscalls.)

What's the use case of O_SPECIFIC_FD beyond io_uring?

>
> > This would also allow Implementing a private fd table for io_uring.
> > I.e. add a flag interpreted by file ops (IORING_PRIVATE_FD), including
> > openat2 and freely use the private fd space without having to worry
> > about interactions with other parts of the system.
>
> I definitely don't want to add a special kind of file descriptor that
> doesn't work in normal syscalls taking file descriptors. A file
> descriptor allocated via O_SPECIFIC_FD is an entirely normal file
> descriptor, and works anywhere a file descriptor normally works.

What's the use case of allocating a file descriptor within io_uring
and using it outside of io_uring?

Thanks,
Miklos
