Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3428297E61
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 22:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764365AbgJXUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764358AbgJXUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 16:20:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C65C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 13:20:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m128so6327710oig.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG0Yc/GlRSlgn6rbhnDixnyqF/KHMumMevzsRNu/XRA=;
        b=CiGJIZxtm4Ivj7gUdpRMEJE8/XhDFWdkcF6CaKL076yEJKuUtouOaz71Qvb0OTWMzb
         3FMepYAE8EaL/m6DfVEis1icUbho+fr0mpPH8fgYHrkbo6zlVjBCUjlYYdOc19TbN4P1
         CSgcQkpfO20DiCvGMPwOcKK4Ve7Z+hBjH8/wXwuaZOgUJ8dmwAH/kBKls5xokiIlkTGt
         nI+RcwbC22U5iCkxZvFilKEzJPa7cyOJc0oGONB5vvYpYORLo+uIt0QMz8efxjMx4CZi
         jB6jiV0rpNp8OP7TWveRbQlsJQ8sSEMOU6/3HYjjqAcR9wPMAGA628qFW4iix8sTnwSL
         O42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG0Yc/GlRSlgn6rbhnDixnyqF/KHMumMevzsRNu/XRA=;
        b=YCx8pFB7N+vqN4lA1Iz6xr3gyq+wdLFzgIIK2wigNotFRcQ2AaE2JDyXz4Wuy93XP8
         x6p2QlR1EfroqUq0QhteQ5JUfCq2bpt94iMblf71WySOBhlRnat3ZRFrFTrjiBj3PlTJ
         TQk89MLe4qvVjNjlNs0hInggooMM+w3p1ux/jXzXglFzKbHT87C+2HfMi0XxJ9SxFhYU
         XOuQahliHIDzINK0HOcWLxbQM9AY7ovsalwjgaIb7RUiRpZgmoOjSHiBZmng9/luIB3P
         LtMSXMlygY18Wxh39T92uRdUQFnDfIsY9wGgoPRqrUi9yovt5FcRDHBQbyZshLSUaI2D
         FF8Q==
X-Gm-Message-State: AOAM532XtLEqQY/MVN0zqntAL51HcDAG5JS/spl9RKqfTG2SLg+tjAP0
        twq1TbG65F2ow/u1252RwO2V3sRg5TZwnq9rwEA=
X-Google-Smtp-Source: ABdhPJyHjPrEKBTi1fy3q/eFBSSVUjWLnk8yqoNO9OkvyEAfWwXwKUn6YXtwvDySdHHzXHW5gFCjVF06KdyDIz+7Zho=
X-Received: by 2002:aca:2101:: with SMTP id 1mr7430348oiz.110.1603570841059;
 Sat, 24 Oct 2020 13:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201024090557.45092-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201024090557.45092-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 25 Oct 2020 01:50:11 +0530
Message-ID: <CABJPP5AoeDvRRe0WGReHTXqgzSe1=3_iz=jtpRiHp1BiMc6=kw@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 2:36 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> It is generally preferred that the macros from
> include/linux/compiler_attributes.h are used, unless there
> is a reason not to.
>
> checkpatch currently checks __attribute__ for each of
> packed, aligned, printf, scanf, and weak. Other declarations
> in compiler_attributes.h are not handled.
>
> Add a generic test to check the presence of such attributes.
> Some attributes require more specific handling and are kept
> separate.
>
> New attributes which are now handled are:
>
> __alias__(#symbol)
> __always_inline__
> __assume_aligned__(a, ## __VA_ARGS__)
> __cold__
> __const__
> __copy__(symbol)
> __designated_init__
> __externally_visible__
> __gnu_inline__
> __malloc__
> __mode__(x)
> __no_caller_saved_registers__
> __noclone__
> __fallthrough__
> __noinline__
> __nonstring__
> __noreturn__
> __pure__
> __unused__
> __used__
>
> Link: https://lore.kernel.org/linux-kernel-mentees/3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com/
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 105 +++++++++++++++++++++++++++---------------
>  1 file changed, 69 insertions(+), 36 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7e505688257a..01d83d345b4c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6155,50 +6155,83 @@ sub process {
>                         }
>                 }
>
> -# Check for __attribute__ packed, prefer __packed
> +# Check for compiler attributes
>                 if ($realfile !~ m@\binclude/uapi/@ &&
> -                   $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
> -                       WARN("PREFER_PACKED",
> -                            "__packed is preferred over __attribute__((packed))\n" . $herecurr);
> -               }
> +                   $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
> +                       my $attr = $1;
> +                       $attr =~ s/\s*\(\s*(.*)\)\s*/$1/;
> +
> +                       my %attr_list = (
> +                               "alias"                         => "__alias",
> +                               "aligned"                       => "__aligned",
> +                               "always_inline"                 => "__always_inline",
> +                               "assume_aligned"                => "__assume_aligned",
> +                               "cold"                          => "__cold",
> +                               "const"                         => "__const",
> +                               "copy"                          => "__copy",
> +                               "designated_init"               => "__designated_init",
> +                               "externally_visible"            => "__visible",
> +                               "fallthrough"                   => "fallthrough",
> +                               "gnu_inline"                    => "__gnu_inline",
> +                               "malloc"                        => "__malloc",
> +                               "mode"                          => "__mode",
> +                               "no_caller_saved_registers"     => "__no_caller_saved_registers",
> +                               "noclone"                       => "__noclone",
> +                               "noinline"                      => "noinline",
> +                               "nonstring"                     => "__nonstring",
> +                               "noreturn"                      => "__noreturn",
> +                               "packed"                        => "__packed",
> +                               "pure"                          => "__pure",
> +                               "used"                          => "__used"
> +                       );
> +
> +                       if ($attr =~ /^(\w+)\s*(${balanced_parens})?/) {
> +                               my $curr_attr = $1;
> +                               my $params = '';
> +                               $params = $2 if defined($2);
> +                               $curr_attr =~ s/^[\s_]+|[\s_]+$//g;
> +
> +                               if (exists($attr_list{$curr_attr})) {
> +                                       my $new = $attr_list{$curr_attr};
> +                                       WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +                                            "$new$params is preffered over __attribute__(($attr))\n" . $herecurr);
> +                               }
> +                       }
>
> -# Check for __attribute__ aligned, prefer __aligned
> -               if ($realfile !~ m@\binclude/uapi/@ &&
> -                   $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
> -                       WARN("PREFER_ALIGNED",
> -                            "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
> -               }
> +                       # Check for __attribute__ format(printf, prefer __printf
> +                       if ($attr =~ /^_*format_*\s*\(\s*printf/) {
> +                               if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +                                        "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
> +                                       $fix) {
> +                                       $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
>
> -# Check for __attribute__ section, prefer __section
> -               if ($realfile !~ m@\binclude/uapi/@ &&
> -                   $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
> -                       my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> -                       my $new = substr($old, 1, -1);
> -                       if (WARN("PREFER_SECTION",
> -                                "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
> -                           $fix) {
> -                               $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
> +                               }
>                         }
> -               }
>
> -# Check for __attribute__ format(printf, prefer __printf
> -               if ($realfile !~ m@\binclude/uapi/@ &&
> -                   $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {
> -                       if (WARN("PREFER_PRINTF",
> -                                "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
> -                           $fix) {
> -                               $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
> +                       # Check for __attribute__ format(scanf, prefer __scanf
> +                       if ($attr =~ /^_*format_*\s*\(\s*scanf\b/) {
> +                               if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +                                        "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
> +                                       $fix) {
> +                                       $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
> +                               }
> +                       }
>
> +                       # Check for __attribute__ section, prefer __section
> +                       if ($attr =~ /^_*section_*\s*\(\s*("[^"]*")/) {
> +                               my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> +                               my $new = substr($old, 1, -1);
> +                               if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +                                        "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
> +                                       $fix) {
> +                                       $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
> +                               }
>                         }
> -               }
>
> -# Check for __attribute__ format(scanf, prefer __scanf
> -               if ($realfile !~ m@\binclude/uapi/@ &&
> -                   $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\b/) {
> -                       if (WARN("PREFER_SCANF",
> -                                "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
> -                           $fix) {
> -                               $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
> +                       # Check for __attribute__ unused, prefer __always_unused or __maybe_unused
> +                       if ($attr =~ /^_*unused/) {
> +                               WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +                                    "__always_unused or __maybe_unused is preferred over __attribute__((__unused__))\n" . $herecurr);
>                         }
>                 }
>
> --
> 2.27.0
>
Hi,
In this version there is only one generic test for both parameterized
and non parameterized attributes.

And four attribute checks are kept separate and unaltered from the
original implementation. Those are the format(printf/scanf), section
and unused(which can be resolved to __always_unused or __maybe_unused).

Thanks,
Dwaipayan.
