Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F932D3E68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgLIJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLIJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:18:51 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586FCC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:18:11 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id x15so925179ilq.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CkfJi6sc/FeD7aSF5fhUIMGNUBYFXWr8w4D6JpX9yk=;
        b=s5+73UfrzC+gL+7fhdcbObb6Xg95cXP50hbwAsent4EkVkpTgshprfX9zIN4PDZ2cf
         epa56Prb4eWSClYC6WfF2V3dTkAxlI+RlrOlJaDErKeW8svqnCtUz3hDA8yGFXtdyij5
         ZgXIxJ4c38UnUpXxF/KTwdxd/BFLAzLctjYj6h0GhMbvqQHG2Xp7lxNByt3Qg0A5bSY1
         dPIfyMwwUnZQxQtih652kHebss6lhfhLQ+1rqT0ZXvi9mGfJc9qTrYN/ofCEv9hm1F7l
         Qq8QO56N0kwTHkV15CfkIZkRiAevx8TJyV4CBPAwXA8yXA/N6QWmNiZuZ6jA1l0Ce6b+
         YRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CkfJi6sc/FeD7aSF5fhUIMGNUBYFXWr8w4D6JpX9yk=;
        b=mH04Y7StmpDsI+eloRwF5aaADFJ1rctc4zJv9EGmSBtAQNxPYecui/zRL7zT8l2Q/s
         dNo64D3LcDBtE6LcFlgLUIGfimGgcO5xCslEacLnB9dhpzVSQa2QdYN03okOi0l6u3In
         A1vK979zKY0m/5zGq5qTHJW/O9ObDWKw8MxnGSZe8lpWUtjvj0f7dNLD81OoVF7ohyF/
         KKRn9rbsPrVO2H5KjBwYsmPSaYbovTYnDeoMRlm0DsZGjdvd+5OjAHiTA3XhSO3JkxW9
         vd+5krUbPoUYVHpBfsrRFxEYVjCPDwbLoZ7uOGzwWwyp+gWEsEYa9c6fy7C/9nHB6Cxw
         WCvA==
X-Gm-Message-State: AOAM5307rg/+fO7JpXwCby3oXbqOmrOKWWH3mp2C3obB/O+gP3GwUHdp
        +6AVeNTgTTgQWIQMdbsJRWtqASWcvGCl3QPgQaEgBVzCZCs=
X-Google-Smtp-Source: ABdhPJx0Eg8jg6IjzgqxFMP5Mmyij323C17Wn7vGbRaNsalDIezY3F6tehHKnPjYW7Ofr5n88uer6yOSsua7KWPy7t8=
X-Received: by 2002:a92:8587:: with SMTP id f129mr1523030ilh.251.1607505490660;
 Wed, 09 Dec 2020 01:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20201206152352.35026-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201206152352.35026-1-dwaipayanray1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 9 Dec 2020 10:17:59 +0100
Message-ID: <CAKXUXMxD9wyaKf1TrZchOY1NBkFKSrHhFefQc9AK-bfH8fu8oA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add --fix option to include linux checks
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 6, 2020 at 4:24 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Add fix option to INCLUDE_LINUX and ARCH_INCLUDE_LINUX
> checks to replace asm includes.
>
> Macros of type:
>  #include <asm/percpu.h>
>  #include <asm/processor.h>
>
> are corrected to:
>  #include <linux/percpu.h>
>  #include <linux/processor.h>
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Dwaipayan, can you run this rule from checkpatch.pl on all files in
the current linux-next tree and share all findings with me?

Maybe, we can fix a few places and improve the rule.

Lukas

> ---
> Changes in v3:
> - Add --fix option to ARCH_INCLUDE_LINUX check
>
> Changes in v2:
> - Use \Q..\E quoting
> - Use @ as regex delimiter
>
>  scripts/checkpatch.pl | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b086d1cd6c2..4aecc237ed38 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5558,11 +5558,17 @@ sub process {
>                                 my $asminclude = `grep -Ec "#include\\s+<asm/$file>" $root/$checkfile`;
>                                 if ($asminclude > 0) {
>                                         if ($realfile =~ m{^arch/}) {
> -                                               CHK("ARCH_INCLUDE_LINUX",
> -                                                   "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
> +                                               if (CHK("ARCH_INCLUDE_LINUX",
> +                                                       "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
> +                                                   $fix) {
> +                                                       $fixed[$fixlinenr] =~ s@\Q<asm/$file>\E@<linux/$file>@;
> +                                               }
>                                         } else {
> -                                               WARN("INCLUDE_LINUX",
> -                                                    "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
> +                                               if (WARN("INCLUDE_LINUX",
> +                                                        "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
> +                                                   $fix) {
> +                                                       $fixed[$fixlinenr] =~ s@\Q<asm/$file>\E@<linux/$file>@;
> +                                               }
>                                         }
>                                 }
>                         }
> --
> 2.27.0
>
