Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589C22F7696
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbhAOKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbhAOKZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:25:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F44236FB;
        Fri, 15 Jan 2021 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610706260;
        bh=HMdqhYxMZg+Yr+I0XiCS9E9xDkv6WxF8oA5PAduSBeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iT5eQuZzCxshhUvwbqMO1wsiWDIhBgFJNoGwSg9/QdHkONv8IxDuL9BFTc9dmLSgU
         K+1xVKUHagqWTDQkC/DQPCEwzOc/QzHi8LcOty+5n7GXBDGxdbz8dz9eqlHjJKYmjJ
         Z5MAIdlkJWCAcD8RFoUPdE3+c1vAqHPTK1VhxMsYsYz5hzNp1UxvcWz3IyVEcp9KwD
         LNkrnOeE78lZMeTBo1tFStw0iMm7NkNJsRDCx6ccGFScxt0Dmdd6hCIpwoVAlYcj/X
         XZi2ee0Fb5MPegwDBAHvydnTIn84IOLFiaxp44MGmvpySOgOLboygDCRC1r/C3Td8n
         l474gZRYSH1Ng==
Date:   Fri, 15 Jan 2021 10:24:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RFC PATCH 5/8] mm: Pass 'address' to map to do_set_pte() and
 drop FAULT_FLAG_PREFAULT
Message-ID: <20210115102414.GB14167@willie-the-truck>
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-6-will@kernel.org>
 <CAHk-=whA1yCmrARFQ88Af2fh+z1ufS=62eLdXgETBzfMX2bGUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whA1yCmrARFQ88Af2fh+z1ufS=62eLdXgETBzfMX2bGUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:17:22AM -0800, Linus Torvalds wrote:
> On Thu, Jan 14, 2021 at 10:01 AM Will Deacon <will@kernel.org> wrote:
> >
> > Rather than modifying the 'address' field of the 'struct vm_fault_info'
> > passed to do_set_pte(), leave that to identify the real faulting address
> > and pass in the virtual address to be mapped by the new pte as a
> > separate argument.
> 
> Ack.
> 
> In fact - apart from the question I had about the 'info' sub-structure
> - ack on the whole series. But this one struck me particularly as
> "that's simpler and clearer" even if that finish_fault() case is now
> not as pretty (but with an unnamed structure it would be slightly
> simpler, at least).

Thanks. I'll post another spin next week to avoid the named structure, but
if you (or anybody else) get a chance to glance over some of the other
things I mentioned in the cover letter beforehand that would be really
great.

Cheers,

Will
