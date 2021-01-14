Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B282F6C90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhANUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbhANUuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:50:21 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:49:40 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id t15so2204630ual.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pq7cIHZcRnyEqiZAtQ5+glIa6NXZ+uZ8K3ZIE+5W9aY=;
        b=GhZhw78kyiqN5427M/UlQlUjPPCcwDwZhik0FJTkREnaSjmPs4ivOX4iFfCgFXS1fy
         HhMYFjsimhEGNmQE0p3EXf0d+sbhNMmK/Vhpp5CcV18HfQBXKJ04KknoiDtrdDlPkMo3
         VoIlr3+puWaGsFZZurYT3+teW+GnqoVxkh/qFnEy/NBIGF3sZVbxOV1VJFl+OjMP3u+s
         DXzB2z1wsubdHPyiPId9VZe9fBRJ3DUSnXNZciffS02nuy7naD97qrcD/3YETeP4ZOcG
         jVQ/4u1C4+Vf6G4h+QJtJHj4AoKvi6F7PigsNUFOcfDcTvz/Q4YV0zKfsqFFJENS1/uw
         nKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pq7cIHZcRnyEqiZAtQ5+glIa6NXZ+uZ8K3ZIE+5W9aY=;
        b=FuB3GzvQp5yGGQNi+saH1TRD2e9/T3dL1OodtC8l5N7gxvNLhw0MmnOOOKgYDtag0w
         kwcNlPT0OTGG3sSiaDfFaKZeY2YUPWGQHlVIuCHrIoGzVjbf1TYobhQkFHF2/cAGNf81
         5v5XcLRYC9acU2cpEZTJgTEoN8lwwFGwLZ3KZBsAEVTXLRXWC4SiAfEny2axfGqJQbLk
         Qs6M7V9sHD+s/oXMyXEBuWvRiGwOB/81f1tP+4cKUbXz2PbhFoblsfB17g5oWkR0dAaa
         4W+b7hj1VFia0ntWAujiZdoudIAhA1Nu9hHqI5LtDpUAexux45IykzrfYGT8z9L3xvkN
         4aJA==
X-Gm-Message-State: AOAM533i/bbIfFDoRd2mNGLj9uhuP4M5aAlY8PtSPueOh9hsFhV0OVaj
        +EhAyXSiMj4S2uSEXDrrRavnywyMfrbb8wfw0FbBtw==
X-Google-Smtp-Source: ABdhPJzLGwThXcR0cc8svzN75QeI53/VXMWPaCoJyEcpbYephEdkm4nQ4BM1SR0r60eNEJm+IYlxFEjp0DsshOXUao4=
X-Received: by 2002:ab0:2388:: with SMTP id b8mr7503434uan.122.1610657379762;
 Thu, 14 Jan 2021 12:49:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <c1889131d5de558e58700ba559e7d8606fe9c680.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <c1889131d5de558e58700ba559e7d8606fe9c680.1610652862.git.jpoimboe@redhat.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Jan 2021 12:49:28 -0800
Message-ID: <CABCJKudFxiYbuHN+NVJ76QfHCky80nvsb_J08THmMmmHuy0vLA@mail.gmail.com>
Subject: Re: [PATCH 12/21] objtool: Add CONFIG_CFI_CLANG support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Thu, Jan 14, 2021 at 11:41 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> The upcoming CONFIG_CFI_CLANG support uses -fsanitize=cfi, the
> non-canonical version of which hijacks function entry by changing
> function relocation references to point to an intermediary jump table.
>
> For example:
>
>   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x37e018 contains 6 entries:
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  0002944700000002 R_X86_64_PC32          00000000000023f0 do_suspend_lowlevel + 0
>   0000000000000008  0003c11900000001 R_X86_64_64            0000000000000008 xen_cpuid$e69bc59f4fade3b6f2b579b3934137df.cfi_jt + 0
>   0000000000000010  0003980900000001 R_X86_64_64            0000000000000060 machine_real_restart.cfi_jt + 0
>   0000000000000018  0003962b00000001 R_X86_64_64            0000000000000e18 kretprobe_trampoline.cfi_jt + 0
>   0000000000000020  000028f300000001 R_X86_64_64            0000000000000000 .rodata + 12
>   0000000000000028  000349f400000001 R_X86_64_64            0000000000000018 __crash_kexec.cfi_jt + 0
>
>   0000000000000060 <machine_real_restart.cfi_jt>:
>     60: e9 00 00 00 00          jmpq   65 <machine_real_restart.cfi_jt+0x5>
>                         61: R_X86_64_PLT32      machine_real_restart-0x4
>     65: cc                      int3
>     66: cc                      int3
>     67: cc                      int3
>
> This breaks objtool vmlinux validation in many ways, including static
> call site detection and the STACK_FRAME_NON_STANDARD() macro.
>
> Fix it by converting those relocations' symbol references back to their
> original non-jump-table versions.  Note this doesn't change the actual
> relocations in the object itself, it just changes objtool's view of
> them.
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/elf.c | 28 ++++++++++++++++++++++++++++
>  tools/objtool/elf.h |  2 +-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 292f015f7ec6..e357dc34cd7a 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -382,6 +382,11 @@ static int read_sections(struct elf *elf)
>                 }
>                 sec->len = sec->sh.sh_size;
>
> +               /* Detect -fsanitize=cfi related sections */
> +               if (!strcmp(sec->name, ".text.__cfi_check") ||
> +                   !strncmp(sec->name, ".text..L.cfi.jumptable", 22))
> +                       sec->cfi_jt = true;
> +
>                 list_add_tail(&sec->list, &elf->sections);
>                 elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
>                 elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
> @@ -614,6 +619,29 @@ static int read_relocs(struct elf *elf)
>                                 return -1;
>                         }
>
> +                       /*
> +                        * Deal with -fsanitize=cfi (CONFIG_CFI_CLANG), which
> +                        * hijacks function entry by arbitrarily changing a lot
> +                        * of relocation symbol references to refer to an
> +                        * intermediate jump table.  Undo that conversion so
> +                        * objtool can make sense of things.
> +                        */
> +                       if (reloc->sym->sec->cfi_jt) {
> +                               struct symbol *func, *sym;
> +
> +                               if (sym->type == STT_SECTION)
> +                                       sym = find_func_by_offset(sym->sec,
> +                                                                 reloc->addend);

Clang points out that sym is uninitialized here. Should these be
reloc->sym instead?

Sami
