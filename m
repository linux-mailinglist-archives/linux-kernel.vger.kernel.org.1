Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E82F3DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbhALVsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbhALVsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:48:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DBF42313C;
        Tue, 12 Jan 2021 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610488085;
        bh=xEYKassPQC4sKkuJ/2fsneFhalU4oSuuI5/rscjtbAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icrdld4c54puBOpoMHt9NPZtfqeCBNMviZxMC5FDARPEr9/3jX8GtCDAHsbVBHpxu
         NB0eNSp/vmkU8PDKa4tkMDYjcVKZ1NybKKK9bfIEwIJIiS2za7N9YaVVSmYDrDDlKl
         Yois18ZHdKDcmOpujXX4l9WUOxmdNbrBKSD6TfGqSV1mPuvHMkcTINIjtHNqoONxyM
         zuzGwkrXpGMDjaJBy0XEDfW1GDs79rD4pH7Ygps03ur03fsPjSDRytFmzWpewqdLfc
         LPbbVt2UQuN3vyhC2nzEH5hQ++y4Eq05d5Ct6komeN41vBqMsNO5W/unjq7rLSzA5W
         o7W9L+GLIS6VQ==
Date:   Tue, 12 Jan 2021 21:47:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
Message-ID: <20210112214759.GC10434@willie-the-truck>
References: <20210108171517.5290-1-will@kernel.org>
 <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
 <20210111142402.6euyktmcnpemanf7@box>
 <CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:25:37AM -0800, Linus Torvalds wrote:
> On Mon, Jan 11, 2021 at 6:24 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > I wonder if it would be acceptable to pass down to faultaround a copy
> > of vmf, so it mess with it without risking to corrupt the original one?
> 
> I'd almost prefer to split vmf into two parts: the 'this is the fault
> info' part and the 'this is the fault handling state' part.
> 
> So the first one would be filled in by the actual page faulter (or
> GUP) - and then be 'const' during the lookup, while the second one
> would be set up by handle_mm_fault() and would contain that "this is
> the current state of my fault state machine" and contain things like
> that ->pte thing.
> 
> And then if somebody actually needs to pass in "modified fault state"
> (ie that whole "I'm doing fault-around, so I'll use multiple
> addresses") they'd never modify the address in the fault info, they'd
> just pass the address as an explicit argument (like most cases already
> do - the "change addr or flags in vmf" is actually already _fairly_
> rare).

Alright then, I'll take another crack at this for v3 and see how far I
get.

Will
