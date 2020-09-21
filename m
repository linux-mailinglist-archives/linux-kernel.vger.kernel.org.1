Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DEE2735C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgIUW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUW2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:28:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:28:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so19985279ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kM6XzhJJTngcIIzefpQFOgDA2+BF/Ae7nqpjlvmm9QY=;
        b=kRn/Tsc43tCRa7uA/MUO1KALZMdYG7hOnA+kndhviJ5CRXnhvTY7ZHpKRpGZrNNBC1
         gCrAvfcS1zCCclZyNeidP67cLdDgqT7TU1yLEoOhQcFfsN+fyptJ88HT0bbTAmd7wUMH
         HyM4c7va/CdxQtHBLeW0+KWWdetakCqR94qTg4+ArKEfAoE/L+BhR0ckCrRvM9JPSH/x
         W48syV78YHrEIm6efqGPnYlQ49uCD+HhDnZ7dkTZt/j7gSIbXTAYgtRT478Sg5v7Oof3
         Vfkfy38fjj9Ky4AR590IKenOZm49jukkIYUBVH82TWQxmfxNbydy1gVNh+s6pS+9eCp4
         rKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kM6XzhJJTngcIIzefpQFOgDA2+BF/Ae7nqpjlvmm9QY=;
        b=IMVprqGHtsbItMf5H9poAXuYzDSXZJ5BEvm/TRCoWReXXFiuWVm8bRdioFgFjohNbA
         Oh5oGaHFyx/sqaZg4ofbtAOTi+C383OOTyd04CJ+8id0VHqjPD4He027yccBkOXjYrZJ
         zzESIwYnDHZHxCRhoVRPDn2tY1y5XDwbbwHAOzW743waViEk+zBNGDBXGDWOI2wBtBAU
         FlnweIejLyWebH9PXnEXJ649uFOVCoGv9EZ79nEk619L15r08xHxZmqifidqGPI5syi3
         ebhuyvhguO+2LzLbEL/KlxifQomFozZKaXX+WqAHxmDdLW//iwNSBE07nlfEgK4Uo+4a
         Qcag==
X-Gm-Message-State: AOAM533TB88tIxjHBCzppVm2mKOXLwiw8y7ZTZMZIdv+3i/5ZTgkB6MY
        ofBFYCZKUN4aGpLMGjSrvir5976VCrREA3fQVO5cSg==
X-Google-Smtp-Source: ABdhPJxLDKLQe/ZVz6jB0RLtkFvXY+Fh007M1Kp5WpliEi2wLaAHVpyExx3WKXhfuMXUu9OwcEk+2uyQo9xwg/hxf+c=
X-Received: by 2002:a17:907:64d:: with SMTP id wq13mr1669531ejb.513.1600727281873;
 Mon, 21 Sep 2020 15:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921212028.25184-1-peterx@redhat.com>
 <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com> <07bc5f59-74ae-73e8-2616-f11712c27b58@nvidia.com>
In-Reply-To: <07bc5f59-74ae-73e8-2616-f11712c27b58@nvidia.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Sep 2020 00:27:35 +0200
Message-ID: <CAG48ez1Y0==PxR_h6PoRAcxTABM5o0FRR4ow+z7V3W52xNYm_w@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for ptes
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:18 AM John Hubbard <jhubbard@nvidia.com> wrote:
> On 9/21/20 2:55 PM, Jann Horn wrote:
> > On Mon, Sep 21, 2020 at 11:20 PM Peter Xu <peterx@redhat.com> wrote:
> ...
> > I dislike the whole pin_user_pages() concept because (as far as I
> > understand) it fundamentally tries to fix a problem in the subset of
> > cases that are more likely to occur in practice (long-term pins
> > overlapping with things like writeback), and ignores the rarer cases
> > ("short-term" GUP).
> >
>
> Well, no, that's not really fair. pin_user_pages() provides a key
> prerequisite to fixing *all* of the bugs in that area, not just a
> subset. The 5 cases in Documentation/core-api/pin_user_pages.rst cover
> this pretty well. Or if they don't, let me know and I'll have another
> pass at it.
>
> The case for a "pin count" that is (logically) separate from a
> page->_refcount is real, and it fixes real problems. An elevated
> refcount can be caused by a lot of things, but it can normally be waited
> for and/or retried. The FOLL_PIN pages cannot.
>
> Of course, a valid remaining criticism of the situation is, "why not
> just *always* mark any of these pages as "dma-pinned"? In other words,
> why even have a separate gup/pup API? And in fact, perhaps eventually
> we'll just get rid of the get_user_pages*() side of it. But the pin
> count will need to remain, in order to discern between DMA pins and
> temporary refcount boosts.

Ah... the documentation you linked implies that FOLL_WRITE should more
or less imply FOLL_PIN? I didn't realize that.

Whoops, and actually, process_vm_writev() does use FOLL_PIN
already, and I just grepped the code the wrong way.

Thanks for the enlightenment; I take back everything I said.
