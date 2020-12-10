Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAAC2D6BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394381AbgLJXg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgLJXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:36:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51EC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:35:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e2so5796269pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zotw90XLqcDkM4QBjrD8+g+RUBTvH9SBYxyWQvLQNY=;
        b=d7fqM8sMRj4Y2nHfTSo4avhmT+Z9sc2UnKRD/eMrieWyZ68hQVnz9TXCk5xq8YOY14
         00pxd/qvw500C0++WshW8hXrTG7ChOiLyc+FuvVTU6ZJxsjPQXJ29oDbYPAiKfVZOofz
         rnZvo4oSC8jwDFccE1ZeCrUCGrKmrO/dOQn31VdA33xFWnPN6VMNwRBqcom7v/9kwdOt
         TYWkRZA/oTmLYkuQ5yHbYQ1EOKn/AwzEXVLbkfbMZqOi9BofM5ySw5Mu9wjw5K+gvNgc
         9ugAJswB+sLo+hNVrbr4yFNE+b40lVrI3qeJqzFH58W8nQ21rfsECPoM2qxVIGzmwDFl
         RdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zotw90XLqcDkM4QBjrD8+g+RUBTvH9SBYxyWQvLQNY=;
        b=oAYUSMBN+sm+f7lX5nyVRQuhENwZRzvQ2vNzd/bxpFkOyBBRCCmnSexU9gGoGNT1VA
         eTuqwv35y9O11uiQMFuyIcsqM7xuiwGYz/uNtkCFfafPQBEkU/5gOgaR5bwZqdIro8dv
         prLlTmCtSHMUbzoS/lBiJKrU+elyVWbR42LyHYD4k65kmWK52jkm1PoFc5Qfq8y6mTGm
         Gpstttsg4BbdlqkJYmB++KMkJiQhzkWYTDAxTtFdxA8HhFrlJap7dhboZ4Zl6nQuCGyz
         pxDGzh5YVRtx1NaZV57R4VESobsf5GmAfOQxZ/mg9JMNXuvamOeLm7ZF1/jkyJPkJauf
         ReEg==
X-Gm-Message-State: AOAM531J50O8omCwwiMLdk/s5YEykOrnYQ/BWiX67pRUAxjH35DpRp44
        JZvnCybnGqekpgOI8wMrFQB8TgPDrS1W95cTx1p5ksjtxtRQzQ==
X-Google-Smtp-Source: ABdhPJxEdjKKAZ+bVgMtm0H8TmCVntHvk0RawKGJmR+5n7hNjZnY+AS5Da8zSrZn4O6N3h1j+TcIvBA1/03dhta5PKg=
X-Received: by 2002:aa7:80c9:0:b029:197:6775:4a5b with SMTP id
 a9-20020aa780c90000b029019767754a5bmr8905715pfn.36.1607643357664; Thu, 10 Dec
 2020 15:35:57 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
In-Reply-To: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Dec 2020 15:35:45 -0800
Message-ID: <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
Subject: Re: objtool crashes with some clang produced .o files
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 5:56 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I see occasional randconfig builds failing on x86 with clang-11
> and clang-12 when objtool crashes with a segmentation fault.
>
> The simplest test case I managed to create is
>
> $ echo "__SCK__tp_func_cdev_update() { __SCT__tp_func_cdev_update(); }" > file.c
> $ clang-12 -c file.c -O2 -fno-asynchronous-unwind-tables
> $ ./tools/objtool/objtool orc generate  file.o
> Segmentation fault (core dumped)
> $ clang-12 -S file.c -O2 -fno-asynchronous-unwind-tables -o-
> .text
> .file "file.c"
> .globl __SCK__tp_func_cdev_update      # -- Begin function
> __SCK__tp_func_cdev_update
> .p2align 4, 0x90
> .type __SCK__tp_func_cdev_update,@function
> __SCK__tp_func_cdev_update:             # @__SCK__tp_func_cdev_update
> # %bb.0:
> xorl %eax, %eax
> jmp __SCT__tp_func_cdev_update      # TAILCALL
> .Lfunc_end0:
> .size __SCK__tp_func_cdev_update, .Lfunc_end0-__SCK__tp_func_cdev_update
>                                         # -- End function
> .ident "Ubuntu clang version
> 12.0.0-++20201129052612+ce134da4b18-1~exp1~20201129163253.238"
> .section ".note.GNU-stack","",@progbits
> .addrsig
>
> The behavior seems to depend on the specific symbol names, and it only happens
> for the integrated assembler, not the GNU assembler.
>
> Attaching both .o files for reference.

Thanks for the report.

(gdb) r orc generate file.o
Starting program: /android0/linux-next/tools/objtool/objtool orc generate file.o

Program received signal SIGSEGV, Segmentation fault.
0x000000000040d7d3 in elf_rebuild_rela_reloc_section (sec=0xc24e30,
nr=<optimized out>) at elf.c:880
880                     relocs[idx].r_info =
GELF_R_INFO(reloc->sym->idx, reloc->type);
(gdb) bt
#0  0x000000000040d7d3 in elf_rebuild_rela_reloc_section
(sec=0xc24e30, nr=<optimized out>) at elf.c:880
#1  elf_rebuild_reloc_section (elf=<optimized out>,
sec=sec@entry=0xc24e30) at elf.c:901
#2  0x00000000004049b6 in create_static_call_sections (file=0x41f478
<file>) at check.c:520
#3  check (file=0x41f478 <file>) at check.c:2918
#4  0x000000000040b97c in cmd_orc (argc=<optimized out>,
argv=0x7fffffffda98) at builtin-orc.c:47
#5  0x000000000040dce9 in handle_internal_command (argc=argc@entry=3,
argv=argv@entry=0x7fffffffda90) at objtool.c:128
#6  0x000000000040dbff in main (argc=3, argv=0x7fffffffda90) at objtool.c:151
(gdb) p reloc
$1 = (struct reloc *) 0xc24fd0
(gdb) p *reloc
$2 = {list = {next = 0xc25070, prev = 0xc24eb8}, hash = {next = 0x0,
pprev = 0xc25080}, {rela = {r_offset = 0, r_info = 0, r_addend = 0},
rel = {r_offset = 0, r_info = 0}},
  sec = 0xc24e30, sym = 0x0, offset = 0, type = 2, addend = 2, idx =
0, jump_table_start = false}

So reloc->sym was NULL.

(gdb) p *sec
$2 = {list = {next = 0x7ffff559e068, prev = 0xc23bf0}, hash = {next =
0x0, pprev = 0x7ffff65d60d8}, name_hash = {next = 0x0, pprev =
0x7ffff6dd6888}, sh = {sh_name = 147, sh_type = 4,
    sh_flags = 64, sh_addr = 0, sh_offset = 0, sh_size = 48, sh_link =
7, sh_info = 8, sh_addralign = 8, sh_entsize = 24}, symbol_tree =
{rb_node = 0x0}, symbol_list = {next = 0xc24ea8,
    prev = 0xc24ea8}, reloc_list = {next = 0xc24fd0, prev = 0xc25070},
base = 0xc23bf0, reloc = 0x0, sym = 0x0, data = 0xc23db0, name =
0xc24f60 ".rela.static_call_sites", idx = 9,
  len = 0, changed = true, text = false, rodata = false, noinstr = false}

So .rela.static_call_sites was the problematic section.

(gdb) b tools/objtool/check.c:475
(gdb) r orc generate file.o
Breakpoint 1, create_static_call_sections (file=0x41f478 <file>) at check.c:475
475                     reloc->sym = insn->sec->sym;
(gdb) p insn->sec->sym
$4 = (struct symbol *) 0x0
(gdb) p insn->sec->name
$5 = 0xc22d26 ".text"

So some instruction in .text that contained a relocation for, we could
not determine a symbol for?  I'm curious why we're even in this loop
though, since we didn't do anything related to static calls...is
`file->static_call_list` not populated correctly? Is the final else
case from `add_jump_destinations` perhaps being hit and adding nodes
to file->static_call_list incorrectly?
-- 
Thanks,
~Nick Desaulniers
