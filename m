Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE42D804C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394651AbgLKU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394525AbgLKU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:57:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8BBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:57:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f14so2783528pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3vq2jru/siTbZdWkGfGAc+yfoC9FslKe6Q/L8tWLHg=;
        b=Fqi9RxvvsiZktGp0UaHuozKSIRIA58jKmLbMYOczEN3mnG9rXh9+KLSGvUqATB5NzT
         Kn8BTLBYfkE1Aqg7zuH6bUEhyQ5zjPh8BC22NbNQ1gX4LlldB11jS2Hh/VilU23RSvuj
         AsxDQngk+JYBW9BY37DvQkSEVsHQX5Wx5fX0P/NNwdYB44jp7bvOQUQJTSgVGSpPgDc8
         NaEnvGFlFmBb7hezVFFu0YBALZIaiQsEB0lS1JFkYbo8VzO9kKBqOTQgGh/ZPuyFmt3z
         gMI0zsfeVNeszxrT6EHqPu8bWR1vnJb65H/koMJsu1M1XTscJpijUYrfxXkqnxXDs4fu
         kCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3vq2jru/siTbZdWkGfGAc+yfoC9FslKe6Q/L8tWLHg=;
        b=tI193oxDzAvcL9NcRqLv1dY4UUC05Fj9EF8uj7JrnO3GNNk/ipmUrzfS5xyG3bFOaZ
         IUrOypUAUS2bxNxUHwiUqZl95OF6QdNO/BuxWxUdPCfqvc9RkoYy1Rz+tLOWFIForPqo
         4ZAt3M0LuusTZ5Mu5OLLpnfRLkqlns1CXObtldLjHZ4Vp/xxdAunj2pzXnIcrKBQdgdN
         8mNyRM+uVLnwayI32MgtJcjbRqEutsszLuMqb+0R7kB4ZaLVYgpakp9vCLQ4kDYjloyU
         LfEnCsyr9pUYPFdwbY7eX3ApUjl6LsQugZXat8NXd9D9Nb+7qigLN23mSbaL1cAoVZAV
         Z5Yg==
X-Gm-Message-State: AOAM5302MrfProIHzoaNn3JmMhswAM1XJecuIFENhXYMqFY8hOAIFFMi
        2bKqh5jagEN4KjELSkjFPwuEBqKDxwN99bqpOFTz1Q==
X-Google-Smtp-Source: ABdhPJx+3/QjZgobzBpwwfcxt4lyc2XvSMsbXTI8KjhsZEO1VQ58awSp6IzdEwyeKg5dBcHAqDBfVeDmgWVn2BhRPwk=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr12754106plc.10.1607720232471; Fri, 11
 Dec 2020 12:57:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
 <20201211093205.GU2414@hirez.programming.kicks-ass.net> <20201211163748.b37gashl6an6misu@treble>
 <20201211164915.GA2414@hirez.programming.kicks-ass.net> <20201211174610.2bfprpvrrlg66awd@treble>
In-Reply-To: <20201211174610.2bfprpvrrlg66awd@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Dec 2020 12:57:00 -0800
Message-ID: <CAKwvOdkWU3qQ_m3v1xn1Mm6+obC202NWEaF8g_gz3oqeeLkMQA@mail.gmail.com>
Subject: Re: objtool crashes with some clang produced .o files
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Dec 11, 2020 at 05:49:15PM +0100, Peter Zijlstra wrote:
> > Do we want to capture all that gunk in something like
> > elf_reloc_to_insn(reloc, insn) instead of duplicating the magic?
>
> Yup, here's an actual patch
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] objtool: Support Clang non-section symbols in static call generation
>
> The Clang assembler likes to strip section symbols, which means you
> can't reference some text code by its section.  This confuses objtool
> greatly, causing it to seg fault.
>
> The fix is similar to what was done before, for ORC reloc generation:
>
>   e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")
>
> Factor out that code into a common helper and use it for static call
> reloc generation as well.
>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1207

> ---
>  tools/objtool/check.c   | 11 +++++++++--
>  tools/objtool/elf.c     | 26 ++++++++++++++++++++++++++
>  tools/objtool/elf.h     |  2 ++
>  tools/objtool/orc_gen.c | 29 +++++------------------------
>  4 files changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index c6ab44543c92..5f8d3eed78a1 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -467,13 +467,20 @@ static int create_static_call_sections(struct objtool_file *file)
>
>                 /* populate reloc for 'addr' */
>                 reloc = malloc(sizeof(*reloc));
> +
>                 if (!reloc) {
>                         perror("malloc");
>                         return -1;
>                 }
>                 memset(reloc, 0, sizeof(*reloc));
> -               reloc->sym = insn->sec->sym;
> -               reloc->addend = insn->offset;
> +
> +               insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
> +               if (!reloc->sym) {
> +                       WARN_FUNC("static call tramp: missing containing symbol",
> +                                 insn->sec, insn->offset);
> +                       return -1;
> +               }
> +
>                 reloc->type = R_X86_64_PC32;
>                 reloc->offset = idx * sizeof(struct static_call_site);
>                 reloc->sec = reloc_sec;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 4e1d7460574b..be89c741ba9a 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -262,6 +262,32 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
>         return find_reloc_by_dest_range(elf, sec, offset, 1);
>  }
>
> +void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
> +                             struct reloc *reloc)
> +{
> +       if (sec->sym) {
> +               reloc->sym = sec->sym;
> +               reloc->addend = offset;
> +               return;
> +       }
> +
> +       /*
> +        * The Clang assembler strips section symbols, so we have to reference
> +        * the function symbol instead:
> +        */
> +       reloc->sym = find_symbol_containing(sec, offset);
> +       if (!reloc->sym) {
> +               /*
> +                * Hack alert.  This happens when we need to reference the NOP
> +                * pad insn immediately after the function.
> +                */
> +               reloc->sym = find_symbol_containing(sec, offset - 1);
> +       }
> +
> +       if (reloc->sym)
> +               reloc->addend = offset - reloc->sym->offset;
> +}
> +
>  static int read_sections(struct elf *elf)
>  {
>         Elf_Scn *s = NULL;
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index 807f8c670097..e6890cc70a25 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -140,6 +140,8 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
>  struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
>                                      unsigned long offset, unsigned int len);
>  struct symbol *find_func_containing(struct section *sec, unsigned long offset);
> +void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
> +                             struct reloc *reloc);
>  int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
>
>  #define for_each_sec(file, sec)                                                \
> diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
> index 235663b96adc..9ce68b385a1b 100644
> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/orc_gen.c
> @@ -105,30 +105,11 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
>         }
>         memset(reloc, 0, sizeof(*reloc));
>
> -       if (insn_sec->sym) {
> -               reloc->sym = insn_sec->sym;
> -               reloc->addend = insn_off;
> -       } else {
> -               /*
> -                * The Clang assembler doesn't produce section symbols, so we
> -                * have to reference the function symbol instead:
> -                */
> -               reloc->sym = find_symbol_containing(insn_sec, insn_off);
> -               if (!reloc->sym) {
> -                       /*
> -                        * Hack alert.  This happens when we need to reference
> -                        * the NOP pad insn immediately after the function.
> -                        */
> -                       reloc->sym = find_symbol_containing(insn_sec,
> -                                                          insn_off - 1);
> -               }
> -               if (!reloc->sym) {
> -                       WARN("missing symbol for insn at offset 0x%lx\n",
> -                            insn_off);
> -                       return -1;
> -               }
> -
> -               reloc->addend = insn_off - reloc->sym->offset;
> +       insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
> +       if (!reloc->sym) {
> +               WARN("missing symbol for insn at offset 0x%lx",
> +                    insn_off);
> +               return -1;
>         }
>
>         reloc->type = R_X86_64_PC32;
> --
> 2.25.4
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201211174610.2bfprpvrrlg66awd%40treble.



-- 
Thanks,
~Nick Desaulniers
