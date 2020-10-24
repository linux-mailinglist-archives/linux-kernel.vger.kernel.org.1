Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C42297A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759149AbgJXC0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:26:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50829 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755267AbgJXC0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:26:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id 13so4126843wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkbS81ctJuGOeBTgrnXO0gkxl8szDNaWYLMAMtT4muA=;
        b=BTS/Y73hPzWmtZ1lOZRJJI4ZznDX+Xp5MwfgjiCIPS1DZTPrH7xWegQ5XwkBmZT2sL
         KhhPbY6fGcOyHBeQUzaKYsArYRdGYyOE2Nsz9E/Xb1CQT8yO9m/pSfiaOkZtl/x+bFG1
         h4iFaPzE+PoeAZieULGCU2cnBg7D4Bp0uaP/GT8oiIRZGBGiTBsRJvLVIX+NGn6bRpsj
         ITRU17MZB9dl5ubVpauRAJhzkoyin9cOi306YJ6YwFFFaZab4f3zohQONCcASbVEEDgn
         sKTBNM2bwmBksjxBfvGZ3TGud7CLSjpzXSetJxS70g2ORJ4E/OICUL78X2zjlJOq+ulK
         4GVw==
X-Gm-Message-State: AOAM530WaZ5S6vnaPqBmhv75RgLRzOh8N1aj5jLBt9/QoQFzE+4GOS8G
        VacWxZBsAw7TihCsDhAXww2NLKHovns7BfWVutQ=
X-Google-Smtp-Source: ABdhPJymGZZL9m09xoeFXee87tSB5wODmhAZ3P2CsDKNW+FOJT2iSeTmgWy5KNyxrLyKSXUE8fmQgxqHNBqyTZy5doo=
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr4858733wmc.8.1603506360635;
 Fri, 23 Oct 2020 19:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201023074234.395002-1-namhyung@kernel.org> <20201023170422.GS466880@tassilo.jf.intel.com>
In-Reply-To: <20201023170422.GS466880@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Oct 2020 11:25:49 +0900
Message-ID: <CAM9d7civtQsnmDCSF-uWaeh01XLkdpdRcEaTsYA5piRo_E2tnQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support regex pattern in --for-each-cgroup
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Sat, Oct 24, 2020 at 2:04 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Fri, Oct 23, 2020 at 04:42:34PM +0900, Namhyung Kim wrote:
> > To make the command line even more compact with cgroups, support regex
> > pattern matching in cgroup names.
> >
> >   $ perf stat -a -e cpu-clock,cycles --for-each-cgroup '^.$' sleep 1
>
> The example doesn't exactly show the benefit. So ^.$ would be only
> for one character cgroups?

Right, I know it's not a good example but just wanted to show the
possibility of regex patterns.  Let me come up with a better one.

>
> Missing documentation updates.

Will add.

Thanks
Namhyung
