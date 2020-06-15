Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0AE1F9493
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgFOK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 06:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgFOK05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:26:57 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362A620738;
        Mon, 15 Jun 2020 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592216816;
        bh=hyUqHVvXrvWswYdtXPunHqjbBKKNx9PKUnYIGDXg85Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dxZlvUL6DUxfzWe0YuM1i6dHK8Oh0IgZFJCsi2GQ4Ssj6mW4ylhE3CcvG9c4O4R28
         G7iat2uLRwcFzd3HB+Ox/FcVDIe2VJvc17Z9iQ4j7MkZz3PGWUN77FQXRSUodFFKRq
         rprI0FQQjr9e7YBnjXkN1Tt7qpKk7PwYAqY1jt8g=
Received: by mail-oi1-f172.google.com with SMTP id a3so15439700oid.4;
        Mon, 15 Jun 2020 03:26:56 -0700 (PDT)
X-Gm-Message-State: AOAM5306J15G22zR/p+/mD2cmadymmvD1jb2myyLzQHrW0q/Tg+/uteB
        EbfRo9BAhLnbKBweNRKV6me0CPInSxVg+JI6OAM=
X-Google-Smtp-Source: ABdhPJwFl0io0Eq+GPpq4WFiP9Xu+DdILz72bZT1brO1yijkO5duX1PIP3h6EN4mfEuni4hlMgQnqxUejHextMUFkNo=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr1896542oif.33.1592216815522;
 Mon, 15 Jun 2020 03:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200604022031.164207-1-masahiroy@kernel.org> <20200604022031.164207-2-masahiroy@kernel.org>
In-Reply-To: <20200604022031.164207-2-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 12:26:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHDFnhgsz4w+6DuwPxcSZ5P8o0rMzQ504Nt4i31MXwJQ@mail.gmail.com>
Message-ID: <CAMj1kXEHDFnhgsz4w+6DuwPxcSZ5P8o0rMzQ504Nt4i31MXwJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 04:20, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Documentation/kbuild/makefiles.rst says:
>
>   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
>
> This is because lib-y is inteded to be hooked to KBUILD_VMLINUX_LIBS,
> which is passed down to scripts/link-vmlinux.sh.
>
> Besides, lib-y is not so interesting because objects from lib-y are
> mostly linked in normal usecases. For example, lib-y only saves 364
> bytes for x86_64_defconfig. You can see the details in commit
> 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when
> CONFIG_MODULES=y").
>
> I think we should consider to deprecate lib-y syntax at some point
> because we should aim for better solution like dead code elimination
> or LTO.
>
> Other than lib/ and arch/*/lib, this Makefile is the only user of
> lib-y. Replace lib-y with a custom rule.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Series queued in efi/urgent.

Thanks

> ---
>
> Changes in v2:
>   - Add more description
>
>  drivers/firmware/efi/libstub/Makefile | 49 +++++++++++++++------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index cce4a7436052..7d81dc45cadf 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -44,7 +44,7 @@ OBJECT_FILES_NON_STANDARD     := y
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                        := n
>
> -lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> +stub-obj-y                     := efi-stub-helper.o gop.o secureboot.o tpm.o \
>                                    file.o mem.o random.o randomalloc.o pci.o \
>                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
>                                    alignedmem.o relocate.o vsprintf.o
> @@ -55,15 +55,19 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
>  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>         $(call if_changed_rule,cc_o_c)
>
> -lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o \
> +stub-obj-$(CONFIG_EFI_GENERIC_STUB)    += efi-stub.o fdt.o string.o \
>                                    $(patsubst %.c,lib-%.o,$(efi-deps-y))
>
> -lib-$(CONFIG_ARM)              += arm32-stub.o
> -lib-$(CONFIG_ARM64)            += arm64-stub.o
> -lib-$(CONFIG_X86)              += x86-stub.o
> +stub-obj-$(CONFIG_ARM)         += arm32-stub.o
> +stub-obj-$(CONFIG_ARM64)       += arm64-stub.o
> +stub-obj-$(CONFIG_X86)         += x86-stub.o
>  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
> +targets                                += $(stub-obj-y)
> +stub-obj-y                     := $(patsubst %.o,%.stub.o, $(stub-obj-y))
> +targets                                += $(stub-obj-y)
> +
>  #
>  # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
>  # .bss section, so the .bss section of the EFI stub needs to be included in the
> @@ -83,23 +87,6 @@ STUBCOPY_FLAGS-$(CONFIG_ARM) += --rename-section .data=.data.efistub \
>                                    --rename-section .bss=.bss.efistub,load,alloc
>  STUBCOPY_RELOC-$(CONFIG_ARM)   := R_ARM_ABS
>
> -#
> -# arm64 puts the stub in the kernel proper, which will unnecessarily retain all
> -# code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
> -# So let's apply the __init annotations at the section level, by prefixing
> -# the section names directly. This will ensure that even all the inline string
> -# literals are covered.
> -# The fact that the stub and the kernel proper are essentially the same binary
> -# also means that we need to be extra careful to make sure that the stub does
> -# not rely on any absolute symbol references, considering that the virtual
> -# kernel mapping that the linker uses is not active yet when the stub is
> -# executing. So build all C dependencies of the EFI stub into libstub, and do
> -# a verification pass to see if any absolute relocations exist in any of the
> -# object files.
> -#
> -extra-y                                := $(lib-y)
> -lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
> -
>  STUBCOPY_FLAGS-$(CONFIG_ARM64) += --prefix-alloc-sections=.init \
>                                    --prefix-symbols=__efistub_
>  STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS
> @@ -121,3 +108,21 @@ quiet_cmd_stubcopy = STUBCPY $@
>                 /bin/false;                                             \
>         fi;                                                             \
>         $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
> +
> +# arm64 puts the stub in the kernel proper, which will unnecessarily retain all
> +# code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
> +# So let's apply the __init annotations at the section level, by prefixing
> +# the section names directly. This will ensure that even all the inline string
> +# literals are covered.
> +# The fact that the stub and the kernel proper are essentially the same binary
> +# also means that we need to be extra careful to make sure that the stub does
> +# not rely on any absolute symbol references, considering that the virtual
> +# kernel mapping that the linker uses is not active yet when the stub is
> +# executing. So build all C dependencies of the EFI stub into libstub, and do
> +# a verification pass to see if any absolute relocations exist in any of the
> +# object files.
> +#
> +extra-y += lib.a
> +
> +$(obj)/lib.a: $(addprefix $(obj)/, $(stub-obj-y)) FORCE
> +       $(call if_changed,ar)
> --
> 2.25.1
>
