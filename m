Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD492FEAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbhAUMwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbhAUMva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:51:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF22239FD;
        Thu, 21 Jan 2021 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611233449;
        bh=2X/UdBtskFG5nLtVzkFy8EK565N+XAb9l90On4yYN/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzKT2k1TVufQRMdOpt9MiPdsouFFgMF7aMiXH35ldlRBAiRsZ2zw3Xl7+/y83VtaN
         uiH/Qf3itPcNTA1hH/dswt4Fi3CPqWgHAjk+NtQ2AnaIkUBRW4JkudI1nKryEz8lNN
         ttYo5y7ckYo16OHK+htDWCJJ8jgxCSBihJwGCJzbUjOMGLvfVy6u87xnSMme5Wu2BK
         f3aOhMuM61fyHeqvQ+vMiBWRXH3DX9fd2r1D7xRQgcys886Hxgsl/t/dyBKLAmZs+2
         UtKc8oAslBAsi6i+Bc0YNEVYRKYBMSMM+xt29ya3FZ7F7Z/wX4llL2Iy6cp/0oCdou
         cTbxMFkF4crjw==
Date:   Thu, 21 Jan 2021 12:50:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v4 7/8] mm: Use static initialisers for immutable fields
 of 'struct vm_fault'
Message-ID: <20210121125043.GC22123@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
 <20210120173612.20913-8-will@kernel.org>
 <CAKwvOdkqGy9O8yAnyeJO-P3WssRa1=OS=Q-T2ZV1vGwdwi=6+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkqGy9O8yAnyeJO-P3WssRa1=OS=Q-T2ZV1vGwdwi=6+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:21:33AM -0800, Nick Desaulniers wrote:
> On Wed, Jan 20, 2021 at 9:36 AM Will Deacon <will@kernel.org> wrote:
> >
> > In preparation for const-ifying the anonymous struct field of
> > 'struct vm_fault', ensure that it is initialised using static
> > initialisers.
> 
> FWIW these are known as "designated initializers", ie.
> 
> struct foo my_foo = {
>   .bar = 42,
> };
> 
> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

Thanks, I'm useless with terminology. Will update.

Will
