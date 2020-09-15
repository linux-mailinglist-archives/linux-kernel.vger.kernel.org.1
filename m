Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49239269A74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgIOAdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgIOAdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:33:53 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF01C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:33:51 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e14so928413vsa.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPfeV9qgDeTqgNaChhvEE2Dbzg4FicG6GKASHAz4oAw=;
        b=rAj7my/QJeZ4arXd5i743220uLWu5uZjHy6Nt0HQYEYpiCPVzDaBgIVGtFoogmyhDc
         vgpM11abaIgQnvc8QLLdMQbGvieLiTEGMiktWvrYRCh/bCdqm0mdXD0TlQCgCpg9I+mZ
         kTOpCCb7Y2Jm+fJ0bym04+nbP3J7nEbwScTqMWrVdDVuYUbDaqriWfvP8n1tn/fymYjy
         q8Fwi5sw5CqjVs/CCK6NiR4RnQs9M67iBhJfYPrBwCVL1sEddYBkXZVCWzcG3ERGJaW+
         cZTXnr5JXlgrFdrZ0fc6kbz/VgQyALL5b/EXrWJMfIa9uZisZm6Pn0ofCrqRZFgydkx/
         YFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPfeV9qgDeTqgNaChhvEE2Dbzg4FicG6GKASHAz4oAw=;
        b=CMaMVOxUIKk5Yo0QHgyIuPeFda/m4pE2KE68zBanMyOCN8al2ezln3Ax4KgpjewfOU
         DEWw7e11EgYQ4+VfW/gjb68rIueN1vXblwAY1b65NYGx2JKGv3x3No5ggCggPkP3LsuC
         S/PdAP7s4dFWa1jSX2rfE2MGOLcow9XuYI0tIaq8tN58q0zKpq/AYHbVUVXmNuEsZYAG
         Hdxdb6ehFqTz/f9aTiPGaQFcW3SSP0LmoHRtji6twm8j61yeuLe+gskyaxSKLJGFxK3F
         /56zOgtyDakya+G+aKCfgpgE8Gl8zLwBC13ZiG9XPGyBkiAzf6SX2v8S9oFugpzv1rzb
         54Uw==
X-Gm-Message-State: AOAM531Bu9GL0bKS3+OdZbq3lAOXSDT7wH2TFGmQmZVAHfYwbCCKm6sj
        8mXsQnKPPnUhcuyU48kzRyLlqeQikdg+Iywlu/Y=
X-Google-Smtp-Source: ABdhPJzzCNdR7aBCyJKKPlmBkWPc3MTSzrK/wVKwuB6kjj1d/OmIzDC+XgUWGXrRskB/D6MFNNKYvMyYb7pwHcsFc8A=
X-Received: by 2002:a67:33c4:: with SMTP id z187mr9152346vsz.0.1600130030617;
 Mon, 14 Sep 2020 17:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200912041101.2123-1-henrywolfeburns@gmail.com> <20200914223716.GK166601@kernel.org>
In-Reply-To: <20200914223716.GK166601@kernel.org>
From:   Henry Burns <henrywolfeburns@gmail.com>
Date:   Mon, 14 Sep 2020 20:33:39 -0400
Message-ID: <CADJK47PjKYCZiZ72oKnYnx2OPfOZXUzDdUD9m3yKJTpdpicAxA@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events amd: remove trailing comma
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > amdzen2/core.json had a trailing comma on the x_ret_fus_brnch_inst
> > event. Since that goes against the JSON standard, lets remove it.
>
> is this the only case in all the .json files we have in
> tools/perf/pmu-events/?

I just searched the  pmu-events/arch/ folder, and found one other instance in
amdzen1. I'll send an updated patch now.
>
> - Arnaldo
>
> > Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>
> > ---
> >  tools/perf/pmu-events/arch/x86/amdzen2/core.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> > index de89e5a44ff1..4b75183da94a 100644
> > --- a/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> > +++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> > @@ -125,6 +125,6 @@
> >    {
> >      "EventName": "ex_ret_fus_brnch_inst",
> >      "EventCode": "0x1d0",
> > -    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8.",
> > +    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8."
> >    }
> >  ]
> > --
> > 2.25.1
> >
>
> --
>
> - Arnaldo
