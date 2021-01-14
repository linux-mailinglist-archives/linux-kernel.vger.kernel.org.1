Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34E2F6D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbhANVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbhANVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:31:10 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:30:30 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id w18so14241840iot.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/5OcUCXKSVoXp2v9h0odUus7RHd5rJAYMLUHH9GNUHY=;
        b=QSjKT2f9NWqEKRbvjrgxvGA56mByg/7zVWgvVwzwi/X74FTv8mAkUgn90qtczfwWY5
         WBX6QcV6oYGTzmwFMOrcdGsNRzjv812X27k++twQ6cTVp9kGGjZFIgyDqQUjhMmJP7yZ
         mM1kEHqgJldxmjSwtsYMNYxbibwi7Mk1+mX4YyHX2t32cz1RCcGKYEjFR8MdqDWMggyX
         DaRCnFYPCMuBeir8xjYxvDipNswWZa7Z8/RrhG7DrfPJhvERNLSDQOMSqaVFqiXTcl20
         ru6qNKN/14St1Gsrf0EFgNOCZoz38ICx8Q6Cx7eR0q9jSpgcge6TaSRvmuuMR9Ig1Rhn
         eHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/5OcUCXKSVoXp2v9h0odUus7RHd5rJAYMLUHH9GNUHY=;
        b=cp9Vn/V1h7mA0LjEdGHn84FiXDECdh4PdHHTnuqXjafEMpbFwzIN82wgZMIRpHJ7w4
         8PaKFUkR6O6uXx845umOarq+b69dKVdSog71e9mHZAJtG8pVA8Eu0heF9Pd3dpcLhlUv
         SH36wtJePf5KUpSx9mbwObJjzZhFbaVtOZl/nQDLDV0szDtLlB1FQLbBl3F5qcJKdgBw
         g0lz2JzfzWqrZnYTuxeFAjmN0DYm5bzYsxAukZBH9dLfAbAZJvNYUfZ/GGQ1/3DTe4gK
         OrIBwNBd8kkg2FvD/xYElar2rs3ij4m9YawDVGZOreaPGM/AEl0zE7x/4z8uy0dNnpy6
         sS3w==
X-Gm-Message-State: AOAM530XJpf/rY/wf4nD9gL4C9oS/iM5/D4Ilvs0X1kAINhSHG2JFsoh
        aES3TUEqpMr0kPFOmwjdNeBWIj1EX4qZbGGgxgA=
X-Google-Smtp-Source: ABdhPJyPsr4Y471JaNcbLsxuJbnXyNSJoyRTIavVReVD1AZIjz56XC1kDEeaZkMCm7w1GZ5TobGDURpmcC+r+xWBDAI=
X-Received: by 2002:a92:c692:: with SMTP id o18mr8526362ilg.215.1610659829438;
 Thu, 14 Jan 2021 13:30:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <37e341c0f4522656a6320528f0aacb0cb7ff0034.1610652862.git.jpoimboe@redhat.com>
 <20210114205544.ehynfby5tummams5@treble>
In-Reply-To: <20210114205544.ehynfby5tummams5@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 22:30:18 +0100
Message-ID: <CA+icZUV2BWt=Q4Z0+4xXYkfQ9DRicNrjKkX6wP60Zf1+dwxGaw@mail.gmail.com>
Subject: Re: [PATCH v1.1 11/21] objtool: Move unsuffixed symbol conversion to
 a helper function
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 9:55 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> This logic will also be needed for the CONFIG_CFI_CLANG support.
>

Good you fixed that in v2.
I re-pulled from [1].

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux

> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/elf.c | 60 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index be89c741ba9a..6d248a19e2c6 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -262,6 +262,38 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
>         return find_reloc_by_dest_range(elf, sec, offset, 1);
>  }
>
> +static int find_unsuffixed_func(const struct elf *elf, struct symbol *sym,
> +                               const char *suffix, struct symbol **func)
> +{
> +       char name[MAX_NAME_LEN + 1];
> +       const char *loc;
> +       size_t len;
> +
> +       *func = NULL;
> +
> +       loc = strstr(sym->name, suffix);
> +       if (!loc)
> +               return 0;
> +
> +       len = loc - sym->name;
> +       if (len > MAX_NAME_LEN) {
> +               WARN("%s(): unsuffixed function name exceeds maximum length of %d characters",
> +                    sym->name, MAX_NAME_LEN);
> +               return -1;
> +       }
> +
> +       strncpy(name, sym->name, len);
> +       name[len] = '\0';
> +
> +       *func = find_symbol_by_name(elf, name);
> +       if (!*func || (*func)->type != STT_FUNC) {
> +               WARN("%s(): can't find unsuffixed function", sym->name);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
>                               struct reloc *reloc)
>  {
> @@ -374,7 +406,6 @@ static int read_symbols(struct elf *elf)
>         struct list_head *entry;
>         struct rb_node *pnode;
>         int symbols_nr, i;
> -       char *coldstr;
>         Elf_Data *shndx_data = NULL;
>         Elf32_Word shndx;
>
> @@ -456,37 +487,20 @@ static int read_symbols(struct elf *elf)
>         /* Create parent/child links for any cold subfunctions */
>         list_for_each_entry(sec, &elf->sections, list) {
>                 list_for_each_entry(sym, &sec->symbol_list, list) {
> -                       char pname[MAX_NAME_LEN + 1];
> -                       size_t pnamelen;
>                         if (sym->type != STT_FUNC)
>                                 continue;
>
> -                       if (sym->pfunc == NULL)
> +                       if (!sym->pfunc)
>                                 sym->pfunc = sym;
>
> -                       if (sym->cfunc == NULL)
> +                       if (!sym->cfunc)
>                                 sym->cfunc = sym;
>
> -                       coldstr = strstr(sym->name, ".cold");
> -                       if (!coldstr)
> -                               continue;
> -
> -                       pnamelen = coldstr - sym->name;
> -                       if (pnamelen > MAX_NAME_LEN) {
> -                               WARN("%s(): parent function name exceeds maximum length of %d characters",
> -                                    sym->name, MAX_NAME_LEN);
> +                       if (find_unsuffixed_func(elf, sym, ".cold", &pfunc))
>                                 return -1;
> -                       }
>
> -                       strncpy(pname, sym->name, pnamelen);
> -                       pname[pnamelen] = '\0';
> -                       pfunc = find_symbol_by_name(elf, pname);
> -
> -                       if (!pfunc) {
> -                               WARN("%s(): can't find parent function",
> -                                    sym->name);
> -                               return -1;
> -                       }
> +                       if (!pfunc)
> +                               continue;
>
>                         sym->pfunc = pfunc;
>                         pfunc->cfunc = sym;
> --
> 2.29.2
>
