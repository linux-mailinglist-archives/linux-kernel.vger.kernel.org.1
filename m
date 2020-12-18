Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9912DE89F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLRR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgLRR6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:58:38 -0500
Date:   Fri, 18 Dec 2020 09:57:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608314277;
        bh=qGSe6KrXUX2uhy+nL6ByzoHaAd0rggvdWYbrTQfUArA=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=oUcK3gDEXJ2jHolfortkMqAoKBZqdnuXKAazDAP/sYhdzYKP1No3xpl4p+oyM03EM
         +c2lua0idhKfeuxxuz0okD6evAk4oS9r/HVyIrA2Xu0j19Ufj5ZN+L1eJtPyl6Rzw6
         FoMXpb/ZQ9uzrmAD2DCpkZ3Y6wU6WxhuY4wSTmK0=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiangyang Yu <yuxiangyang4@huawei.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Fix warning: no previous prototype
Message-Id: <20201218095756.18d259ea243e434a8a90403a@linux-foundation.org>
In-Reply-To: <CAFqt6zYeDstXBHP+DCyBdmL4vDFBGekv7jrknU5c175sKVax4w@mail.gmail.com>
References: <20201217020311.491799-1-yuxiangyang4@huawei.com>
        <20201217022306.GB15600@casper.infradead.org>
        <CAFqt6zYeDstXBHP+DCyBdmL4vDFBGekv7jrknU5c175sKVax4w@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 09:39:30 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> On Thu, Dec 17, 2020 at 7:53 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Dec 17, 2020 at 10:03:11AM +0800, Xiangyang Yu wrote:
> > > Fixed the warning when building with warnings enabled (W=1),
> > > This function is only used in filemap.c, so mark this function
> > > with 'static'.
> >
> > Good grief, no.  Look at the git history before proposing a patch.
> 
> revert "mm/filemap: add static for function __add_to_page_cache_locked"
> Revert commit 3351b16af494 ("mm/filemap: add static for function
> __add_to_page_cache_locked") due to incompatibility with
> ALLOW_ERROR_INJECTION which result in build errors.
> 

How about we add a prototype for __add_to_page_cache_locked() to squash
the warning, along with a comment explaining what's going on?

