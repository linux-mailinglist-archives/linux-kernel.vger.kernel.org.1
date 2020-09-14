Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6D26971B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgINUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgINUws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:52:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:52:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so768136lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1FP4AWnie2gjJ2+aQoHhQuSZMsBtLy6T/hgMEanh9c=;
        b=ZjGO/JUJ1x3wgc51FKgZnYti+5XGDOnE976o9x4witZRtmCeaTcv5mfWN3lnNeRG05
         Jnzc/hwQnJDND5G1g4jX3abSBcfjYfXDM4QHOxv6aYN2SxX48UnMQW2WLoUgrX2qCD0R
         1Loc/e6NuAoyrlubjERjsWCqn5a6aZD7mMdhOwk1tgl0XukhLF37EbGYxMuEIWAIyYrZ
         WQeJZGRMx5QwqijZO2nynQjBz5l6mMqAnaJDzE4NaRYqCndBa9vcy+ZfTyJI4GWBXO0b
         pYC3AHRpFqmI3//nOBpoyXWhUiDmf+WQGw2fVz9+m68Fs3Meg815lB6RatDm462cKD79
         5Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1FP4AWnie2gjJ2+aQoHhQuSZMsBtLy6T/hgMEanh9c=;
        b=HdK/OqN/Goug65ZDd/jWMUhijmf64AQBtoN8Ecijhj8RksclZNMU1C/w2dZkJOuex/
         0tIFxgfZULa07ACUCvphzQJwpe6r1WoEYo3UB+AnFOeVx84g8tE/C84wp6u/28Dtxh0A
         /Tt1jPjUgVMdFsidryUnG5M/GO6xKnkndY7+LruVdzaO5R4l/PCAvuyHgrpRu0QstuJM
         UXoN+l1Gw4vJaaCkDBaQMF811ZWTccfyEIF1KHMPS4M0yufAwkiCty+VGHFVkdwIg3/K
         5mSUULF/sNSLjjpIc75QvFTFggOEwIaA3uSWH+11QHf48zMNvx/po4LsswbrLRHtkU/U
         wW+Q==
X-Gm-Message-State: AOAM531Ne2QkhKMZHGRL01YrIurx8nEiafJj1WDLDofA/0zlMwdSZQIU
        EH0kEREIHshWXmYtylKYzci4MCC9LsLoqx3AHt+olm40ULGMZg==
X-Google-Smtp-Source: ABdhPJzpoL5GFI54NoyZ0KduFMFXvrdhGSfG5CRRJrvremcnlvt9gygB2S/03+RRhwenrupXwRp6m0AcAKcVUKrnXCA=
X-Received: by 2002:a19:c801:: with SMTP id y1mr4642218lff.217.1600116765367;
 Mon, 14 Sep 2020 13:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
 <20200913145520.GH6583@casper.infradead.org> <CAFqt6zYru2VfaBFHEB6+7vMPXUbgX8R5f+GHqxaGjhP8QZEyzw@mail.gmail.com>
 <20200914140814.GE1221970@ziepe.ca>
In-Reply-To: <20200914140814.GE1221970@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 15 Sep 2020 02:22:33 +0530
Message-ID: <CAFqt6zasxyAc9heAFuQ0xXuwpk8s7RThordModvLVDNDfFYvkA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 7:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Sep 14, 2020 at 07:20:34AM +0530, Souptick Joarder wrote:
> > On Sun, Sep 13, 2020 at 8:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Sep 13, 2020 at 08:02:35PM +0530, Souptick Joarder wrote:
> > > > It is possible that a buggy caller of unpin_user_pages()
> > > > (specially in error handling path) may end up calling it with
> > > > npages < 0 which is unnecessary.
> > > > @@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
> > > >  {
> > > >       unsigned long index;
> > > >
> > > > +     if (WARN_ON_ONCE(npages < 0))
> > > > +             return;
> > >
> > > But npages is unsigned long.  So it can't be less than zero.
> >
> > Sorry, I missed it.
> >
> > Then, it means if npages is assigned with -ERRNO by caller, unpin_user_pages()
> > may end up calling a big loop, which is unnecessary.
>
> How will a caller allocate memory of the right size and still manage
> to call with the wrong npages? Do you have an example of a broken caller?

These are two broken callers which might end up calling unpin_user_pages()
with -ERRNO.
drivers/rapidio/devices/rio_mport_cdev.c#L952
drivers/misc/mic/scif/scif_rma.c#L1399

They both are in error handling paths, so might not have any serious impact.
But theoretically possible.
