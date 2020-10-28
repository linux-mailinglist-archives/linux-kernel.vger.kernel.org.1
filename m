Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A8C29D715
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgJ1WUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731722AbgJ1WRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:42 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B8C2475C;
        Wed, 28 Oct 2020 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603893829;
        bh=R1GyTChVAmGg+2R9+tBK0PjVhy7YwXzx/I4+ar6G2AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7tthfxZkyl/7YNfwNwsVOxUyjePEstWObjwYTAN8tyVfQw5FDJC/k/vhGoTKrNV2
         24ANd75f2WhA46GETZ4VHwhra41EFKU+U4n7WELg0XXR1qkT5yPVl+dxddNeDuhIP+
         YQH797PbgWGXya9D+qKROz59G51WxwrLiZrKDz5A=
Date:   Wed, 28 Oct 2020 15:03:44 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] module: use hidden visibility for weak symbol references
Message-ID: <20201028140344.GB6867@linux-8ccs>
References: <20201027151132.14066-1-ardb@kernel.org>
 <20201028100049.GA27873@willie-the-truck>
 <CAMj1kXHFwmjz9CJGrBJ_E4nau=0gqSnR6B6wv6wVq5QHd0tYJg@mail.gmail.com>
 <20201028132437.GA28251@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201028132437.GA28251@willie-the-truck>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Will Deacon [28/10/20 13:24 +0000]:
>On Wed, Oct 28, 2020 at 01:27:01PM +0100, Ard Biesheuvel wrote:
>> On Wed, 28 Oct 2020 at 11:00, Will Deacon <will@kernel.org> wrote:
>> > On Tue, Oct 27, 2020 at 04:11:32PM +0100, Ard Biesheuvel wrote:
>> > > Geert reports that commit be2881824ae9eb92 ("arm64/build: Assert for
>> > > unwanted sections") results in build errors on arm64 for configurations
>> > > that have CONFIG_MODULES disabled.
>> > >
>> > > The commit in question added ASSERT()s to the arm64 linker script to
>> > > ensure that linker generated sections such as .got, .plt etc are empty,
>> > > but as it turns out, there are corner cases where the linker does emit
>> > > content into those sections. More specifically, weak references to
>> > > function symbols (which can remain unsatisfied, and can therefore not
>> > > be emitted as relative references) will be emitted as GOT and PLT
>> > > entries when linking the kernel in PIE mode (which is the case when
>> > > CONFIG_RELOCATABLE is enabled, which is on by default).
>> > >
>> > > What happens is that code such as
>> > >
>> > >       struct device *(*fn)(struct device *dev);
>> > >       struct device *iommu_device;
>> > >
>> > >       fn = symbol_get(mdev_get_iommu_device);
>> > >       if (fn) {
>> > >               iommu_device = fn(dev);
>> > >
>> > > essentially gets converted into the following when CONFIG_MODULES is off:
>> > >
>> > >       struct device *iommu_device;
>> > >
>> > >       if (&mdev_get_iommu_device) {
>> > >               iommu_device = mdev_get_iommu_device(dev);
>> > >
>> > > where mdev_get_iommu_device is emitted as a weak symbol reference into
>> > > the object file. The first reference is decorated with an ordinary
>> > > ABS64 data relocation (which yields 0x0 if the reference remains
>> > > unsatisfied). However, the indirect call is turned into a direct call
>> > > covered by a R_AARCH64_CALL26 relocation, which is converted into a
>> > > call via a PLT entry taking the target address from the associated
>> > > GOT entry.
>> > >
>> > > Given that such GOT and PLT entries are unnecessary for fully linked
>> > > binaries such as the kernel, let's give these weak symbol references
>> > > hidden visibility, so that the linker knows that the weak reference
>> > > via R_AARCH64_CALL26 can simply remain unsatisfied.
>> > >
>> > > Cc: Jessica Yu <jeyu@kernel.org>
>> > > Cc: Kees Cook <keescook@chromium.org>
>> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
>> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> > > ---
>> > >  include/linux/module.h | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Cheers. I gave this a spin, but I unfortunately still see the following
>> > linker warning with allnoconfig:
>> >
>> >   aarch64-linux-gnu-ld: warning: orphan section `.igot.plt' from `arch/arm64/kernel/head.o' being placed in section `.igot.plt'
>> >
>> > which looks unrelated to symbol_get(), but maybe it's worth knocking these
>> > things on the head (no pun intended) at the same time?
>> >
>>
>> Yeah, that is just one of those spurious sections that turns up empty
>> anyway. The head.o is a red herring, it is simply the first file
>> appearing in the link.
>>
>> This should fix it
>>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 6567d80dd15f..48b222f1c700 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -278,7 +278,7 @@ SECTIONS
>>          * explicitly check instead of blindly discarding.
>>          */
>>         .plt : {
>> -               *(.plt) *(.plt.*) *(.iplt) *(.igot)
>> +               *(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
>>         }
>>         ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure
>> linkages detected!")
>
>Cheers, that fixes the extra warning for me. If you could send a proper
>patch, I'm happy to queue as an arm64 fix! (I'm assuming the former is going
>via Jessica, but I can also take that with her Ack).

Hi! Yes, please feel free to take this patch along with the other fix:

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks,

Jessica

