Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE52EA923
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbhAEKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbhAEKsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:48:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 369E8227C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609843660;
        bh=/Tl83Bdn72WSQKObXAulIf4joOMIe7PotYb7NFDieOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DIHIj5JGFwd7TpyHNWpmbpcPAcGQD//AXfIX1nWZdjcC8Rv4w4i+Ba26kMw6/3ZFp
         MFbdUKYQG/CQB+Dew5PpU35WRaDQ15MDD+aubtKewLXUtvy/fD3dMWvdpMDw/0BGiA
         P+QZsVPftRZfp3+t2+BmddA8orD2dWSu3GEvwU3wqPDQpUqO+EPo/nEC8hRGR2cIr0
         kZMdAIASf015tp/pqHVglWbvjck0kIVtHlx+phCocw6WBHfQyyQGtcZ+5jVBSpVQsD
         NccC/7XILy7buaSeWxrJES9cOHAOaxa6fD+v3woFDotxLMBT5/aYIUqsVdJg6rKrEm
         i+97cXDeL1C4g==
Received: by mail-oo1-f46.google.com with SMTP id k7so6984219ooa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:47:40 -0800 (PST)
X-Gm-Message-State: AOAM532jkDNEY49JUOQerl7W4pRg9rUOobONHVVQrs0Zcp6pi9foGdpk
        10+dukn60wa7jqM9N3oU2f9OxJdt3//OHlgfvxg=
X-Google-Smtp-Source: ABdhPJzPO8FsLl0M82OW0QW3Xa1A6aa810EtnEYGNlmTSY9rd0wo6Rg3+XjKqR4J/mgf3aO/tfpj01eoidOQKGh3s4Q=
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr50837741ooo.66.1609843659138;
 Tue, 05 Jan 2021 02:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20201228024159.2BB66203B5@pchp3.se.axis.com>
In-Reply-To: <20201228024159.2BB66203B5@pchp3.se.axis.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 11:47:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1G2YHh2FRd=vBY4xxsJ1wZFh2pB1wyw82QmQOaiV4+CA@mail.gmail.com>
Message-ID: <CAK8P3a1G2YHh2FRd=vBY4xxsJ1wZFh2pB1wyw82QmQOaiV4+CA@mail.gmail.com>
Subject: Re: [PATCH] perf arm64: Simplify mksyscalltbl
To:     Hans-Peter Nilsson <hp@axis.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 3:44 AM Hans-Peter Nilsson <hp@axis.com> wrote:
>
> This patch isn't intended to have any effect on the compiled
> code.  It just removes one level of indirection: calling the
> *host* compiler to build and then run a program that just
> printf:s the numerical entries of the syscall-table.  In other
> words, the generated syscalls.c changes from:
>         [46] = "ftruncate",
> to:
>         [__NR3264_ftruncate] = "ftruncate",

If you include the file, why not just use the macros directly, like

#define __SYSCALL(nr, sym) [nr] = #sym ;
static const char *syscalltbl_arm64[] = {
#include <uapi/asm-generic/unistd.h>
};
#undef __SYSCALL

The leaves an extra "sys_" in front of every name, but if you
care, that could be left out afterwards.

> At the time of this patch, powerpc (the origin, see comments),
> and also e.g. x86 has moved on, from filtering "gcc -dM -E"
> output to reading separate specific text-file, a table of
> syscall numbers.  IMHO should arm64 consider adopting this.

Right, we had patches to convert include/uapi/asm-generic/unistd.h
to the syscall.tbl format some time ago, but they were never
merged as there were a few remaining bugs. I had planned to
pick up that work but have not gotten around to it yet.

If anyone is interested in doing this, I can dig out the last version
of the patches.

       Arnd
