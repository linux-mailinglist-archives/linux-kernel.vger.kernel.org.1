Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35C2D44CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbgLIOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733151AbgLIOu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:50:57 -0500
Date:   Wed, 9 Dec 2020 15:51:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607525416;
        bh=xQW8DHJnS9n4DgZiKatAysvWtjiwU89JLPPt2c7AKco=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=brhmw8I7ANNaWwM3T3RN04bTdEYsnWnhorRlq/7tQAxGKoYLdfx19q4yvYKpCtV9q
         nXtz2rdKcICieDpF9wMXVAaUarDoDtvo9Y/wazSQE+sAfP5mEPNGonI0ah4cwBYK2I
         ssAV8dkYEEeeruTUgdiNL/CfUiv0+YFmbjgYx6Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lkdtm: don't move ctors to .rodata
Message-ID: <X9DkdTGAiAEfUvm5@kroah.com>
References: <20201207170533.10738-1-mark.rutland@arm.com>
 <202012081319.D5827CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012081319.D5827CF@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 01:20:56PM -0800, Kees Cook wrote:
> On Mon, Dec 07, 2020 at 05:05:33PM +0000, Mark Rutland wrote:
> > When building with KASAN and LKDTM, clang may implictly generate an
> > asan.module_ctor function in the LKDTM rodata object. The Makefile moves
> > the lkdtm_rodata_do_nothing() function into .rodata by renaming the
> > file's .text section to .rodata, and consequently also moves the ctor
> > function into .rodata, leading to a boot time crash (splat below) when
> > the ctor is invoked by do_ctors().
> > 
> > Let's prevent this by marking the function as noinstr rather than
> > notrace, and renaming the file's .noinstr.text to .rodata. Marking the
> > function as noinstr will prevent tracing and kprobes, and will inhibit
> > any undesireable compiler instrumentation.
> > 
> > The ctor function (if any) will be placed in .text and will work
> > correctly.
> > 
> > Example splat before this patch is applied:
> > 
> > [    0.916359] Unable to handle kernel execute from non-executable memory at virtual address ffffa0006b60f5ac
> > [    0.922088] Mem abort info:
> > [    0.922828]   ESR = 0x8600000e
> > [    0.923635]   EC = 0x21: IABT (current EL), IL = 32 bits
> > [    0.925036]   SET = 0, FnV = 0
> > [    0.925838]   EA = 0, S1PTW = 0
> > [    0.926714] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000427b3000
> > [    0.928489] [ffffa0006b60f5ac] pgd=000000023ffff003, p4d=000000023ffff003, pud=000000023fffe003, pmd=0068000042000f01
> > [    0.931330] Internal error: Oops: 8600000e [#1] PREEMPT SMP
> > [    0.932806] Modules linked in:
> > [    0.933617] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc7 #2
> > [    0.935620] Hardware name: linux,dummy-virt (DT)
> > [    0.936924] pstate: 40400005 (nZcv daif +PAN -UAO -TCO BTYPE=--)
> > [    0.938609] pc : asan.module_ctor+0x0/0x14
> > [    0.939759] lr : do_basic_setup+0x4c/0x70
> > [    0.940889] sp : ffff27b600177e30
> > [    0.941815] x29: ffff27b600177e30 x28: 0000000000000000
> > [    0.943306] x27: 0000000000000000 x26: 0000000000000000
> > [    0.944803] x25: 0000000000000000 x24: 0000000000000000
> > [    0.946289] x23: 0000000000000001 x22: 0000000000000000
> > [    0.947777] x21: ffffa0006bf4a890 x20: ffffa0006befb6c0
> > [    0.949271] x19: ffffa0006bef9358 x18: 0000000000000068
> > [    0.950756] x17: fffffffffffffff8 x16: 0000000000000000
> > [    0.952246] x15: 0000000000000000 x14: 0000000000000000
> > [    0.953734] x13: 00000000838a16d5 x12: 0000000000000001
> > [    0.955223] x11: ffff94000da74041 x10: dfffa00000000000
> > [    0.956715] x9 : 0000000000000000 x8 : ffffa0006b60f5ac
> > [    0.958199] x7 : f9f9f9f9f9f9f9f9 x6 : 000000000000003f
> > [    0.959683] x5 : 0000000000000040 x4 : 0000000000000000
> > [    0.961178] x3 : ffffa0006bdc15a0 x2 : 0000000000000005
> > [    0.962662] x1 : 00000000000000f9 x0 : ffffa0006bef9350
> > [    0.964155] Call trace:
> > [    0.964844]  asan.module_ctor+0x0/0x14
> > [    0.965895]  kernel_init_freeable+0x158/0x198
> > [    0.967115]  kernel_init+0x14/0x19c
> > [    0.968104]  ret_from_fork+0x10/0x30
> > [    0.969110] Code: 00000003 00000000 00000000 00000000 (00000000)
> > [    0.970815] ---[ end trace b5339784e20d015c ]---
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Oh, eek. Why was a ctor generated at all? But yes, this looks good.
> Greg, can you pick this up please?
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Now picked up, thanks.

greg k-h
