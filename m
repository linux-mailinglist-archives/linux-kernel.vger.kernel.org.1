Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFDF2F6A55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbhANTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbhANTBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:01:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD48023A05;
        Thu, 14 Jan 2021 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610650827;
        bh=7t82loxEyJ2bTsA9EqHNDMaRiGP+/aM7PE+ab8wFi3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVJfEn3qBdkiv78bi7h7P6opC4Z40CkSidAeQv04OpgmsJGT1DefXtedEe/3ApXXq
         frODFjMe7gyBnqWivoA1VoPLHuoMIHS2AdIA5NhVk396FO2Lahcjb0hjoj6R8w08x0
         /0fRNwXorPLfMcYC1JLTgR2gJipADH+l5ni0t9F+vYKH1fLpWh6f6la0iUUwcJgTVV
         LNlfiTw/CvD01hZAK5b3faqZv2P1oXRgX1l9dWE2SxDuDjH0zDnyv5ySGApykE+zzu
         MEq6690HQGRwLECS3Am+M0zHKU2fniDxYyJvGTffliyXQSq1Ycslrz93Bj9HO4W9Xz
         Gbgg16YmpSDXA==
Date:   Thu, 14 Jan 2021 19:00:22 +0000
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
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
Message-ID: <20210114190021.GB13135@willie-the-truck>
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:16:13AM -0800, Linus Torvalds wrote:
> On Thu, Jan 14, 2021 at 10:01 AM Will Deacon <will@kernel.org> wrote:
> >
> > Try to clean this up by splitting the immutable fault information out
> > into a new 'struct vm_fault_info' which is embedded in 'struct vm_fault'
> > and will later be made 'const'. The vast majority of this change was
> > performed with a coccinelle patch:
> 
> You may have a reason for doing it this way, but my reaction to this
> was: "just make the new embedded struct unnamed".
> 
> Then you wouldn't need to do all the automated coccinelle changes.
> 
> Is there some reason you didn't do that, or just a "oh, I didn't think of
> it".

I tried that initially, e.g.

struct vm_fault {
	const struct {
		unsigned long address;
		...
	};
};

but I found that I had to make all of the members const to get it to work,
at which point the anonymous struct wasn't really adding anything. Did I
just botch the syntax?

Will
