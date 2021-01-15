Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A382F84AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbhAOSpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbhAOSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:45:54 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D330C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:45:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 30so6566434pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOEhQwzs9OGVgMBehSSbKpB3Q2F4m0Qd+Emh5fbczS8=;
        b=Th9r6YnHXg6tLjGz+tuHTBXCJ7CNJivOmdKgEXYp3skY7e0gPL299QuoGy7OTChLBY
         /jtZzoPrCrx4IZYeohw+2nITX8kPLp14JIQJuKRj5v8wvWThSqCNH6dVEb3hT92HejtS
         652m2GuXduLAC97YOLOuauq8SF/CjFzDN2Dhlr8Ycqfuykdbq3kOCrWO2ZvGi3MhTBqN
         F7znNdmF1CgaCdug/U1PeB0k45YX8DhaA+jUCtkD0vesT0HmyMqcfOEzGziN3WYj5I5H
         0jVkjaMsP7sl3NJuOJ/WmVInTheSG+Jaxu/QhQxBsf6ElKW/Mtz+HC7rphENRRMEsUSB
         xZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOEhQwzs9OGVgMBehSSbKpB3Q2F4m0Qd+Emh5fbczS8=;
        b=ldN6B8xBShZxZUSasPrvbXgRrbHxUih6qt+qS1x/ciMXNodn4VD0Eb89bxwCHEW6fu
         Yula8wO7koGdg+He8i3ybwf6Ilgie4Sl3B2souYsQd6zJepFN/12XVmOIYj7EWN88uMM
         LfNICuepjCIY4se+unuvHdcyRXdA5ttoZzHHKriJG9o3Tc7OyMZXytFmDelu1MKrat3N
         KyopYGEmqFpeWrZYPc/DlcNLTxTKFM5gwaoRZtic/ag++yrLvdfe1PiGdudPWG4BebRN
         GRVo6zFjXgYpZReiC1yT2S+QRqZW5MtVbJePSa150VCzEQb7CUwdIF3/xf1iRksmdlFI
         3P2w==
X-Gm-Message-State: AOAM533KlvO9gUUliHboFofRCKJgqmV/imf3x7HPfvNDFnovV03JJrZx
        aUGuTtPNXK314JVGdsQUuPwt4nEiDphip7VMGJ3dcQ==
X-Google-Smtp-Source: ABdhPJwA1MPW2ahXqUducvE5Pm/jhT3wf0nKLx5m1fRdqHhhWIuW6AcEkB90rPGUbRURuaZY+VwkkJkQgWjZIXEBNnw=
X-Received: by 2002:a62:7c4a:0:b029:19d:b7bc:2c51 with SMTP id
 x71-20020a627c4a0000b029019db7bc2c51mr14252282pfc.30.1610736313331; Fri, 15
 Jan 2021 10:45:13 -0800 (PST)
MIME-Version: 1.0
References: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
In-Reply-To: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jan 2021 10:45:01 -0800
Message-ID: <CAKwvOdm47R1UxPGfHa_2FCUJwwACqMYFoPNuyaab_N6qW-OWow@mail.gmail.com>
Subject: Re: [PATCH] objtool: Don't fail the kernel build on fatal errors
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 2:46 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> This is basically a revert of commit 644592d32837 ("objtool: Fail the
> kernel build on fatal errors").
>
> That change turned out to be more trouble than it's worth.  Failing the
> build is an extreme measure which sometimes gets too much attention and
> blocks CI build testing.
>
> These fatal-type warnings aren't yet as rare as we'd hope, due to the
> ever-increasing matrix of supported toolchains/plugins and their
> fast-changing nature as of late.
>
> Also, there are more people (and bots) looking for objtool warnings than
> ever before, so such warnings not likely to be ignored for long.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thank you; I feel the arguments against enabling -Werror for the
kernel apply here.  The warnings are annoying enough that we plan to
follow up on them all.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/objtool/check.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5f8d3eed78a1..4bd30315eb62 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2928,14 +2928,10 @@ int check(struct objtool_file *file)
>         warnings += ret;
>
>  out:
> -       if (ret < 0) {
> -               /*
> -                *  Fatal error.  The binary is corrupt or otherwise broken in
> -                *  some way, or objtool itself is broken.  Fail the kernel
> -                *  build.
> -                */
> -               return ret;
> -       }
> -
> +       /*
> +        *  For now, don't fail the kernel build on fatal warnings.  These
> +        *  errors are still fairly common due to the growing matrix of
> +        *  supported toolchains and their recent pace of change.
> +        */
>         return 0;
>  }
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
