Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B52FEAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbhAUMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731063AbhAUMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:49:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CC5423A01;
        Thu, 21 Jan 2021 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611233311;
        bh=gLBZ7oIpe4JqnDbPBI/B1Zlmga9NbjcRNWLoXqmmt/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8zT771FvzWVLMViNI1FkbfkOnv/sOEZdK2gPYaYI2hZb3wZERrPo/yN0gxEJGMhY
         w6nq0IJSB+ARpx62eOTR1jllZOp1kNO5Aufl1jvFxlsIte7d6xgKsCLEsJcBY8cjLO
         L7g+Mow3w3fQb3dQ8hq8fWL9TvxKlqJhLeNAkPJjsokn59SJleo5k17GG8cniM6WXb
         AgoVklXAflBSf9MQWv/zeFNyG4ZVAAZM3t1+YZkrKGbnnu6NM3wXiAzqD5dTNl2vgj
         i3g6M2WYCu4leCNMAFkdHaavEIx8aOyJNOlGtX1/MQcCgrr2jgUmvyxvSbqB2kt/PP
         8DbVYEjiY2SPA==
Date:   Thu, 21 Jan 2021 12:48:25 +0000
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
Subject: Re: [PATCH v4 4/8] mm: Move immutable fields of 'struct vm_fault'
 into anonymous struct
Message-ID: <20210121124825.GB22123@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
 <20210120173612.20913-5-will@kernel.org>
 <CAKwvOd=UvtSnWiB94gvm0SE9DeJsaaVTJ_fpfh2B4NT1mhr-GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=UvtSnWiB94gvm0SE9DeJsaaVTJ_fpfh2B4NT1mhr-GQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:13:37AM -0800, Nick Desaulniers wrote:
> On Wed, Jan 20, 2021 at 9:36 AM Will Deacon <will@kernel.org> wrote:
> >
> > 'struct vm_fault' contains both information about the fault being
> > serviced alongside mutable fields contributing to the state of the
> > fault-handling logic. Unfortunately, the distinction between the two is
> > not clear-cut, and a number of callers end up manipulating the structure
> > temporarily before restoring it when returning.
> >
> > Try to clean this up by moving the immutable fault information into an
> > anonymous struct, which will later be marked as 'const'. GCC will then
> > complain (with an error) about modification of these fields after they
> > have been initialised, although LLVM currently allows them without even
> > a warning:
> >
> > https://bugs.llvm.org/show_bug.cgi?id=48755
> 
> I think this paragraph+link would be better on patch 8/8.

Agreed, I'll move it.

Will
