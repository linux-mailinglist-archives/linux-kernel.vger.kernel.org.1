Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC42A37F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgKCAlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:41:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgKCAlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:41:36 -0500
Date:   Tue, 3 Nov 2020 01:41:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604364094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2AF0U76zm2s2iriIo7aiBnmjx967MYt2Q1XmrP87dI=;
        b=jEugjslvw9QOrtTL2Do5SiV7/CyTvmgbZSYkHWTDz32HsOFZROrs4eadYsnDoc0CdyKJfn
        qvOeHQyAUbDimOg8wvNIA8kR93DHki/4cOfNFnrilQVgUAilussv9ciVWAdUudBeBUxXz5
        in5g42A6GoUKgo+GOy9PENlGsZeLHeSCdYjH+aaiADhFyTQbgdCgCqfhSiw0t83VuB2All
        NRsLwWIMzA5/bTY6qUMw8AkPMtlvRLf3cNdG4/dVADNV6Op5NPqXiUr4wbVZDUQEJ07OR6
        dGUJqWMkchIKLQ1jdRtE24Q9sJ0alekjeahp/ei0ZqlbCV+ZNwg6GGrPSqutaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604364094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2AF0U76zm2s2iriIo7aiBnmjx967MYt2Q1XmrP87dI=;
        b=7gpvmw3b9a7Eha27uiUG0YOufYbUMYxwNHj8774DX5syjbP1Q2JYEiLbePoznnwOBMDvEi
        b6mUyiVAmRVu5HBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201103004133.GD52235@lx-t490>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490>
 <20201103002532.GL2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103002532.GL2620339@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 08:25:32PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 03, 2020 at 01:17:12AM +0100, Ahmed S. Darwish wrote:
>
> > Please stick with the official exported API: raw_write_seqcount_begin().
>
> How did you know this was 'offical exported API' ??
>

All the official exported seqlock.h APIs are marked with verbose
kernel-doc annotations on top. The rest are internal...

> > Exactly. '*_seqcount_t_*' is a seqlock.h implementation detail, and it
> > has _zero_ relevance to what is discussed in this thread actually.
>
> Add some leading __'s to them?
>

It's a bit more complicated than just adding some "__" prefixes, due to
the massive compile-time polymorphism done through _Generic().

The '*_seqcount_t_*' format was the best we could come up with to
distinguish (again, for internal seqlock.h code) between macros taking
all seqcount_LOCKNAME_t types, and macros/functions taking only plain
seqcount_t.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
