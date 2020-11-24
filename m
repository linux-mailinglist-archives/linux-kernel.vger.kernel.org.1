Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDD12C1DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgKXGGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgKXGGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:06:30 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699C2206E5;
        Tue, 24 Nov 2020 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606197988;
        bh=P3cw+hY+r3IiY9t77q/gus8d2vQhBHLBFRGa6m2DSYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiFJL8evgczQqjdjHXwYeT8re+nlbxDdiXb+nQZ6rJcQcFlg5yf6Jj/KEfVNmhLx7
         JNL5HDVpFNBNwEkbHSuvAYRsNXSrI95b17Tr5Hsw9+RsfvY3AOcpeTIhs8DQpRJCjB
         yNVbuNXAOirmYwi6yTuxxUVcKliwguQi/yaaHNF8=
Date:   Tue, 24 Nov 2020 07:06:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dja@axtens.net, npiggin@gmail.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "powerpc/64s: flush L1D after user accesses" has been
 added to the 4.4-stable tree
Message-ID: <X7yi4q3CLZ74hPW0@kroah.com>
References: <160585744921681@kroah.com>
 <e11e8b93-084b-8746-3e16-73dd4ee94147@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e11e8b93-084b-8746-3e16-73dd4ee94147@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:18:05AM +0800, yangerkun wrote:
> 
> 
> 在 2020/11/20 15:30, gregkh@linuxfoundation.org 写道:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >      powerpc/64s: flush L1D after user accesses
> > 
> > to the 4.4-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       powerpc-64s-flush-l1d-after-user-accesses.patch
> > and it can be found in the queue-4.4 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > > > From foo@baz Fri Nov 20 08:28:41 AM CET 2020
> > From: Daniel Axtens <dja@axtens.net>
> > Date: Fri, 20 Nov 2020 11:07:04 +1100
> > Subject: powerpc/64s: flush L1D after user accesses
> > To: stable@vger.kernel.org
> > Cc: dja@axtens.net
> > Message-ID: <20201120000704.374811-9-dja@axtens.net>
> > 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > commit 9a32a7e78bd0cd9a9b6332cbdc345ee5ffd0c5de upstream.
> > 
> > IBM Power9 processors can speculatively operate on data in the L1 cache before
> > it has been completely validated, via a way-prediction mechanism. It is not possible
> > for an attacker to determine the contents of impermissible memory using this method,
> > since these systems implement a combination of hardware and software security measures
> > to prevent scenarios where protected data could be leaked.
> > 
> > However these measures don't address the scenario where an attacker induces
> > the operating system to speculatively execute instructions using data that the
> > attacker controls. This can be used for example to speculatively bypass "kernel
> > user access prevention" techniques, as discovered by Anthony Steinhauser of
> > Google's Safeside Project. This is not an attack by itself, but there is a possibility
> > it could be used in conjunction with side-channels or other weaknesses in the
> > privileged code to construct an attack.
> > 
> > This issue can be mitigated by flushing the L1 cache between privilege boundaries
> > of concern. This patch flushes the L1 cache after user accesses.
> > 
> > This is part of the fix for CVE-2020-4788.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   Documentation/kernel-parameters.txt            |    4 +
> >   arch/powerpc/include/asm/book3s/64/kup-radix.h |   23 ++++++
> >   arch/powerpc/include/asm/feature-fixups.h      |    9 ++
> >   arch/powerpc/include/asm/kup.h                 |    4 +
> >   arch/powerpc/include/asm/security_features.h   |    3
> >   arch/powerpc/include/asm/setup.h               |    1
> >   arch/powerpc/kernel/exceptions-64s.S           |   86 +++++++------------------
> >   arch/powerpc/kernel/ppc_ksyms.c                |    7 ++
> >   arch/powerpc/kernel/setup_64.c                 |   80 +++++++++++++++++++++++
> >   arch/powerpc/kernel/vmlinux.lds.S              |    7 ++
> >   arch/powerpc/lib/feature-fixups.c              |   50 ++++++++++++++
> >   arch/powerpc/platforms/powernv/setup.c         |    7 +-
> >   arch/powerpc/platforms/pseries/setup.c         |    4 +
> >   13 files changed, 224 insertions(+), 61 deletions(-)
> >   create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h
> > 
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -2197,6 +2197,7 @@ bytes respectively. Such letter suffixes
> >   					       mds=off [X86]
> >   					       tsx_async_abort=off [X86]
> >   					       no_entry_flush [PPC]
> > +					       no_uaccess_flush [PPC]
> >   			auto (default)
> >   				Mitigate all CPU vulnerabilities, but leave SMT
> > @@ -2521,6 +2522,9 @@ bytes respectively. Such letter suffixes
> >   	nospec_store_bypass_disable
> >   			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
> > +	no_uaccess_flush
> > +			[PPC] Don't flush the L1-D cache after accessing user data.
> > +
> >   	noxsave		[BUGS=X86] Disables x86 extended register state save
> >   			and restore using xsave. The kernel will fallback to
> >   			enabling legacy floating-point and sse state.
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
> > +#define _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
> > +#include <linux/jump_label.h>
> > +
> > +DECLARE_STATIC_KEY_FALSE(uaccess_flush_key);
> > +
> > +/* Prototype for function defined in exceptions-64s.S */
> > +void do_uaccess_flush(void);
> > +
> > +static __always_inline void allow_user_access(void __user *to, const void __user *from,
> > +					      unsigned long size)
> > +{
> > +}
> > +
> > +static inline void prevent_user_access(void __user *to, const void __user *from,
> 
> Hi,
> 
> This will redefine prevent_user_access and lead to compile error...
> 
> 
> In file included from arch/powerpc/kernel/ppc_ksyms.c:10:0:
> ./arch/powerpc/include/asm/book3s/64/kup-radix.h:11:29: error: redefinition
> of 'allow_user_access'
>  static __always_inline void allow_user_access(void __user *to, const void
> __user *from,
>                              ^~~~~~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/uaccess.h:12:0,
>                  from arch/powerpc/kernel/ppc_ksyms.c:8:
> ./arch/powerpc/include/asm/kup.h:12:20: note: previous definition of
> 'allow_user_access' was here
>  static inline void allow_user_access(void __user *to, const void __user
> *from,
>                     ^~~~~~~~~~~~~~~~~
> In file included from arch/powerpc/kernel/ppc_ksyms.c:10:0:
> ./arch/powerpc/include/asm/book3s/64/kup-radix.h:16:20: error: redefinition
> of 'prevent_user_access'
>  static inline void prevent_user_access(void __user *to, const void __user
> *from,
>                     ^~~~~~~~~~~~~~~~~~~
> In file included from ./arch/powerpc/include/asm/uaccess.h:12:0,
>                  from arch/powerpc/kernel/ppc_ksyms.c:8:
> ./arch/powerpc/include/asm/kup.h:14:20: note: previous definition of
> 'prevent_user_access' was here
>  static inline void prevent_user_access(void __user *to, const void __user
> *from,
>                     ^~~~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:277: arch/powerpc/kernel/ppc_ksyms.o]
> Error 1
> make[1]: *** Waiting for unfinished jobs....

Should be fixed in the -rc releases I just made yesterday, right?

thanks,

greg k-h
