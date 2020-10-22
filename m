Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA89329615D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901093AbgJVPAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895650AbgJVPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:00:03 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A50C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:00:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n11so1760855ota.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na6bxm+chNgXOcwmPypF257p4yeLALEUdxQCMprVnTQ=;
        b=F7FBAVaQOXFEOmb952HzKh6W2Kf9/TepWkQCOiSLmJnlzVWdr160wD8dUzQD3qIikR
         gXOeYltacN4lak71MuPkpUlaRvl2oJcgcCiymko+VQOFhcMSKhFBCjY0+Jjun8RPf/Wb
         DKkcrSfyWJgVOidRXJ/Mmr7Q4mlp+386se9V/2cbu7+BAuamniLM6FG8sccA4zzZbbIo
         nBAHy29Umx+i4KZIqKbyxpJ4fhZ5XueOUq0lRLuhuAAyRPRmaQnuTYQW28qO/GTbgat1
         g+SYELUTPuf7nl780nLZScilRZOWv2VvMiE5S/In9m92PmVOXoc3CRykglZCk2Xdv+r1
         /Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na6bxm+chNgXOcwmPypF257p4yeLALEUdxQCMprVnTQ=;
        b=SUYe+C405xEw7XbhHn67IwQtIJZDWICEc30qCR0Xui4zxR/b10x9xL0IEa5r+6NySn
         4XdPfkaBUEdKI7nHjlhelj9B1hlrKY/o5+otXADLBc2T5MV5hJaG6ySs/uRxdBZFgpVN
         m7Qv4KTDn+98nf6PerQSm314PCqhDLWho0+8gTOPFuFJZxIbMapJJq4PQpOacImPWD9K
         NoUxw7fvE3wko4qYfTjrpwkxwH8StYb+oHWBo4kgLkN/STv3egGgXr2/NoLeO07KUvFm
         BE+ZD+/LOAgD30O82mZvSt1P8WXVmfKBZ0zNUajSzDbzTfsZdaQGe8J1eOeMgShuwt1E
         aslQ==
X-Gm-Message-State: AOAM532ixOQLg0MlOK7aw3cObKzUXkzEyOKrbCXdprClx3bhMBdK92IL
        SLQDR43YPfo38NCwHS5v/JU7dl7L/Z4kzgLo+/k=
X-Google-Smtp-Source: ABdhPJw+8r14rZtHIKwQLmsfTmrgWRlNjVUcEUW6qy/L8iV33GVB0yyieJKJpJoaMVh/rbbrvxnEmwWbWQOls25/+4k=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr2019577oth.215.1603378802137;
 Thu, 22 Oct 2020 08:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201022145224.645538-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201022145224.645538-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 22 Oct 2020 20:29:32 +0530
Message-ID: <CABJPP5AQwRkT_2FozYxgTgUZ2RWS=k1TNN_QOvs6F5se-V-6ow@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 8:22 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> It is generally preferred that the macros from
> include/linux/compiler_attributes.h are used, unless there
> is a reason not to.
>
> Checkpatch currently checks __attribute__ for each of
> packed, aligned, printf, scanf, and weak. Other declarations
> in compiler_attributes.h are not handled.
>
> Add more definitions to the attribute check.
> The following patterns are added:
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
>  scripts/checkpatch.pl | 199 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 163 insertions(+), 36 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7e505688257a..968adcb15793 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6155,50 +6155,177 @@ sub process {
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
> +                   $line =~ /\b__attribute__\s*\(\s*\((.*)\)\s*\)/) {
> +                       my $attr = trim($1);
>
> -# Check for __attribute__ aligned, prefer __aligned
> -               if ($realfile !~ m@\binclude/uapi/@ &&
> -                   $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
> -                       WARN("PREFER_ALIGNED",
> -                            "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
> -               }
> +                       # Check for __attribute__ alias, prefer __alias
> +                       if ($attr =~/^_*alias_*/) {
> +                               WARN("PREFER_ALIAS",
> +                                    "__alias(symbol) is preferred over __attribute__((alias(#symbol)))\n" . $herecurr);
> +                       }
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
> +                       # Check for __attribute__ aligned(size), prefer __aligned(size)
> +                       if ($attr =~/^_*aligned_*\(/) {
> +                               WARN("PREFER_ALIGNED",
> +                                    "__aligned(size) is preferred over __attribute__((__aligned__(size)))\n" . $herecurr);
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
> +                       # Check for __attribute__ aligned, prefer __aligned_largest
> +                       if ($attr =~/^_*aligned_*$/) {
> +                               WARN("PREFER_ALIGNED_LARGEST",
> +                                    "__aligned_largest is preferred over __attribute__((__aligned__))\n" . $herecurr);
> +                       }
>
> +                       # Check for __attribute__ always_inline, prefer __always_inline
> +                       if ($attr =~/^_*always_inline_*/) {
> +                               WARN("PREFER_ALWAYS_INLINE",
> +                                    "__always_inline is preferred over __attribute__((__always_inline__))\n" . $herecurr);
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
> +                       # Check for __attribute__ assume_aligned, prefer __assume_aligned
> +                       if ($attr =~/^_*assume_aligned_*/) {
> +                               WARN("PREFER_ASSUME_ALIGNED",
> +                                    "__asume_aligned(a, ...) is preferred over __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ cold, prefer __cold
> +                       if ($attr =~ /^_*cold_*/) {
> +                               WARN("PREFER_COLD",
> +                                    "__cold is preferred over __attribute__((__cold__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ const, prefer __attribute_const
> +                       if ($attr =~ /^_*const_*/) {
> +                               WARN("PREFER_CONST",
> +                                    "__attribute_const is preferred over __attribute__((__const__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ copy, prefer __copy
> +                       if ($attr =~ /^_*copy_*/) {
> +                               WARN("PREFER_COPY",
> +                                    "__copy(symbol) is preferred over __attribute__((__copy__(symbol)))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ desginated_init, prefer __designated_init
> +                       if ($attr =~ /^_*designated_init_*/) {
> +                               WARN("PREFER_DESIGNATED_INIT",
> +                                    "__designated_init is preferred over __attribute__((__designated_init__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ externally_visible, prefer __visible
> +                       if ($attr =~ /^_*externally_visible_*/) {
> +                               WARN("PREFER_VISIBLE",
> +                                    "__visible is preferred over __attribute__((__externally_visible__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ format(printf, prefer __printf
> +                       if ($attr =~ /^_*format_*\s*\(\s*printf/) {
> +                               if (WARN("PREFER_PRINTF",
> +                                        "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
> +                                       $fix) {
> +                                       $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;
> +
> +                               }
> +                       }
> +
> +                       # Check for __attribute__ format(scanf, prefer __scanf
> +                       if ($attr =~ /^_*format_*\s*\(\s*scanf\b/) {
> +                               if (WARN("PREFER_SCANF",
> +                                        "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
> +                                       $fix) {
> +                                       $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
> +                               }
> +                       }
> +
> +                       # Check for __attribute__ gnu_inline, prefer __gnu_inline
> +                       if ($attr =~ /^_*gnu_inline_*/) {
> +                               WARN("PREFER_GNU_INLINE",
> +                                    "__gnu_inline is preferred over __attribute__((__gnu_inline__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ malloc, prefer __malloc
> +                       if ($attr =~ /^_*malloc_*/) {
> +                               WARN("PREFER_MALLOC",
> +                                    "__malloc is preferred over __attribute__((__malloc__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ mode, prefer __mode
> +                       if ($attr =~ /^_*mode_*/) {
> +                               WARN("PREFER_MODE",
> +                                    "__mode(x) is preferred over __attribute__((__mode__(x)))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ no_caller_saved_registers, prefer __no_caller_saved_registers
> +                       if ($attr =~ /^_*no_caller_saved_registers_*/) {
> +                               WARN("PREFER_NO_CALLER_SAVED_REGISTERS",
> +                                    "__no_caller_saved_registers is preferred over __attribute__((__no_caller_saved_registers__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ noclone, prefer __noclone
> +                       if ($attr =~ /^_*noclone_*/) {
> +                               WARN("PREFER_NOCLONE",
> +                                    "__noclone is preferred over __attribute__((__noclone__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ fallthrough, prefer fallthrough
> +                       if ($attr =~ /^_*fallthrough_*/) {
> +                               WARN("PREFER_FALLTHROUGH",
> +                                    "fallthrough is preferred over __attribute__((__fallthrough__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ noinline, prefer noinline
> +                       if ($attr =~ /^_*noinline_*/) {
> +                               WARN("PREFER_NOINLINE",
> +                                    "noinline is preferred over __attribute__((__noinline__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ nonstring, prefer __nonstring
> +                       if ($attr =~ /^_*nonstring_*/) {
> +                               WARN("PREFER_NONSTRING",
> +                                    "__nonstring is preferred over __attribute__((__nonstring__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ noreturn, prefer __noreturn
> +                       if ($attr =~ /^_*noreturn_*/) {
> +                               WARN("PREFER_NORETURN",
> +                                    "__noreturn is preferred over __attribute__((__noreturn__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ packed, prefer __packed
> +                       if ($attr =~ /^_*packed_*/) {
> +                               WARN("PREFER_PACKED",
> +                                    "__packed is preferred over __attribute__((__packed__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ pure, prefer __pure
> +                       if ($attr =~ /^_*pure_*/) {
> +                               WARN("PREFER_PURE",
> +                                    "__pure is preferred over __attribute__((__pure__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ section, prefer __section
> +                       if ($attr =~ /^_*section_*\s*\(\s*("[^"]*")/) {
> +                               my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> +                               my $new = substr($old, 1, -1);
> +                               if (WARN("PREFER_SECTION",
> +                                        "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
> +                                       $fix) {
> +                                       $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
> +                               }
> +                       }
> +
> +                       # Check for __attribute__ unused, prefer __always_unused or __maybe_unused
> +                       if ($attr =~ /^_*unused_*/) {
> +                               WARN("PREFER_UNUSED",
> +                                    "__always_unused or __maybe_unused is preferred over __attribute__((__unused__))\n" . $herecurr);
> +                       }
> +
> +                       # Check for __attribute__ used, prefer __used
> +                       if ($attr =~ /^_*used_*/) {
> +                               WARN("PREFER_USED",
> +                                    "__used is preferred over __attribute__((__used__))\n" . $herecurr);
>                         }
>                 }
>
> --
> 2.27.0
>
Hi,
This patch is meant to add handling of more __attribute__ shorthands
from include/linux/compiler_attributes.h.

I am a bit worried about the code size though. Is it better altogether
to have a shared function for parameterized/non parameterized
__attribute__ arguments? Might have to categorize the macros then.

What do you think is better?

Thanks,
Dwaipayan.
