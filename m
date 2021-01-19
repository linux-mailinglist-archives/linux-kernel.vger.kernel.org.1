Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067E2FB82D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392246AbhASMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390364AbhASLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:53:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A4DF23104;
        Tue, 19 Jan 2021 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611057148;
        bh=mKBqhARbz0EvK1nVvLX5o/uMWK/IkLwQI9qSFY1seJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHEEInOExXj5qVjr/rl/OghKD8vV4yaMuc7mU7TJQY4caQRNULNJ3raAUOg87mKIk
         7tAXyWo8w6C0ucB0AiwOTBK4boCsEUlYBYOAHIwgCp2/4qfLToI58+AhU5R2tssfGA
         nNx6/sbDwWsufj4XDZtp9MahCwVL7q7bizYsYf7w=
Date:   Tue, 19 Jan 2021 12:52:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Splicing to/from a tty
Message-ID: <YAbH+cbki2By6ire@kroah.com>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com>
 <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 01:35:15PM -0800, Linus Torvalds wrote:
> On Mon, Jan 18, 2021 at 12:24 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Anybody want to play with this? I'd suggest keeping that "dummy"
> > parameter around for a while - I did an allmodconfig build with this,
> > but if there are any architecture-specific non-x86-64 cases I wouldn't
> > have seen them.
> 
> Not architecture-specific, but I did find by some grepping that I
> missed one line discipline driver: the Siemens R3964.
> 
> The reason I missed that is because it's been marked BROKEN in the
> Kconfig for almost two years, so it didn't show up in my allmodconfig
> coverage.

I need to just delete that thing now, obviously no one uses it anymore,
sorry for it getting in the way...

greg k-h
