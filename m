Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5194F28BAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgJLOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgJLOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:35:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9B4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:35:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so17890278ioo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Xdr3q6M22vTIxkXMnhGUBAytlxDft2QbFY7PJz/idR0=;
        b=AimgYMXvn2ozTvRXJ6nDw9ffZm4dt5gcjFIkbPODOKnCipVQdKZV8nSBSTFsHzkETa
         gqGR06VX1s8Ed4COneKzMywYkobWKAEUpdFHvFenJ/7+UvkDxOoYMqUUwQZEC6hsWK1b
         dsB6+NdXkv9SGMHoEcUQXd9541Lgp4OiliZ1lTbaFdBsqbZXkrhNx1Jw6JM5SUjcN43J
         ak5yrqmbyHpC9u8iTLV3ytvgY92bJsiC1ao+/v+KS1slmRbs8OmLaZQqGGoj0YeqFbC/
         pOMSst9yXTv6jdJW4tA8G9wWjaJOZT3dT7StmbVek7B3DZvJTlLkXWhXAmkeNfz842yK
         GTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Xdr3q6M22vTIxkXMnhGUBAytlxDft2QbFY7PJz/idR0=;
        b=XPQVzml6bPWmkQe4GuI28VGtg5DYAlSdcukyKK3b5NC0sFCT0H4no92l6+rx9DD7d/
         cWg2rcxlG7xV6fxKIVkCz7UxN/1VYfy6gWWZaud0wlCN5nklA0ZUZpjzETwb7FD/uy4i
         nDbG/LmiviiOpBvJyUrWWxoQM2wfCBNNREXqQEnbMHiin1zwT56Kti6D2zCgi0y9PYcF
         Ia9Vh6rzN5K/OWkO0FM221vk/s+pols7vv7QRyDxj8ZxBi/oGeni93NRzBhTYcQfs2wr
         Uy7ODvLqAibOt8k2COV5C5XwI8WsMHm+/PJBTWO37eX7Ns5u4z2ffoUkL3fKWqe8t51M
         Xy0Q==
X-Gm-Message-State: AOAM531jJOEPsd56Oefrq/RikfL3HsSfBv4hyU658Kl1naA3yt4w+T3W
        1Ccn4eUJ/82P24jmeDrHJrvMBbrklcUr1j7F6BY=
X-Google-Smtp-Source: ABdhPJys8Gf0l4+ahN62IQg1svCuncfw7yI6RXccj4H+tMiGlgG8lMmnZd1Tj0GT7czzMIPejwEtkCreIT5wRJoXnIw=
X-Received: by 2002:a6b:5907:: with SMTP id n7mr16852082iob.75.1602513326071;
 Mon, 12 Oct 2020 07:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUK3sgpHyY1h_pdzJzkX1bY46opLYytRKRzeCxBNzTX4A@mail.gmail.com>
 <20201012134255.GB2023362@gmail.com>
In-Reply-To: <20201012134255.GB2023362@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 12 Oct 2020 16:35:14 +0200
Message-ID: <CA+icZUWRXiUuvpNS8iG-w-ecs0vkRxNKHauEFuS2VtALkaNOJw@mail.gmail.com>
Subject: Re: Missing [GIT PULL] request for <tip.git#locking-urgent-2020-10-11>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 3:42 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> > Hi,
> >
> > yesterday, I saw Ingo tagged "locking-urgent-2020-10-11" in tip Git.
> >
> > Did you drop it or was this for Linux v5.9 final and the git-pull
> > request was simply forgotten?
> >
> > Just curious.
>
> So I ran the pull request script to send the tree to Linus, but on final
> review decided not to send it, as there was a pending bugreport against the
> tree, it was very late in the cycle and the commits were pretty fresh. I
> sent two other trees (x86/urgent and perf/urgent).
>
> This is why there's a signed tag for locking/urgent, but no pull request.
> :-)
>

OK, I see and thanks for the information.

- Sedat -
