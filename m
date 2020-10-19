Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA0F292F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgJSUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgJSUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:43:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:43:39 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so1449813iow.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxXdQXPWOcsFCnbTGx9EElxEZnBvrgFn7oXweVU7M5o=;
        b=QuEx1G6nKfqlkG0PV9dk+cAaJ5tUlv8Tm1ya9kbeOzgpPQKCe+cXi9PQPhdl4wgE17
         1UMXeEh790Bh1spFZNLlfgI/FXqsccxQIB+RbH/GxrOygQ0VfRSz+10w9oFcY7RZSMic
         MGmALs4Yw3cHTeg0EJ5xdRSXs3tOJJQl3tvhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxXdQXPWOcsFCnbTGx9EElxEZnBvrgFn7oXweVU7M5o=;
        b=nua/4vVlnEh2kep0Bub3Txt0riwY9Hj6EHCJN10zQ3M2XjCutHwSBcMNh5CCAWqu5T
         pboVRjY1JD/v2Pg1M7F6blpVgOZZt21lJ1QNbQAX4bJl9u5eU+97MFopyvPh80piAS9I
         21joDqANo8omR28sewIdbL461w9e+5qhdN5mpmN6wOJtLNh7Lk2LiLcWG7xweDrshsyE
         0siLBLpW7OiGsrAlv98lOM8ftDZ6PzcLADqMpff/7Fp+KBUiE7mqdfEV7Y2UVMSPWKPs
         //16VKLaNE4KlQ9UiwF2NCerdFaiVKsGBQPyEm7KC3zbVj4yU50O9Nlj6gAsj3tbc7OL
         wLcA==
X-Gm-Message-State: AOAM5323eUO51yiMGqqjPiskaJVvfrR6vHmMKeUlJxDf8+2KYSsehQlB
        3rURmFXON8BhVXjFTfmBUpl5+y4kVwWxr77g6BQmmzwTisokLGM=
X-Google-Smtp-Source: ABdhPJzpGpxdbSGAaNsD4zYRzRS8JDhm1+aQU4p2IlCmHvTGvkvCSSG9PRFGHQvUWeauCPnyiGJoYykoZZgtfrPGcak=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr1068682ios.113.1603140219104;
 Mon, 19 Oct 2020 13:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-a46615be-f4b5-4861-81b2-f370964a9583@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 19 Oct 2020 13:43:27 -0700
Message-ID: <CAOnJCUJBCLdFRNPNi1z+F5-cfbu8sPOrvG8LVn5GQRepxHrBDA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:08 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:
>
>   Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw0
>
> for you to fetch changes up to de22d2107ced3cc5355cc9dbbd85e44183546bd5:
>
>   RISC-V: Add page table dump support for uefi (2020-10-02 14:31:33 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.10 Merge Window, Part 1
>
> This contains a handful of cleanups and new features, including:
>
> * A handful of cleanups for our page fault handling.
> * Improvements to how we fill out cacheinfo.
> * Support for EFI-based systems.
>
> ---
>
> This contains a merge from the EFI tree that was necessary as some of the EFI
> support landed over there.  It's my first time doing something like this,
>
> I haven't included the set_fs stuff because the base branch it depends on
> hasn't been merged yet.  I'll probably have another merge window PR, as
> there's more in flight (most notably the fix for new binutils I just sent out),
> but I figured there was no reason to delay this any longer.
>
> There is one merge conflict, which is between my fixes and for-next branches:
>
>     diff --cc arch/riscv/kernel/vmlinux.lds.S
>     index 67db80e12d1f,9795359cb9da..ffaa3da375c2
>     --- a/arch/riscv/kernel/vmlinux.lds.S
>     +++ b/arch/riscv/kernel/vmlinux.lds.S
>     @@@ -66,8 -71,11 +70,13 @@@ SECTION
>                     _etext = .;
>             }
>
>      +      INIT_DATA_SECTION(16)
>      +
>     + #ifdef CONFIG_EFI
>     +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
>     +       __pecoff_text_end = .;
>     + #endif
>     +
>             /* Start of data section */
>             _sdata = .;
>             RO_DATA(SECTION_ALIGN)
>
> ----------------------------------------------------------------
> Anup Patel (1):
>       RISC-V: Move DT mapping outof fixmap
>
> Ard Biesheuvel (3):
>       efi/libstub: arm32: Base FDT and initrd placement on image address
>       efi/libstub: Export efi_low_alloc_above() to other units
>       efi/libstub: arm32: Use low allocation for the uncompressed kernel
>

I thought these 3 were being taken through the EFI tree. I already see
them in the master branch.

762cd288fc4a efi/libstub: arm32: Use low allocation for the uncompressed kernel
1a895dbf4b66 efi/libstub: Export efi_low_alloc_above() to other units
6208857b8f7e efi/libstub: arm32: Base FDT and initrd placement on image address

> Atish Patra (8):
>       include: pe.h: Add RISC-V related PE definition
>       efi: Rename arm-init to efi-init common for all arch
>       RISC-V: Add early ioremap support
>       RISC-V: Implement late mapping page table allocation functions
>       RISC-V: Add PE/COFF header for EFI stub
>       RISC-V: Add EFI stub support.
>       RISC-V: Add EFI runtime services
>       RISC-V: Add page table dump support for uefi
>
> Palmer Dabbelt (1):
>       Merge tag 'efi-riscv-shared-for-v5.10' of ssh://gitolite.kernel.org/.../efi/efi into for-next
>
> Pekka Enberg (11):
>       riscv/mm: Simplify retry logic in do_page_fault()
>       riscv/mm/fault: Move no context handling to no_context()
>       riscv/mm/fault: Move bad area handling to bad_area()
>       riscv/mm/fault: Move vmalloc fault handling to vmalloc_fault()
>       riscv/mm/fault: Simplify fault error handling
>       riscv/mm/fault: Move fault error handling to mm_fault_error()
>       riscv/mm/fault: Simplify mm_fault_error()
>       riscv/mm/fault: Move FAULT_FLAG_WRITE handling in do_page_fault()
>       riscv/mm/fault: Move access error check to function
>       riscv/mm/fault: Fix inline placement in vmalloc_fault() declaration
>       riscv/mm/fault: Set FAULT_FLAG_INSTRUCTION flag in do_page_fault()
>
> Tian Tao (1):
>       RISC-V: Fix duplicate included thread_info.h
>
> Zong Li (3):
>       riscv: Set more data to cacheinfo
>       riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
>       riscv: Add cache information in AUX vector
>
>  arch/arm/include/asm/efi.h                      |  23 +-
>  arch/arm64/include/asm/efi.h                    |   5 +-
>  arch/riscv/Kconfig                              |  25 ++
>  arch/riscv/Makefile                             |   1 +
>  arch/riscv/configs/defconfig                    |   1 +
>  arch/riscv/include/asm/Kbuild                   |   1 +
>  arch/riscv/include/asm/cacheinfo.h              |   5 +
>  arch/riscv/include/asm/efi.h                    |  55 ++++
>  arch/riscv/include/asm/elf.h                    |  13 +
>  arch/riscv/include/asm/fixmap.h                 |  16 +-
>  arch/riscv/include/asm/io.h                     |   1 +
>  arch/riscv/include/asm/mmu.h                    |   2 +
>  arch/riscv/include/asm/pgtable.h                |   5 +
>  arch/riscv/include/asm/sections.h               |  13 +
>  arch/riscv/include/uapi/asm/auxvec.h            |  24 ++
>  arch/riscv/kernel/Makefile                      |   2 +
>  arch/riscv/kernel/cacheinfo.c                   |  98 +++++--
>  arch/riscv/kernel/efi-header.S                  | 111 ++++++++
>  arch/riscv/kernel/efi.c                         |  96 +++++++
>  arch/riscv/kernel/head.S                        |  18 +-
>  arch/riscv/kernel/head.h                        |   2 -
>  arch/riscv/kernel/image-vars.h                  |  51 ++++
>  arch/riscv/kernel/setup.c                       |  18 +-
>  arch/riscv/kernel/vmlinux.lds.S                 |  23 +-
>  arch/riscv/mm/fault.c                           | 356 +++++++++++++-----------
>  arch/riscv/mm/init.c                            | 191 ++++++++++---
>  arch/riscv/mm/ptdump.c                          |  48 +++-
>  drivers/firmware/efi/Kconfig                    |   3 +-
>  drivers/firmware/efi/Makefile                   |   4 +-
>  drivers/firmware/efi/{arm-init.c => efi-init.c} |   0
>  drivers/firmware/efi/libstub/Makefile           |  10 +
>  drivers/firmware/efi/libstub/arm32-stub.c       | 178 +++---------
>  drivers/firmware/efi/libstub/arm64-stub.c       |   1 -
>  drivers/firmware/efi/libstub/efi-stub.c         |  59 +---
>  drivers/firmware/efi/libstub/efistub.h          |   7 +-
>  drivers/firmware/efi/libstub/relocate.c         |   4 +-
>  drivers/firmware/efi/libstub/riscv-stub.c       | 109 ++++++++
>  drivers/firmware/efi/riscv-runtime.c            | 143 ++++++++++
>  include/linux/pe.h                              |   3 +
>  39 files changed, 1275 insertions(+), 450 deletions(-)
>  create mode 100644 arch/riscv/include/asm/efi.h
>  create mode 100644 arch/riscv/include/asm/sections.h
>  create mode 100644 arch/riscv/kernel/efi-header.S
>  create mode 100644 arch/riscv/kernel/efi.c
>  create mode 100644 arch/riscv/kernel/image-vars.h
>  rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
>  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>  create mode 100644 drivers/firmware/efi/riscv-runtime.c
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
