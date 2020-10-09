Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0914B288BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgJIOtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:49:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbgJIOtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:49:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F9CFAF33;
        Fri,  9 Oct 2020 14:49:38 +0000 (UTC)
Date:   Fri, 9 Oct 2020 16:49:36 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201009144936.GC3302@suse.de>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008191623.2881677-6-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:16:23PM -0400, Arvind Sankar wrote:
> On 64-bit, the startup_64_setup_env() function added in
>   866b556efa12 ("x86/head/64: Install startup GDT")
> has stack protection enabled because of set_bringup_idt_handler().
> 
> At this point, %gs is not yet initialized, and this doesn't cause a
> crash only because the #PF handler from the decompressor stub is still
> installed and handles the page fault.
> 
> Disable stack protection for the whole file, and do it on 32-bit as
> well to avoid surprises.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/kernel/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 04ceea8f4a89..68608bd892c0 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -47,6 +47,8 @@ endif
>  # non-deterministic coverage.
>  KCOV_INSTRUMENT		:= n
>  
> +CFLAGS_head$(BITS).o	+= -fno-stack-protector
> +
>  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
>  
>  obj-y			:= process_$(BITS).o signal.o
> -- 
> 2.26.2

Reviewed-by: Joerg Roedel <jroedel@suse.de>
