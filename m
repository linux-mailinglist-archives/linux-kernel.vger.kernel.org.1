Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C12AF7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKKS1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKS1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:27:50 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94ECC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:27:49 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p12so3148826ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrsyHZk/O2OEXnomf8HUKcJ85BnbH4b8YIUsPgfTs30=;
        b=HORcm5/n0XcKL6tEHP+60AJWgd1xBEFxs9MUd5W9eya2U4cVjf4a8xGntNLBC2rlt+
         QmyFAKOWD2uO7jb2+wuOcQMtVuzmQdzcT/XTwe7pd7TnS2csi4X7NNTBNul6GSOLiWZ/
         ABUs8OCSWSE2FfVFbtGwS+x1FM4NOYyMVRhu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrsyHZk/O2OEXnomf8HUKcJ85BnbH4b8YIUsPgfTs30=;
        b=sa3FaJ2n2soFnKJK0UE3ZvXgGePoCqabFLkgBq/escOMLaxdFIlApK5mZFJcHPHyJa
         bIN89T3QIyk+hKLu+cF7nmbFnkY8u0K83KJ/584IQjAmQbyYvxcTA0o6Jxc9Z/EwijhM
         IoA7DJQqSStsRwOhuPbmt8b4M0UU0w++8v8/tx3BBSxe+7UYFTmavE7bvHyKh6OEj8/Y
         16VL9RW419FDZZToKlueH5hngxxveUkcaOsSjqO86+uQYlKGMxRiy7HkEFvUyqzYu+LO
         oLnUKp+7he4iixyJqxT6XNnJeFhbX4jviac1obuYL5fDMBkATgezShgkBC1+d0pGCgZD
         saLA==
X-Gm-Message-State: AOAM531rToolYidgbtYIbwNGYuz+tcAPk0WaP/MWxxUAs79x7pUJbkbF
        vTNT0wru8wTW+0kxOlDvYj942KtxLjpXWA==
X-Google-Smtp-Source: ABdhPJwAy5mxh2Xa3oYleNGmGkmCDD6aJJ+xmNUOGZlKhdjCDIH7Om+SGyZXdyc71AntHu5U89rN5A==
X-Received: by 2002:a2e:b536:: with SMTP id z22mr11383541ljm.177.1605119267808;
        Wed, 11 Nov 2020 10:27:47 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k3sm292076lfd.245.2020.11.11.10.27.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 10:27:46 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id s9so3139047ljo.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:27:45 -0800 (PST)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr10549600ljg.314.1605119265247;
 Wed, 11 Nov 2020 10:27:45 -0800 (PST)
MIME-Version: 1.0
References: <0-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
In-Reply-To: <0-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Nov 2020 10:27:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizYDXb0Ej0JRdVJfguhGthmZMushJDT9MUezeX2jtvww@mail.gmail.com>
Message-ID: <CAHk-=wizYDXb0Ej0JRdVJfguhGthmZMushJDT9MUezeX2jtvww@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add a seqcount between gup_fast and copy_page_range()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> As discussed and suggested by Linus use a seqcount to close the small race
> between gup_fast and copy_page_range().
>
> Ahmed confirms that raw_write_seqcount_begin() is the correct API to use
> in this case and it doesn't trigger any lockdeps.
>
> I was able to test it using two threads, one forking and the other using
> ibv_reg_mr() to trigger GUP fast. Modifying copy_page_range() to sleep
> made the window large enough to reliably hit to test the logic.

Looks all good to me.

             Linus
