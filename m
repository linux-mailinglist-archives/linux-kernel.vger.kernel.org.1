Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14028C025
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgJLS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbgJLS7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:59:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3431C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:59:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so14366157pfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdWH9D9M3/U9qxVAleAUiYrGS3wE2xPiVDjiH/su/+M=;
        b=qRsaQDlKwkVRsOu5VN5rMGyty+hbdZMaLwM/L1PjRUHFc52xtzXjVsz3FGbPxZQvaD
         F7znPPdLv9DSUL5A3cAcmm3/sC6YxvbAZysY5UV4KXSrrc5OLjpcML4I+lEgY5CLHUwf
         3wYxkWDqsENblUt2EkWv5aCAYbLF9ybGtbvn9Eakx0ufjX6f0LROr+iWA+5sXemXXCrv
         /7Z4TBx1W7BjPHpgIjBItVc+w6dYfCxbJomNRbDB/JQGMbV/fFqx3hhdLUmht/3RKAM0
         gKScA1ZdHvMa6rrt54P0PYg8nM2Vu9JjDgrAGBrBdRhZ8Y+8fWcNNicKHU069E5fKoeJ
         h4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdWH9D9M3/U9qxVAleAUiYrGS3wE2xPiVDjiH/su/+M=;
        b=dG8Q6j657+AC8xcBos19yWFIkbgOkqCDiNT5cCVJ4MbgI1kULs2xISIfqOpYYo57vg
         Idtkt1rx6k+hPpqE/FzvhJ5J+GK0gtsm1pNnPvG5yxSodi7SkXnf/vQe10JxryENj/lI
         /FTjyWlyQ6LchIjLnlxOQyvcAteYxT19xUz4E/GdIYmic204Yaa194OsPyGiis92dKAB
         zyZVrZ+eEhOHW210LVALfi4iTNHafLsi8LzdfHaiEpf1wPL8a7/tK9lX5uFx8enOzrTW
         zSL4kmSFy6XTUtlm0a7KEQQGmpRmy3Rhv/fzLOtjERsoUHkTlHXIvVhZD9eBV+o8ZlS1
         X1Sg==
X-Gm-Message-State: AOAM531rojJnwubZEpT3GjRnNNXbEvhYf3n5dYocG8j0Q5o2JaTPYGaM
        PsswVaI9NKWEFZ/fsY60COpaEB3ucl5t6qYSQs53yA==
X-Google-Smtp-Source: ABdhPJz1IQDkXAJH3Ol4Ru15l2xlErlBPjjgPdwZufZsOzipmONg/Wto5Z1aTHyNCIPXWyDlVyXW5RTXdoeTeypKpyA=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr21936098pjj.101.1602529184203;
 Mon, 12 Oct 2020 11:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201010215135.GB2666@wildebeest.org> <20201010220712.5352-1-mark@klomp.org>
 <CAP-5=fUT-1-CR-KMMsrpzgw9b3nBooeY05=YU9XKa5enO9SK+A@mail.gmail.com>
In-Reply-To: <CAP-5=fUT-1-CR-KMMsrpzgw9b3nBooeY05=YU9XKa5enO9SK+A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Oct 2020 11:59:33 -0700
Message-ID: <CAKwvOdnLrgVRmkXLK-OoQsDTcAMZx4RfrTQXEASnJVroAZBdkQ@mail.gmail.com>
Subject: Re: [PATCH] Only add -fno-var-tracking-assignments workaround for old
 GCC versions.
To:     Ian Rogers <irogers@google.com>
Cc:     Mark Wielaard <mark@klomp.org>, Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org,
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

On Sat, Oct 10, 2020 at 3:57 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sat, Oct 10, 2020 at 3:08 PM Mark Wielaard <mark@klomp.org> wrote:
> >
> > Some old GCC versions between 4.5.0 and 4.9.1 might miscompile code
> > with -fvar-tracking-assingments (which is enabled by default with -g -O2).
> > commit 2062afb4f added -fno-var-tracking-assignments unconditionally to
> > work around this. But newer versions of GCC no longer have this bug, so
> > only add it for versions of GCC before 5.0.
> >
> > Signed-off-by: Mark Wielaard <mark@klomp.org>
>
> Acked-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > ---
> >  Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f84d7e4ca0be..4f4a9416a87a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -813,7 +813,9 @@ KBUILD_CFLAGS       += -ftrivial-auto-var-init=zero
> >  KBUILD_CFLAGS  += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> >  endif
> >
> > -DEBUG_CFLAGS   := $(call cc-option, -fno-var-tracking-assignments)
> > +# Workaround https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
> > +# for old versions of GCC.
> > +DEBUG_CFLAGS   := $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))

Should this be wrapped in: `ifdef CONFIG_CC_IS_GCC`/`endif`?

> >
> >  ifdef CONFIG_DEBUG_INFO
> >  ifdef CONFIG_DEBUG_INFO_SPLIT
> > --
> > 2.18.4
> >



-- 
Thanks,
~Nick Desaulniers
