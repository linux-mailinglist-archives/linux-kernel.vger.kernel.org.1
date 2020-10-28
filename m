Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21129DF77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbgJ2BBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbgJ1WR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B48246A3;
        Wed, 28 Oct 2020 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603879254;
        bh=Zt06lJI/dyFmw+ygkxHH5YVanDHB4SbCK4oB2OLbzQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSE1DqcXeyFOXYe0GIro3PncnXe5qeo/vOgtS4PXRISXJH1OqtuoIMS359F505mMk
         gzBvRfj63gy2UcWFHugd3z8J+g+Q3ltJIvRWwUVKOF9L2wXDOCEThpkxDbZ7xvQuQN
         MZxdVjMtsjlnbrZXEXq21q8GefUyyUDnTG3Wpo+c=
Date:   Wed, 28 Oct 2020 10:00:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] module: use hidden visibility for weak symbol references
Message-ID: <20201028100049.GA27873@willie-the-truck>
References: <20201027151132.14066-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027151132.14066-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Oct 27, 2020 at 04:11:32PM +0100, Ard Biesheuvel wrote:
> Geert reports that commit be2881824ae9eb92 ("arm64/build: Assert for
> unwanted sections") results in build errors on arm64 for configurations
> that have CONFIG_MODULES disabled.
> 
> The commit in question added ASSERT()s to the arm64 linker script to
> ensure that linker generated sections such as .got, .plt etc are empty,
> but as it turns out, there are corner cases where the linker does emit
> content into those sections. More specifically, weak references to
> function symbols (which can remain unsatisfied, and can therefore not
> be emitted as relative references) will be emitted as GOT and PLT
> entries when linking the kernel in PIE mode (which is the case when
> CONFIG_RELOCATABLE is enabled, which is on by default).
> 
> What happens is that code such as
> 
> 	struct device *(*fn)(struct device *dev);
> 	struct device *iommu_device;
> 
> 	fn = symbol_get(mdev_get_iommu_device);
> 	if (fn) {
> 		iommu_device = fn(dev);
> 
> essentially gets converted into the following when CONFIG_MODULES is off:
> 
> 	struct device *iommu_device;
> 
> 	if (&mdev_get_iommu_device) {
> 		iommu_device = mdev_get_iommu_device(dev);
> 
> where mdev_get_iommu_device is emitted as a weak symbol reference into
> the object file. The first reference is decorated with an ordinary
> ABS64 data relocation (which yields 0x0 if the reference remains
> unsatisfied). However, the indirect call is turned into a direct call
> covered by a R_AARCH64_CALL26 relocation, which is converted into a
> call via a PLT entry taking the target address from the associated
> GOT entry.
> 
> Given that such GOT and PLT entries are unnecessary for fully linked
> binaries such as the kernel, let's give these weak symbol references
> hidden visibility, so that the linker knows that the weak reference
> via R_AARCH64_CALL26 can simply remain unsatisfied.
> 
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/module.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Cheers. I gave this a spin, but I unfortunately still see the following
linker warning with allnoconfig:

  aarch64-linux-gnu-ld: warning: orphan section `.igot.plt' from `arch/arm64/kernel/head.o' being placed in section `.igot.plt'

which looks unrelated to symbol_get(), but maybe it's worth knocking these
things on the head (no pun intended) at the same time?

Cheers,

Will
