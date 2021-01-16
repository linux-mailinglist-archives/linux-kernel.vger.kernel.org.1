Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A82F8F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 21:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbhAPU4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 15:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbhAPU4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 15:56:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76CAA22CAD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610830530;
        bh=BeMsLgtzunhMmzgm0Vjq/a3pyJRmRQYXYMnno+68i84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBbfAjXkte7MqCp6NS6IXyvVwdRVLvlKA9iLbTfsVqW8ULvYPBjS6vwSGMnr4sLs1
         KlPEa4zY+RsASveDkHBsLWYdZZGsTuVJXPOPffepL7gvOIUZb/pbjTAPxcmwqVUSqS
         8GBR7Gkuk0hluUgUWWd25kG/Mbcs2j8Sel5VRQ0080jOuaDTCGhjRjTizHs//6zx4w
         yDRpxf4Zyz+OUVCa10viyNdpkLZkHNa+BIPOuNfcCAZkNuInNiIecDtagvptwF/pFu
         9IUAfBYyKVKyBUYLbC2FVKQ3fRW734Y0swApK+6jpI9mHMRuMJO+slmM6OaX6QZDJB
         VWRc4iitNVdNg==
Received: by mail-qt1-f171.google.com with SMTP id e15so8671513qte.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 12:55:30 -0800 (PST)
X-Gm-Message-State: AOAM533iiHoYrxMG9n81J+c0kNqFNS5rUkKp1LP7HPfcwVEOWEKHmmzJ
        F8Zv8vnGLOgI73ZNEsZZ0+M5b+kn0mNaPv58CzY=
X-Google-Smtp-Source: ABdhPJyVqC6YZ3AAkpaYTbwJbC5yFrzUrqln3Xh3Pl64/pwMkcExpotcf6ca+ruH1RERS/+wusfDwoKv6Z1D+w0C8vs=
X-Received: by 2002:ac8:70c1:: with SMTP id g1mr17226966qtp.108.1610830529719;
 Sat, 16 Jan 2021 12:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20210106213547.1077789-1-timur@tabi.org> <X/wkMMiPPBAJb9+A@alley>
 <20210111173009.fe2383539e5ca2c23b135262@linux-foundation.org>
 <d067f15a-8816-8879-e575-b610707c5189@kernel.org> <YAFenc9MHvPNrZ06@alley>
In-Reply-To: <YAFenc9MHvPNrZ06@alley>
From:   Timur Tabi <timur@kernel.org>
Date:   Sat, 16 Jan 2021 14:54:52 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUO9nC2JoadaZ8HgwuAGEYV=Hiz8g6y94jzCLp2mJP8nA@mail.gmail.com>
Message-ID: <CAOZdJXUO9nC2JoadaZ8HgwuAGEYV=Hiz8g6y94jzCLp2mJP8nA@mail.gmail.com>
Subject: Re: [PATCH] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed addresses
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Roman Fietze <roman.fietze@magna.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 3:24 AM Petr Mladek <pmladek@suse.com> wrote:

> By other words, every print_hex_dump() used need to be reviewed in
> which context might be called.

I did a rough analysis of all current usage of DUMP_PREFIX_ADDRESS in
the kernel, compared to the introduction of %px and hashed addresses,
using git-blame to find the most recent commit that modifies a line
that contains _ADDRESS.  Of 150 cases, 110 of them are newer than %px,
so I'm assuming that these developers chose _ADDRESS instead of
_OFFSET knowing that the addresses are hashed.

> > If you want, I can include a patch that changes a few callers of
> > print_hex_dump() to use DUMP_PREFIX_UNHASHED, based on what I think would be
> > useful.
>
> It would be nice.

I have a v2 that I'm about to post, and I included a patch that
modifies check_poison_mem() in mm/page_poison.c.  I chose this file
because I figured actual addresses would probably be necessary for
tracking memory-related errors.  Also, that call to print_hex_dump()
was added back in 2009, so it predates the introduction of %px.
