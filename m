Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F002F752F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbhAOJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbhAOJX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:23:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C1523128;
        Fri, 15 Jan 2021 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610702598;
        bh=YUOoXIAq/McVqyyFlnSUnFFrxg1lB2e+xTyNR3jGHyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEqu4l3j282rJAOphaS8MwVUBWSv9TQZdio0FDP+NxklrAhEgedE4wiyjcXV27oVH
         cuRO6fZEXjx26Egc7ICn3VrW/EJGj3OvXedjlLywgwx/oHVdHl61qAuRjUXn++6lOr
         ORCUtywMXqtaG7loHLP3FqxSqXJGCql/v5zeqIky2zzgwlfFuAsZ4TABILEO1J40R9
         mXIIbYoTR9aZ4Toj523mBY7xcOZ+WnEC8dYgRfCY1ohe0IqfK9b6zoAH99EvOeXvR/
         XkqP2hf5I+p22GOeQxk6SmGIYtT/KROrCiTqoZVEHMWNnfuFpgT3BWg+lI2QBYjjVX
         /+JV6lQm7iHPQ==
Date:   Fri, 15 Jan 2021 09:23:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
Message-ID: <20210115092313.GA13700@willie-the-truck>
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
 <20210114190021.GB13135@willie-the-truck>
 <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
 <20210114194129.GA13314@willie-the-truck>
 <CAHk-=wixswKjAPt0eEVSHqOQB9tBuO5FeqfyKyxFWyBLEG6EcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wixswKjAPt0eEVSHqOQB9tBuO5FeqfyKyxFWyBLEG6EcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 01:11:12PM -0800, Linus Torvalds wrote:
> On Thu, Jan 14, 2021 at 11:41 AM Will Deacon <will@kernel.org> wrote:
> >
> > Sure enough, an arm64 defconfig builds perfectly alright with that change,
> > but it really shouldn't. I'm using clang 11.0.5, so I had another go with
> > GCC 9.2.1 and bang:
> 
> Ok, looks like a clang bug, but a reasonably benign one.
> 
> As long as we have sufficient coverage with gcc, we'll get error
> reporting in a timely manner for any new incorrect assignments, so I
> think we can do that constant anonymous struct even if it does mean
> that clang might let some bad cases through (I personally use gcc for
> build testing, and then clang for building my boot kernels, so I'd
> catch anything x86-64 allmodconfig in my build tests).
> 
> And keeping it unnamed it would avoid a lot of noisy churn..

Hmm. The feedback on the clang bug suggests that GCC is the one in the
wrong here (although the argument is based on C11 and I haven't trawled
through the standards to see how this has evolved):

https://bugs.llvm.org/show_bug.cgi?id=48755#c1

There is at least some sympathy to generating a warning, so that might
be good enough. Otherwise, I suppose we can explicitly mark the fields
as 'const' but I won't jump to that immediately.

Will
