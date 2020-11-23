Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853922C110B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbgKWQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgKWQsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:48:50 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82EA520717;
        Mon, 23 Nov 2020 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606150130;
        bh=ARuPgpdEJcSeF2gm4TH6D3zIPUtJVSXUazCL6eofvtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZkzFwIbcGWn1pF2cCwkM9QWKaWhbBLfrlR5scjzuLzYN7EuBE9PNsmCz/sd62Bd2
         ol1J06dGh4Gnthl8GuICOurG5vhJZhQ+lnmvTBWlDQz0s3desFT3sncQu1b7JunKpc
         LArLadFWviiaTBFBU7BuAPj9MaR2PIgD/mDK5zTE=
Date:   Mon, 23 Nov 2020 16:48:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/6] tlb: mmu_gather: Remove unused start/end arguments
 from tlb_finish_mmu()
Message-ID: <20201123164844.GB11494@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-4-will@kernel.org>
 <CAHk-=whp=cyfq6kuVWHRbMxOak0-pJPdHsX7ghYaS6i6ETd_fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whp=cyfq6kuVWHRbMxOak0-pJPdHsX7ghYaS6i6ETd_fQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:20:43AM -0800, Linus Torvalds wrote:
> On Fri, Nov 20, 2020 at 6:36 AM Will Deacon <will@kernel.org> wrote:
> >
> > tlb_finish_mmu() takes two confusing and unused 'start'/'end' address
> > arguments. Remove them.
> 
> Ack, but please add the history to it.
> 
> Those arguments were used, up until 7a30df49f63a ("mm: mmu_gather:
> remove __tlb_reset_range() for force flush").
> 
> And the thing is, using a range flush in theory might be better, but
> for simplicity it's now doing a "fullmm" one, which is why those
> arguments no longer matter.
> 
> (And I think we track the range better now too, which may be another
> reason they aren't needed)

Yes, thanks for digging that up. I'll add it to the commit message in v2.

Will
