Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0799F2EF767
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbhAHScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbhAHScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:32:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DE8523A84
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610130698;
        bh=t+ayXSPKPyt+buzVfjSA06cJ/7ar6PMvS75DQsGw0Kg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s0FkXM7O59c8DI4sRLKC0K73c/LR241Uv+fX/1eIDJw7A2dqncdnYqtBbCIC1pKw3
         Sw+E4pHHuZ3zCstBYJzUv0uLLREzImZgdu46vUdvThKuVvNlVFYT/EowIbUy+smd1s
         4aUaVJtwxphcsyrEWK2y79I2Q2kf7xzEFSt5DkhZP7NNt7SGCRiVbDhoeGUf5EI9o3
         bnh7OqVxhqzDmtf3MuVMPLueZeSDKBHENAer8bFyQQ+XYCuwXT6S2gDtfnYDIsAjxB
         xpqrLmleOAFqNBFJd8TTJZpRCrr3t0gvFKrPRG918gCPH1spHfPJcKcuca8Ez2c/X6
         G2ZX5BlWmTfIw==
Received: by mail-ed1-f42.google.com with SMTP id c7so12142820edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:31:38 -0800 (PST)
X-Gm-Message-State: AOAM533n0SdSn78lgLjy/UEMm6POmGvvgXRxk8yd7EyN+CEBy7kgSXYQ
        3SrbOla2c+ZdWLPdgweAeciHnIKy6lFQcuOxDDwKKA==
X-Google-Smtp-Source: ABdhPJz9p5UU5fsa22GkI9tG2fSeZaCa/MH69wJBv3nUMa0ykh2+krPOCp9di9vj/dazafpbjhF5Ev3kroo7noGINQ8=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr6093359edr.97.1610130696959;
 Fri, 08 Jan 2021 10:31:36 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com> <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com> <20210108181945.GF504133@ziepe.ca>
In-Reply-To: <20210108181945.GF504133@ziepe.ca>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 Jan 2021 10:31:24 -0800
X-Gmail-Original-Message-ID: <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
Message-ID: <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:19 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Jan 08, 2021 at 12:00:36PM -0500, Andrea Arcangeli wrote:
> > > The majority cannot be converted to notifiers because they are DMA
> > > based. Every one of those is an ABI for something, and does not expect
> > > extra privilege to function. It would be a major breaking change to
> > > have pin_user_pages require some cap.
> >
> > ... what makes them safe is to be transient GUP pin and not long
> > term.
> >
> > Please note the "long term" in the underlined line.
>
> Many of them are long term, though only 50 or so have been marked
> specifically with FOLL_LONGTERM. I don't see how we can make such a
> major ABI break.
>
> Looking at it, vmsplice() is simply wrong. A long term page pin must
> use pin_user_pages(), and either FOLL_LONGTERM|FOLL_WRITE (write mode)
> FOLL_LONGTERM|FOLL_FORCE|FOLL_WRITE (read mode)

Can we just remove vmsplice() support?  We could make it do a normal
copy, thereby getting rid of a fair amount of nastiness and potential
attacks.  Even ignoring issues relating to the length of time that the
vmsplice reference is alive, we also have whatever problems could be
caused by a malicious or misguided user vmsplice()ing some memory and
then modifying it.

--Andy
