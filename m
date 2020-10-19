Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383FA293064
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbgJSVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732781AbgJSVVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:21:47 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43971222EA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 21:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603142506;
        bh=ZJMDnv4qHADP7o/gipyNZ2S4PzKH9+iQJj8yGSSMJp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NAyhLj8PqEDZQSND28ElW2AQhG4a/vhidbz+QeLz053/+UWKIQZ3YdpIz510RpEwZ
         ZgdE5aGm7JnMgFXQtK4ne0r0stuSh+WBKcEvkM1u4dc/CakL0rOsrSpyp17jmJMHV9
         kkmUnZwNvbDzSpiLWEoRdsFQEovbz3a2rOiNVMQM=
Received: by mail-ot1-f42.google.com with SMTP id n11so1214647ota.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:21:46 -0700 (PDT)
X-Gm-Message-State: AOAM530mMJDxQ9FJLw5apFkWGoxMEBk9u+56F3amPUOEtGKDxShjR3uN
        BIRos/k+coo/hTHzJz8GQz48sSoPlxLtfAgAnC8=
X-Google-Smtp-Source: ABdhPJwbKJobujQu52K5M/SZf3kldBgPcVC3FStTg+cQ18060Xt6gbZHvWXYeCaF9ftUU6kIxee2pZ3r7qlkg3E7EXY=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr1307985ots.90.1603142505389;
 Mon, 19 Oct 2020 14:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCUJBCLdFRNPNi1z+F5-cfbu8sPOrvG8LVn5GQRepxHrBDA@mail.gmail.com>
 <mhng-02f9ec68-743e-45d3-96a9-8675c7e1147b@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-02f9ec68-743e-45d3-96a9-8675c7e1147b@palmerdabbelt-glaptop1>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Oct 2020 23:21:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsguWaxqOVDuD0PTSW0+dJPcEaJOMEcPRB86ORA_ggeg@mail.gmail.com>
Message-ID: <CAMj1kXHsguWaxqOVDuD0PTSW0+dJPcEaJOMEcPRB86ORA_ggeg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.10 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 at 23:00, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 19 Oct 2020 13:43:27 PDT (-0700), atishp@atishpatra.org wrote:
> > On Mon, Oct 19, 2020 at 12:08 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:
> >>
> >>   Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-mw0
> >>
> >> for you to fetch changes up to de22d2107ced3cc5355cc9dbbd85e44183546bd5:
> >>
> >>   RISC-V: Add page table dump support for uefi (2020-10-02 14:31:33 -0700)
> >>
> >> ----------------------------------------------------------------
> >> RISC-V Patches for the 5.10 Merge Window, Part 1
> >>
> >> This contains a handful of cleanups and new features, including:
> >>
> >> * A handful of cleanups for our page fault handling.
> >> * Improvements to how we fill out cacheinfo.
> >> * Support for EFI-based systems.
> >>
> >> ---
> >>
> >> This contains a merge from the EFI tree that was necessary as some of the EFI
> >> support landed over there.  It's my first time doing something like this,
> >>
> >> I haven't included the set_fs stuff because the base branch it depends on
> >> hasn't been merged yet.  I'll probably have another merge window PR, as
> >> there's more in flight (most notably the fix for new binutils I just sent out),
> >> but I figured there was no reason to delay this any longer.
> >>
> >> There is one merge conflict, which is between my fixes and for-next branches:
> >>
> >>     diff --cc arch/riscv/kernel/vmlinux.lds.S
> >>     index 67db80e12d1f,9795359cb9da..ffaa3da375c2
> >>     --- a/arch/riscv/kernel/vmlinux.lds.S
> >>     +++ b/arch/riscv/kernel/vmlinux.lds.S
> >>     @@@ -66,8 -71,11 +70,13 @@@ SECTION
> >>                     _etext = .;
> >>             }
> >>
> >>      +      INIT_DATA_SECTION(16)
> >>      +
> >>     + #ifdef CONFIG_EFI
> >>     +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
> >>     +       __pecoff_text_end = .;
> >>     + #endif
> >>     +
> >>             /* Start of data section */
> >>             _sdata = .;
> >>             RO_DATA(SECTION_ALIGN)
> >>
> >> ----------------------------------------------------------------
> >> Anup Patel (1):
> >>       RISC-V: Move DT mapping outof fixmap
> >>
> >> Ard Biesheuvel (3):
> >>       efi/libstub: arm32: Base FDT and initrd placement on image address
> >>       efi/libstub: Export efi_low_alloc_above() to other units
> >>       efi/libstub: arm32: Use low allocation for the uncompressed kernel
> >>
> >
> > I thought these 3 were being taken through the EFI tree. I already see
> > them in the master branch.
> >
> > 762cd288fc4a efi/libstub: arm32: Use low allocation for the uncompressed kernel
> > 1a895dbf4b66 efi/libstub: Export efi_low_alloc_above() to other units
> > 6208857b8f7e efi/libstub: arm32: Base FDT and initrd placement on image address
>
> I see them in Linus' master with those exact hashes, so IIUC this is all OK?  I
> guess I just assumed they were supposed to show up in the shortlog, but it's my
> first time trying one of these multi-tree merges so maybe I screwed something
> up?
>
> I obtained these by merging a tag from the EFI tree (that's already been
> merged) into my tree, which looks OK to me:
>
>     commit 8a3f30c4319dc70547f11c18da2e7b5987543aa1
>     gpg: Signature made Fri 02 Oct 2020 02:30:05 PM PDT
>     gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
>     gpg:                issuer "palmer@dabbelt.com"
>     gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
>     gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" [ultimate]
>     merged tag 'efi-riscv-shared-for-v5.10'
>     gpg: Signature made Wed 16 Sep 2020 08:57:07 AM PDT
>     gpg:                using RSA key 9CD2A0DA6AD8F7330175E2BBC237207E9574FA7D
>     gpg: Good signature from "Adriaan (Ard) Biesheuvel <ard.biesheuvel@linaro.org>" [unknown]
>     gpg:                 aka "Adriaan (Ard) Biesheuvel <ard.biesheuvel@gmail.com>" [unknown]
>     gpg:                 aka "Adriaan (Ard) Biesheuvel <ardb@kernel.org>" [unknown]
>     gpg:                 aka "Adriaan (Ard) Biesheuvel <ard.biesheuvel@arm.com>" [unknown]
>     gpg: WARNING: This key is not certified with a trusted signature!
>     gpg:          There is no indication that the signature belongs to the owner.
>     Primary key fingerprint: F43D 0332 8115 A198 C900  1688 3D20 0E9C A632 9909
>          Subkey fingerprint: 9CD2 A0DA 6AD8 F733 0175  E2BB C237 207E 9574 FA7D
>     Merge: 54701a0d12e2 762cd288fc4a
>     Author: Palmer Dabbelt <palmerdabbelt@google.com>
>     Date:   Fri Oct 2 14:29:51 2020 -0700
>
>         Merge tag 'efi-riscv-shared-for-v5.10' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/efi/efi into for-next
>
>         Stable branch for v5.10 shared between the EFI and RISC-V trees
>
>         The RISC-V EFI boot and runtime support will be merged for v5.10 via
>         the RISC-V tree. However, it incorporates some changes that conflict
>         with other EFI changes that are in flight, so this tag serves as a
>         shared base that allows those conflicts to be resolved beforehand.
>
>         * tag 'efi-riscv-shared-for-v5.10' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/efi/efi:
>           efi/libstub: arm32: Use low allocation for the uncompressed kernel
>           efi/libstub: Export efi_low_alloc_above() to other units
>           efi/libstub: arm32: Base FDT and initrd placement on image address
>           efi: Rename arm-init to efi-init common for all arch
>           include: pe.h: Add RISC-V related PE definition
>
> I think the actual issue here is just that whatever I pointed git to when
> generating the PR didn't contain the merge of the shared code yet, so
> git-shortlog included it?
>

This all looks fine. Usually in such cases, you don't know which
branch will gets pulled first, so it makes sense for each PR to
describe the shared changes.
