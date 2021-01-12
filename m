Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB42F284C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbhALGTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:19:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbhALGTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:19:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6CEA206E9;
        Tue, 12 Jan 2021 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610432303;
        bh=qxj8fQLkntKVxCcGJcU7r9nfQRnnPazB5pQvXYx8tj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tTzdjp9Pz47/jh+vLvK/GfbdSveEsVxsdQIajgKXsHaCqc/dE/7Mt7HXsRMWc+IKT
         /gbPlY/tHgQ7Lcm4ozd/siHRDFP9L/z+6FjGYu+iktdd+2oQ4ar1b3kbQyGM4KSeFU
         cE3BAoDDX3FjlszGeQLf3BNn3WKjQQ0smfjfALiE=
Date:   Mon, 11 Jan 2021 22:18:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     hailong <hailongliiu@yeah.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ziliang Guo <guo.ziliang@zte.com.cn>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm/kasan:fix the arry size of kasan_early_shadow_pte
Message-Id: <20210111221820.b252f44de1e0bf4add506776@linux-foundation.org>
In-Reply-To: <CACRpkdY7eYyVNvqMRYvTQsLNrXa+fzPsWA5JHDuS4nqry+CHcw@mail.gmail.com>
References: <20210109044622.8312-1-hailongliiu@yeah.net>
        <CACRpkdb73diprma9Z1-4nm5A9OTQMeGVK=Hcqiwny9VOVdA=QQ@mail.gmail.com>
        <4c009d78.4e1.176ebcf8bc9.Coremail.hailongliiu@yeah.net>
        <CACRpkdY7eYyVNvqMRYvTQsLNrXa+fzPsWA5JHDuS4nqry+CHcw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jan 2021 13:03:49 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Jan 10, 2021 at 11:21 AM hailong <hailongliiu@yeah.net> wrote:
> 
> > >> +#ifndef PTE_HWTABLE_PTRS
> > >> +#define PTE_HWTABLE_PTRS 0
> > >> +#endif
> > >
> > >Can this even happen? We have either pgtable-2level.h or
> > >pgtable-3level.h, both of which define PTE_HWTABLE_PTRS.
> > >
> >
> > I guess not for arm. But I'm not sure for other ARCHs.
> 
> Oh it's a generic include. Sorry for the confusion.
> 
> All good then!
> 

This code is 2+ years old.  Do we think it warrants a cc:stable?
