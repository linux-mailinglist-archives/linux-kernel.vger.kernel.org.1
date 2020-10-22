Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736B295CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896641AbgJVKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896594AbgJVKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:45:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B7C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Du1SSCXnSrdocEU/quDNtLt04UawTC5Df3w+0WlN3W8=; b=0HqndUpYEunyxC1QFg6Eps1FML
        a0rjNvZkuoHGWJU7KdGIfeL1nFDRxhAnSOvIgQb8JmNERKI64sI6gEC1tHZUSQhgCpTg4/EOExVov
        NHDvjgkMs7vZxCs9ZNsnj6dkbsIKozDSt4mQYsbp2iba8FtADuiHlt+2bJEvHO2+TvJnwMyLg6n8/
        g6X3im+tqS75DIxJ5beJXIGTEuwWa6xY6mC4BLYc3ZfuCmuZfX4K/vFpgN26JbVEXzu/cg5W1IUuR
        8+sWJhHh8TBCCLx6BWJmoy4fhffwNmNCTYbzo5wYOkww6DgR2GMRentfnaqfQT1NVGejpgDlxcc54
        dAw51jxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVY66-0008Se-5C; Thu, 22 Oct 2020 10:45:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEEA830377D;
        Thu, 22 Oct 2020 12:45:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADE07203D0836; Thu, 22 Oct 2020 12:45:27 +0200 (CEST)
Date:   Thu, 22 Oct 2020 12:45:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/alternative: don't call text_poke() in lazy TLB mode
Message-ID: <20201022104527.GI2594@hirez.programming.kicks-ass.net>
References: <20201009144225.12019-1-jgross@suse.com>
 <28ccccfe-b95b-5c4d-af27-5004e9f02c40@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28ccccfe-b95b-5c4d-af27-5004e9f02c40@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:24:39AM +0200, Jürgen Groß wrote:
> On 09.10.20 16:42, Juergen Gross wrote:
> > When running in lazy TLB mode the currently active page tables might
> > be the ones of a previous process, e.g. when running a kernel thread.
> > 
> > This can be problematic in case kernel code is being modified via
> > text_poke() in a kernel thread, and on another processor exit_mmap()
> > is active for the process which was running on the first cpu before
> > the kernel thread.
> > 
> > As text_poke() is using a temporary address space and the former
> > address space (obtained via cpu_tlbstate.loaded_mm) is restored
> > afterwards, there is a race possible in case the cpu on which
> > exit_mmap() is running wants to make sure there are no stale
> > references to that address space on any cpu active (this e.g. is
> > required when running as a Xen PV guest, where this problem has been
> > observed and analyzed).
> > 
> > In order to avoid that, drop off TLB lazy mode before switching to the
> > temporary address space.
> > 
> > Fixes: cefa929c034eb5d ("x86/mm: Introduce temporary mm structs")
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Can anyone look at this, please? It is fixing a real problem which has
> been seen several times.

As it happens I picked it up yesterday, just pushed it out for you.

Thanks!
