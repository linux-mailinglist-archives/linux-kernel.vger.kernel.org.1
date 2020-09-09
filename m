Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8E262FCC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgIIO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 10:29:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40351 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIIM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:58:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id j2so2845967wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHj9Y+OBpSmx1Jf6+QC+C6BCUk+VZ+YfPf9czgZdpio=;
        b=JTgXUIcpdvlAD/YX3KIS5TTSZrYWtbrswESgXVskktDv04NyzirT+ZmdbAGoCZpnA6
         TP2gieqcGLzGfdst/SI2JJ13Pf90kAXKMOxNm/k0HAKZIwtyHerblvhFE9UUqCTzE579
         VSZUcr3eL0pmwLYqmLLMQcRg0y1LUQZROgM7E1sS31x1efnmnV2uN7SI2ubTGMhnQI5h
         xivOe8VuhIihMpja7fYEKSloZO2icXRTCTS/fo73JNAirHrRJLNchUHfVW5BdaYyBpEG
         tZYjz01AkmgFqbMMgsWopVemLbfdOs7dVuhh1dUpjMHWMiSXln05XRtDNgHB/jdM/Hq2
         H1bw==
X-Gm-Message-State: AOAM530859OEKI2OGfB+qjIKcpqeP23YyGZnceiKxz+0dpEywj2v184S
        vp+Oxo/zrWbEyGGFJKrwHD3bMjGcI6ov3HD4GIU=
X-Google-Smtp-Source: ABdhPJxMIPV9f+rglZOwJZwHzfNHP9cO+ZsWgLLJgijete5+KX35HW1KsG1qdyVJWyMC4m3wKg1LoecgR27xNmeBltI=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr3609964wrp.332.1599656338630;
 Wed, 09 Sep 2020 05:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200909055849.469612-1-namhyung@kernel.org> <20200909122755.GA3788224@kernel.org>
In-Reply-To: <20200909122755.GA3788224@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Sep 2020 21:58:47 +0900
Message-ID: <CAM9d7cirbZK1RXeRSE+Fz2RoaMBBJ-QZBnj62QyUMmqyL0YyFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf list: Remove dead code in argument check
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Sep 9, 2020 at 9:27 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Sep 09, 2020 at 02:58:47PM +0900, Namhyung Kim escreveu:
> > The sep is already checked being not NULL.  The code seems to be a
> > leftover from some refactoring.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> There is a missing --- separator from the description to the patch, I
> had to add it so that 'git am' works on it, please check.

Hmm.. strange.  I don't know why it's missed..  will double-check later.

Thanks
Namhyung


>
> - Arnaldo
>
> I.e. it should be right here:
>
> ---
>
> >
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index 0a7fe4cb5555..10ab5e40a34f 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -92,13 +92,6 @@ int cmd_list(int argc, const char **argv)
> >               else if ((sep = strchr(argv[i], ':')) != NULL) {
> >                       int sep_idx;
> >
> > -                     if (sep == NULL) {
> > -                             print_events(argv[i], raw_dump, !desc_flag,
> > -                                                     long_desc_flag,
> > -                                                     details_flag,
> > -                                                     deprecated);
> > -                             continue;
> > -                     }
> >                       sep_idx = sep - argv[i];
> >                       s = strdup(argv[i]);
> >                       if (s == NULL)
> > --
> > 2.28.0.526.ge36021eeef-goog
> >
>
> --
>
> - Arnaldo
