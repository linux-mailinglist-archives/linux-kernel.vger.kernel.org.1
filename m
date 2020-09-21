Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF822735F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgIUWrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:47:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F37C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:47:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so20025587ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OknaEg9Bci/GmvEYGWaLedEyeJNH74L0px+V8LWtVk=;
        b=PrZDdKWvtRLSNhOb9RP6eNnIUgVJTSlB94UKHVbq+7u7SVH56YNAm517LUPziXzzOU
         qmCOuHL86VcccMi5cn3ShjIP9I7/BD3p08FgNCMTiaRUXlaWNI+PMVNljswRuLd5exjM
         lT/TKF33a9aAXRz7Z1Z8eUTOGwA9V63qNbTMlG4rni0zVP5Z9hAmwG0soFjqcnDuG1/+
         XoG3KBHJExMbjHuLgvKWITyWEQjtyWV1kA0ENhxMfbqBJ22cjwddahVV2JVmE+67vxD0
         k6+hYJVS3NQJIGEo+ymwlds70aJSgS7+QDhiZAF9XE72RH5AD65WLsDzHdlLWlQvoSyZ
         8h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OknaEg9Bci/GmvEYGWaLedEyeJNH74L0px+V8LWtVk=;
        b=j8/mBkRqyFac9rviLU5LLQwegOVFIAsl2ltcXIFP6Ffi22rXj010BT/5W7OYYD+/gx
         r6qTtiihe8nA6cbjJ10peNh8ZinWAF/uMYmc+Jml24Uo5tfPP2a6o+i7VlgPhf2+iKkZ
         69wRciB8uV1/KpMwSG8SeLJtpTpQShC3doiTgTWKkcBsiAivdGLJgEwjwO4LbqQFOKOt
         R1t0mkzqSB+8XWVcMyStyG5wYEhUFFGOPSfeaYjNsKqbLRV5VFtZ8KbnNCOJgyh3zb1l
         TCmeTKAjuE4uY0Saga5jO9PLWhdtoe42ZBzw+GCSBaEwdtKQ+6WJ8x9uRHcBGnH0Vwu3
         u+sA==
X-Gm-Message-State: AOAM532Zum8nxNochSeSH8p7dovnL40wyI27b0Ylg9ZuOZUcH9U8RwR5
        gOom9aVNzUEXVVCjwXap3TzUHyoUChgOIUJVh/RJEA==
X-Google-Smtp-Source: ABdhPJyzg3ydPvpidp6poimqhOhkx8yIBZhbrSy/eA0S4lOHee894Of+yQzFBqQjET+qq4gv2Ma7TZjal2kcJOD4Q48=
X-Received: by 2002:a17:907:64d:: with SMTP id wq13mr1736153ejb.513.1600728458076;
 Mon, 21 Sep 2020 15:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921211744.24758-2-peterx@redhat.com>
 <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com> <20200921223004.GB19098@xz-x1>
In-Reply-To: <20200921223004.GB19098@xz-x1>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Sep 2020 00:47:11 +0200
Message-ID: <CAG48ez25krKvd5hWqn0R3w5_AAPVWtWKofiOHEfKaB2+YoDoPw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:30 AM Peter Xu <peterx@redhat.com> wrote:
> On Mon, Sep 21, 2020 at 11:43:38PM +0200, Jann Horn wrote:
> > On Mon, Sep 21, 2020 at 11:17 PM Peter Xu <peterx@redhat.com> wrote:
> > > (Commit message collected from Jason Gunthorpe)
> > >
> > > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> > > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > > that have never been passed to pin_user_pages() cannot have a positive
> > > page_maybe_dma_pinned() by definition.
> >
> > There are some caveats here, right? E.g. this isn't necessarily true
> > for pagecache pages, I think?
>
> Sorry I didn't follow here.  Could you help explain with some details?

The commit message says "mm_structs that have never been passed to
pin_user_pages() cannot have a positive page_maybe_dma_pinned() by
definition"; but that is not true for pages which may also be mapped
in a second mm and may have been passed to pin_user_pages() through
that second mm (meaning they must be writable over there and not
shared with us via CoW).

For example:

Process A:

fd_a = open("/foo/bar", O_RDWR);
mapping_a = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, fd_a, 0);
pin_user_pages(mapping_a, 1, ...);

Process B:

fd_b = open("/foo/bar", O_RDONLY);
mapping_b = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd_b, 0);
*(volatile char *)mapping_b;

At this point, process B has never called pin_user_pages(), but
page_maybe_dma_pinned() on the page at mapping_b would return true.


I don't think this is a problem for the use of page_maybe_dma_pinned()
in fork(), but I do think that the commit message is not entirely
correct.
