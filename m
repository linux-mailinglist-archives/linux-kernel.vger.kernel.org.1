Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2D1DFD8E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgEXHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 03:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgEXHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 03:42:39 -0400
Received: from kernel.org (unknown [87.71.47.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E322076C;
        Sun, 24 May 2020 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590306158;
        bh=+/fFoXXRcAaUgRrF312cHC7kEgpII3DvTDA8eGvdehk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWl1umd9MDaNFTQL8vtXp9S91lOpXqHQ9cMIrKzvtvJqxr0KCUvLsyHedTsuWhcK+
         8p4N/kJG9k+82H1sIQsHwOKs9c4FXoHV+iXDzQ5Oe5TQpYgYs5FXHs7PZNERJRIt75
         vZQkuQA7RKAczl+NpjOLI6H7+2WtBYbABL56OTvw=
Date:   Sun, 24 May 2020 10:42:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/7] Record the mm_struct in the page table pages
Message-ID: <20200524074230.GM1118872@kernel.org>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200429002624.qkhb362moj6v3vtw@box>
 <20200429015126.GP29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429015126.GP29705@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 06:51:26PM -0700, Matthew Wilcox wrote:
> On Wed, Apr 29, 2020 at 03:26:24AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Apr 28, 2020 at 12:44:42PM -0700, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Pages which are in use as page tables have some space unused in struct
> > > page.  It would be handy to have a pointer to the struct mm_struct that
> > > they belong to so that we can handle uncorrectable errors in page tables
> > > more gracefully.  There are a few other things we could use it for too,
> > > such as checking that the page table entry actually belongs to the task
> > > we think it ought to.  This patch series does none of that, but does
> > > lay the groundwork for it.
> > > 
> > > Matthew Wilcox (Oracle) (7):
> > 
> > How does it work for kernel side of virtual address space?
> 
> init_mm

A note to keep in mind is that most of the kernel page tables are seen
as PG_reserved rather than PageTable().

> > And your employer may be interested in semantics around
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE :P
> 
> I was thinking about that.  Right now, it's only useful for debugging
> purposes (as you point out in a later email).  I think it's OK if shared
> PMDs aren't supported as well as regular PTEs, just because there are
> so few of them that uncorrectable errors are less likely to strike in
> those pages.
> 

-- 
Sincerely yours,
Mike.
