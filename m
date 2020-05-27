Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E871E33F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgE0AKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 20:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgE0AKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:10:13 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24AE2089D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590538212;
        bh=RO68wFxyD2nP49xjr7cFk11LYkDRsmJq6C3SXL2ZDn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=itKUbRn1dkYO8y2bjtMOS288408TgGoZcDcZEN0QA7Bs1kpQqcvVCdANMfhI1F1xZ
         4/bBWJDembfN7fIHpiTXhsM6kWjqppKyO9CQB5cjdP9fZY2uwGXeVOuOfBmUhwyoNM
         Zd8w72ahAgzKH3podVIZ+41a0aVg4BpWQVDaDobk=
Received: by mail-wm1-f53.google.com with SMTP id f5so1344233wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 17:10:12 -0700 (PDT)
X-Gm-Message-State: AOAM532tNDIkMdfge48GpLyKaPM5ddTg/6anyqjFC8NfhvW2y44UwB9d
        +VGsun1cQaoS3LhqGWxPIjZazyfPAlQU37EhnVAVtQ==
X-Google-Smtp-Source: ABdhPJy99Qytlx++XfGLvXnrC9MrkqPXRc5laCgse2ftaE5/O67pN5xEHNE8CK2wZboURgZsST0ykcZfJYdcbAHEaGU=
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr1508962wme.21.1590538211124;
 Tue, 26 May 2020 17:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <1589523957.s4pf3vd48l.astroid@bobo.none> <3b217554a8a337de544482d20ddf8f2152559cd3.camel@surriel.com>
 <1589595735.4zyv4epfsj.astroid@bobo.none>
In-Reply-To: <1589595735.4zyv4epfsj.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 May 2020 17:09:58 -0700
X-Gmail-Original-Message-ID: <CALCETrVfb6-c6c4qoLCcs3zJhvrBPGWH+WgD9k_gvLeXYnLL+Q@mail.gmail.com>
Message-ID: <CALCETrVfb6-c6c4qoLCcs3zJhvrBPGWH+WgD9k_gvLeXYnLL+Q@mail.gmail.com>
Subject: Re: Possibility of conflicting memory types in lazier TLB mode?
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc Andrew Cooper and Dave Hansen]

On Fri, May 15, 2020 at 7:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Rik van Riel's message of May 16, 2020 5:24 am:
> > On Fri, 2020-05-15 at 16:50 +1000, Nicholas Piggin wrote:
> >>
> >> But what about if there are (real, not speculative) stores in the
> >> store
> >> queue still on the lazy thread from when it was switched, that have
> >> not
> >> yet become coherent? The page is freed by another CPU and reallocated
> >> for something that maps it as nocache. Do you have a coherency
> >> problem
> >> there?
> >>
> >> Ensuring the store queue is drained when switching to lazy seems like
> >> it
> >> would fix it, maybe context switch code does that already or you
> >> have
> >> some other trick or reason it's not a problem. Am I way off base
> >> here?
> >
> > On x86, all stores become visible in-order globally.
> >
> > I suspect that
> > means any pending stores in the queue
> > would become visible to the rest of the system before
> > the store to the "current" cpu-local variable, as
> > well as other writes from the context switch code
> > become visible to the rest of the system.
> >
> > Is that too naive a way of preventing the scenario you
> > describe?
> >
> > What am I overlooking?
>
> I'm concerned if the physical address gets mapped with different
> cacheability attributes where that ordering is not enforced by cache
> coherency
>
>  "The PAT allows any memory type to be specified in the page tables, and
>  therefore it is possible to have a single physical page mapped to two
>  or more different linear addresses, each with different memory types.
>  Intel does not support this practice because it may lead to undefined
>  operations that can result in a system failure. In particular, a WC
>  page must never be aliased to a cacheable page because WC writes may
>  not check the processor caches." -- Vol. 3A 11-35
>
> Maybe I'm over thinking it, and this would never happen anyway because
> if anyone were to map a RAM page WC, they might always have to ensure
> all processor caches are flushed first anyway so perhaps this is just a
> non-issue?
>

After talking to Andrew Cooper (hi!), I think that, on reasonably
modern Intel machines, WC memory is still *coherent* with the whole
system -- it's just not ordered the usual way.  So I'm not convinced
there's an actual problem here.  I don't know about AMD.
