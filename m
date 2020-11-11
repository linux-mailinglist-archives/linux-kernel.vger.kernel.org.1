Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5EC2AE552
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgKKBJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbgKKBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:09:20 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:09:20 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcedK-003BHU-BW; Wed, 11 Nov 2020 01:09:10 +0000
Date:   Wed, 11 Nov 2020 01:09:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix missing include in asm uaccess.h
Message-ID: <20201111010910.GZ3576660@ZenIV.linux.org.uk>
References: <20201111004440.8783-1-ansuelsmth@gmail.com>
 <20201111005826.GY3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111005826.GY3576660@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 12:58:26AM +0000, Al Viro wrote:
> On Wed, Nov 11, 2020 at 01:44:38AM +0100, Ansuel Smith wrote:
> > Fix a compilation error as PF_KTHREAD is defined in linux/sched.h and
> > this is missing.
> > 
> > Fixes: df325e05a682 ("arm64: Validate tagged addresses in access_ok()
> > called from kernel threads")
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 991dd5f031e4..51a4f63f464a 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -7,6 +7,8 @@
> >  #ifndef __ASM_UACCESS_H
> >  #define __ASM_UACCESS_H
> >  
> > +#include <linux/sched.h>
> > +
> >  #include <asm/alternative.h>
> >  #include <asm/kernel-pgtable.h>
> >  #include <asm/sysreg.h>
> 
> NAK.  The real bug is in arch/arm64/include/asm/asm-prototypes.h -
> it has no business pulling asm/uaccess.h
> 
> Just include linux/uaccess.h instead.

BTW,
$ grep -n uaccess.h `find -name asm-prototypes.h`
./arch/alpha/include/asm/asm-prototypes.h:7:#include <linux/uaccess.h>
./arch/arm64/include/asm/asm-prototypes.h:18:#include <asm/uaccess.h>
./arch/ia64/include/asm/asm-prototypes.h:12:#include <linux/uaccess.h>
./arch/mips/include/asm/asm-prototypes.h:6:#include <linux/uaccess.h>
./arch/powerpc/include/asm/asm-prototypes.h:14:#include <linux/uaccess.h>
./arch/sparc/include/asm/asm-prototypes.h:9:#include <linux/uaccess.h>
./arch/x86/include/asm/asm-prototypes.h:3:#include <linux/uaccess.h>

Spot the irregularity...

While we are at it,
$ git grep -n -w '#.*include.*asm/uaccess.h'
arch/arm64/include/asm/asm-prototypes.h:18:#include <asm/uaccess.h>
arch/nds32/math-emu/fpuemu.c:5:#include <asm/uaccess.h>
arch/powerpc/kvm/book3s_xive_native.c:15:#include <asm/uaccess.h>
arch/powerpc/mm/book3s64/radix_pgtable.c:30:#include <asm/uaccess.h>
drivers/s390/net/ctcm_mpc.c:50:#include <linux/uaccess.h>       /* instead of <asm/uaccess.h> ok ? */
include/linux/uaccess.h:11:#include <asm/uaccess.h>

The last one is the only such include that should exist; drivers/s390 one
is obviously a false positive.  And IMO the right thing to do is to
replace the remaining arch/* instances with includes of linux/uaccess.h.

All of those are asking for trouble; any change moving e.g. a common
variant of some primitive into linux/uaccess.h might end up breaking
those.
