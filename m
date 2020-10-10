Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17628A2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391035AbgJJW7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732282AbgJJW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:29:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97630C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 15:21:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p15so13488237wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kqs4kFgxacimQ3ef+Mpd9AqyRzkCpK/qY0CT2NxygDo=;
        b=S3BARRlpS4ZhGea3IaZv87MuotaIiMFFzTuLc6KFNYEE0YonnKzRFD2YP5I7xyN4L0
         KeVrkXhVhKLTjRidwhm/HyOVSFVaZA4pbkUR//y9vZoyI8m0OBgDe08CpEqkf4DW63uZ
         B1iu2dTfjcO/IMk62nxNiCZWbwKfirlMv6OfpAoi2caJY+0vL5nTSANe/LOHNIs2uqVi
         yEvMSBuSgDZp3YSMfOq6I4ly11JW/jlU0EudS95QgTKur531XMb/e4IzgFPEyNrSxKzs
         Y0oqtJBdELm85XUUMqhXQ6sA+HEaynBZLDscpdyzoENHUGQWphX+IUsket6BRr/d5uDK
         x7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kqs4kFgxacimQ3ef+Mpd9AqyRzkCpK/qY0CT2NxygDo=;
        b=qVJlF/r+yyKI+cDitAMy62ykNnO1M6aIMncwY44nL5UJWzY5yL4NZCrYW3BwUOdqg9
         t0DmtlRZhNSN6Zj4QldqI4rSarrgL1I3pR7fwL59ifz8APJD1gKBLwP3P6nSMIvKlR9P
         4wN/k7K9WQK0ZSpFy842a3cX6fIKNsremBBvgU6g0HqaxqU+4JXkN7UN4TmmnuMLIV2d
         DLBWOcfrGai1uPASWszF93P1rDrUX8liitvhDU5T41ot2WeRweMwekRDhdYANSBnP9Ly
         iwOAFUyOQW2onhbiPp0IIKX3iYyepDtVTiSNzyvY+nm+1ZiMEHjV644XYW9oByB3WTvc
         rSQw==
X-Gm-Message-State: AOAM533MWUS3/eKWbGfBy1TFg8rGN5TySkCHbhvJ+y+1HGWhAJxug3/z
        FqaOIRzE71VunLMToUCsBWySsP9+Ef2FQy0Qc2I8AA==
X-Google-Smtp-Source: ABdhPJz8W70r8j9DDHJB8JNQXU9Kizb01d47zuwiTAkpqy9P3R9p3MQEho8UWaT6TYZez/gCDXvm1JVeoFwO1PSkJr0=
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr4109447wmj.87.1602368500027;
 Sat, 10 Oct 2020 15:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201010215135.GB2666@wildebeest.org> <20201010220712.5352-1-mark@klomp.org>
In-Reply-To: <20201010220712.5352-1-mark@klomp.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 10 Oct 2020 15:21:28 -0700
Message-ID: <CAP-5=fUT-1-CR-KMMsrpzgw9b3nBooeY05=YU9XKa5enO9SK+A@mail.gmail.com>
Subject: Re: [PATCH] Only add -fno-var-tracking-assignments workaround for old
 GCC versions.
To:     Mark Wielaard <mark@klomp.org>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 3:08 PM Mark Wielaard <mark@klomp.org> wrote:
>
> Some old GCC versions between 4.5.0 and 4.9.1 might miscompile code
> with -fvar-tracking-assingments (which is enabled by default with -g -O2).
> commit 2062afb4f added -fno-var-tracking-assignments unconditionally to
> work around this. But newer versions of GCC no longer have this bug, so
> only add it for versions of GCC before 5.0.
>
> Signed-off-by: Mark Wielaard <mark@klomp.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f84d7e4ca0be..4f4a9416a87a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -813,7 +813,9 @@ KBUILD_CFLAGS       += -ftrivial-auto-var-init=zero
>  KBUILD_CFLAGS  += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
>  endif
>
> -DEBUG_CFLAGS   := $(call cc-option, -fno-var-tracking-assignments)
> +# Workaround https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
> +# for old versions of GCC.
> +DEBUG_CFLAGS   := $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))
>
>  ifdef CONFIG_DEBUG_INFO
>  ifdef CONFIG_DEBUG_INFO_SPLIT
> --
> 2.18.4
>
