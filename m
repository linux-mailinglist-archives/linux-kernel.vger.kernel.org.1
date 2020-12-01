Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7412CACE9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404418AbgLAUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbgLAUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:00:49 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB38C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:00:02 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so1842709pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ST3hE6QaFWUSPeZl1LBt0eW3vQwZ9yVBdwV//6AR6/I=;
        b=tTFhE9yucwXpEbXArqdu5e0G5AOiVGEvMzt8YWOOiUUKtoHYWgJJLe440MBG/4n9PO
         c9NxWy89yvvJKkFcNm5m6bqmLLVW+Dn+QHOWfVZteG3hjhJQ4sdV0ttcjKNLfviy4dNc
         LkT4sB5EOqHc82aRWzNI2z4v0eJhzRJJoHGzRxWAYm5J0rohxEaU/tyk9TLVdbqOeq5U
         Xl/VqJ7DT+hug7YyONQa+IHWKwdPJ1rIO53UgoKS+X7HakK4KrnXC8Iw8tFIJ39tKSSg
         n4/iI+ArX0jP7DByG/OgfuXiuVlu9fYL0pTXFZD3qgbFc5/8XSd9DsCPJbPi07zIUX2k
         CKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ST3hE6QaFWUSPeZl1LBt0eW3vQwZ9yVBdwV//6AR6/I=;
        b=BU2aYvr3E7Bhaf9jzKkU889Dk3ORjOkMzgRFRBCbwoWBxCs7EeH81PNt1RQwWycrSs
         3UcCS8anT21q3QE9D/MPtLSOlZWFMMMptrmuIX+fdn50iRBiqZnJPE5r231YxD5K+1cL
         0pGhiD6QFfdztrRQAsav+AYHJopQZ6dsmSEUun8zrCCdlfK5tbaKFl3ApH3K6ZZf5V4E
         Nz6SRDqUb0RkUqlHgwNzbbfa6rSWWJ1of453kCoqI215kGEsvBoTjGxyhQ2UXfJXhWek
         M+OxwHnDWZEWBBv0jWGHBqD35chF/5U1XRkiQ49P+mBe2cXHv/lq2gZh9yfd70sulafl
         XPxA==
X-Gm-Message-State: AOAM532ZfwjzabC9ttdiCdAP7ORgN3GJKeAc1XQwUHEp7748lh3QfZ1K
        5QBLjtbSsGqXdRtKTHaMJcK9aYdS5Dqi351cl50JMQ==
X-Google-Smtp-Source: ABdhPJzQ1vMWE1DakWfjk+EGUlCZz1KA03oSrNdOmo+ATxl/T+qq1c21Zsng9mF8AijIOoMwTv9nTow9N6tEcL4EGiw=
X-Received: by 2002:a63:3247:: with SMTP id y68mr3731226pgy.10.1606852802273;
 Tue, 01 Dec 2020 12:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com>
In-Reply-To: <20201201152017.3576951-1-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Dec 2020 11:59:50 -0800
Message-ID: <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 7:21 AM Marco Elver <elver@google.com> wrote:
>
> The C11 _Static_assert() keyword may be used at module scope, and we
> need to teach genksyms about it to not abort with an error. We currently
> have a growing number of static_assert() (but also direct usage of
> _Static_assert()) users at module scope:
>
>         git grep -E '^_Static_assert\(|^static_assert\(' | grep -v '^tools' | wc -l
>         135
>
> More recently, when enabling CONFIG_MODVERSIONS with CONFIG_KCSAN, we
> observe a number of warnings:
>
>         WARNING: modpost: EXPORT symbol "<..all kcsan symbols..>" [vmlinux] [...]
>
> When running a preprocessed source through 'genksyms -w' a number of
> syntax errors point at usage of static_assert()s. In the case of
> kernel/kcsan/encoding.h, new static_assert()s had been introduced which
> used expressions that appear to cause genksyms to not even be able to
> recover from the syntax error gracefully (as it appears was the case
> previously).
>
> Therefore, make genksyms ignore all _Static_assert() and the contained
> expression. With the fix, usage of _Static_assert() no longer cause
> "syntax error" all over the kernel, and the above modpost warnings for
> KCSAN are gone, too.
>
> Signed-off-by: Marco Elver <elver@google.com>

Ah, genksyms...if only there were a library that we could use to parse
C code...:P
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/genksyms/keywords.c |  3 +++
>  scripts/genksyms/lex.l      | 27 ++++++++++++++++++++++++++-
>  scripts/genksyms/parse.y    |  7 +++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
> index 057c6cabad1d..b85e0979a00c 100644
> --- a/scripts/genksyms/keywords.c
> +++ b/scripts/genksyms/keywords.c
> @@ -32,6 +32,9 @@ static struct resword {
>         { "restrict", RESTRICT_KEYW },
>         { "asm", ASM_KEYW },
>
> +       // c11 keywords that can be used at module scope
> +       { "_Static_assert", STATIC_ASSERT_KEYW },
> +
>         // attribute commented out in modutils 2.4.2.  People are using 'attribute' as a
>         // field name which breaks the genksyms parser.  It is not a gcc keyword anyway.
>         // KAO. },
> diff --git a/scripts/genksyms/lex.l b/scripts/genksyms/lex.l
> index e265c5d96861..ae76472efc43 100644
> --- a/scripts/genksyms/lex.l
> +++ b/scripts/genksyms/lex.l
> @@ -118,7 +118,7 @@ yylex(void)
>  {
>    static enum {
>      ST_NOTSTARTED, ST_NORMAL, ST_ATTRIBUTE, ST_ASM, ST_TYPEOF, ST_TYPEOF_1,
> -    ST_BRACKET, ST_BRACE, ST_EXPRESSION,
> +    ST_BRACKET, ST_BRACE, ST_EXPRESSION, ST_STATIC_ASSERT,
>      ST_TABLE_1, ST_TABLE_2, ST_TABLE_3, ST_TABLE_4,
>      ST_TABLE_5, ST_TABLE_6
>    } lexstate = ST_NOTSTARTED;
> @@ -201,6 +201,11 @@ repeat:
>
>                   case EXPORT_SYMBOL_KEYW:
>                       goto fini;
> +
> +                 case STATIC_ASSERT_KEYW:
> +                   lexstate = ST_STATIC_ASSERT;
> +                   count = 0;
> +                   goto repeat;
>                   }
>               }
>             if (!suppress_type_lookup)
> @@ -401,6 +406,26 @@ repeat:
>         }
>        break;
>
> +    case ST_STATIC_ASSERT:
> +      APP;
> +      switch (token)
> +       {
> +       case '(':
> +         ++count;
> +         goto repeat;
> +       case ')':
> +         if (--count == 0)
> +           {
> +             lexstate = ST_NORMAL;
> +             token = STATIC_ASSERT_PHRASE;
> +             break;
> +           }
> +         goto repeat;
> +       default:
> +         goto repeat;
> +       }
> +      break;
> +
>      case ST_TABLE_1:
>        goto repeat;
>
> diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
> index e22b42245bcc..8e9b5e69e8f0 100644
> --- a/scripts/genksyms/parse.y
> +++ b/scripts/genksyms/parse.y
> @@ -80,6 +80,7 @@ static void record_compound(struct string_list **keyw,
>  %token SHORT_KEYW
>  %token SIGNED_KEYW
>  %token STATIC_KEYW
> +%token STATIC_ASSERT_KEYW
>  %token STRUCT_KEYW
>  %token TYPEDEF_KEYW
>  %token UNION_KEYW
> @@ -97,6 +98,7 @@ static void record_compound(struct string_list **keyw,
>  %token BRACE_PHRASE
>  %token BRACKET_PHRASE
>  %token EXPRESSION_PHRASE
> +%token STATIC_ASSERT_PHRASE
>
>  %token CHAR
>  %token DOTS
> @@ -130,6 +132,7 @@ declaration1:
>         | function_definition
>         | asm_definition
>         | export_definition
> +       | static_assert
>         | error ';'                             { $$ = $2; }
>         | error '}'                             { $$ = $2; }
>         ;
> @@ -493,6 +496,10 @@ export_definition:
>                 { export_symbol((*$3)->string); $$ = $5; }
>         ;
>
> +/* Ignore any module scoped _Static_assert(...) */
> +static_assert:
> +       STATIC_ASSERT_PHRASE ';'                        { $$ = $2; }
> +       ;
>
>  %%
>
> --
> 2.29.2.454.gaff20da3a2-goog
>


-- 
Thanks,
~Nick Desaulniers
