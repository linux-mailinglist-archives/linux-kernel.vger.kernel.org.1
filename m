Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4B29D610
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgJ1WLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34574 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730665AbgJ1WLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:23 -0400
Received: from zn.tnic (p200300ec2f0aab00f97e6c5296953a73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ab00:f97e:6c52:9695:3a73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 561D51EC03C1;
        Wed, 28 Oct 2020 20:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603914244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kmhsCqnOlHi4ixOVZ87EzyZjkxp8ouvhlUNx8nUfMNI=;
        b=KM2UZ92zuUSHGj0wXw1SSR97tAhO8TD14jN4ALj3QsH/FMGj68Squ6Qf/ED6JOmNn6X9DD
        qbnNPmqy4PYEyoPfu/cEofZhVuWfBHQgqqvAlBjMS6HSt4y+/u0FHVoNH1J7GQILHaVxIN
        BLJNlTRd/dw9XJ2nn/YnsfriM9zBOfc=
Date:   Wed, 28 Oct 2020 20:43:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201028194355.GB27112@zn.tnic>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
 <20201027200803.GL15580@zn.tnic>
 <20201027211422.GC1833548@rani.riverdale.lan>
 <20201028133909.GA27112@zn.tnic>
 <20201028164551.GA1989568@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028164551.GA1989568@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:45:51PM -0400, Arvind Sankar wrote:
> You don't want to try to run the kernel from physical address 0 in any
> case. The default is set to 16MiB to avoid low memory, historically to
> avoid the 24-bit ISA DMA range.

Sure, that's why I wrote:

"... so I guess this should be a range > 0 specification but I guess not
important."

So how about a sentence or two alluding to that fact in the help text of
that option?

> This doesn't matter for the 64-bit kernel, which can be run from any
> physical address independent of the RELOCATABLE/PHYSICAL_START settings.
> It only matters on 32-bit, where VA and PA are tied together by
> 	VA == __PAGE_OFFSET + PA

You mean the kernel text mapping I assume because we do

#define __va(x)                 ((void *)((unsigned long)(x)+PAGE_OFFSET))

on 64-bit too but that's the direct mapping of all physical memory.

> On 64-bit, the kernel's location in VA space and physical space can be
> independently moved around, so a kernel that starts at 16MiB in VA space
> can be loaded anywhere above 16MiB in physical space.

Right.

> KERNEL_IMAGE_SIZE is _not_ the size of the kernel image, the name is
> misleading.

So that needs fixing too, I guess.

> It is the maximum VA that the kernel can occupy, it is used
> to prepopulate the PMD-level pagetable for initial boot (level2_kernel_pgt)
> and is also used to define MODULES_VADDR, so it _is_ talking about
> mappings. If you have a 30MiB kernel that is placed at a starting VA of
> 510MiB when KERNEL_IMAGE_SIZE is 512MiB, it won't boot.

... because not the whole kernel will be mapped, sure. There's a comment
above KERNEL_IMAGE_SIZE which could use some of that explanation.

> Increasing vmlinux size can trigger the problem by pushing _end
> beyond KERNEL_IMAGE_SIZE, but the problem occurs once _end -
> __START_KERNEL_map exceeds KERNEL_IMAGE_SIZE, not when _end - _text
> exceeds it, hence this patch.

Understood - in both cases, once _end goes beyond the 512MiB end of the
PMD mapping, we've lost. Please add that part to the commit message too
because we will forget.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
