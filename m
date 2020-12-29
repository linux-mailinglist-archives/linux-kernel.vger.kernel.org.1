Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586112E6E55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgL2FgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:36:01 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:32997 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgL2FgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:36:00 -0500
Received: by mail-qt1-f179.google.com with SMTP id c14so8379155qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1z4WRccNqEHkXZrpqL5+EXbqA+bbffVV7Na33E5Nho4=;
        b=Y6LQLcfzkMWCVpUnvsyGmbW/19rctXolkoa/X9IaiMDIEg1P8nGMRPfNAGkYcTecGK
         YlffSqlhV4PVFI6lN4dEsFxExDDJyLo1U36uDwuVvCUXTRn23j9b1dsxxYH7GgCJcdUG
         X2LfwXxShfXIG4NEtLZrSLKSPfuQYl/KRb2QjS1908PjVhUuOUc95UIYKJZ/d3pRV3AG
         pzFV2ZpJ4VDvQELlZw07iUvx2SbkDyisjaqsohN4qO3HSEzG7g+agNNs/DJorIEYr0RU
         ct2DEvjC54hUXS+aBPhKXm8b619QgKKDNw8jMMAenPgg7iZCnUnJRSAaelB0JXuI1ajU
         tw0g==
X-Gm-Message-State: AOAM533i+1+wH1XPCzjwnGUteFkNjZIlAmLG5Hx62hwe0+QRX4Jn35b1
        FHlu4YbkArStprKScdhPLG+UJR26oc4JNmi+l3k=
X-Google-Smtp-Source: ABdhPJyjNgu+VOl/WS5DwOV24Yncs2zFF2DhMT1kk7mcUnp3FncyM7jarCBxGOB05buww/76I+V8mUx54ZSmpzevLPc=
X-Received: by 2002:ac8:5406:: with SMTP id b6mr47283129qtq.276.1609220119376;
 Mon, 28 Dec 2020 21:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20201221070029.1451176-1-namhyung@kernel.org> <20201221070029.1451176-3-namhyung@kernel.org>
 <20201228115006.GB450923@krava>
In-Reply-To: <20201228115006.GB450923@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Dec 2020 14:35:07 +0900
Message-ID: <CAM9d7ci4YapWyRK-tujg0THmgK6Ys9jCE7NSPHX1pP3rN4rt+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Skip MMAP record synthesis for kernel threads
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 8:50 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Dec 21, 2020 at 04:00:28PM +0900, Namhyung Kim wrote:
> > To synthesize information to resolve sample IPs, it needs to scan task
> > and mmap info from the /proc filesystem.  For each process, it
> > opens (and reads) status and maps file respectively.  But as kernel
> > threads don't have memory maps so we can skip the maps file.
> >
> > To find kernel threads, check "VmPeak:" line in /proc/<PID>/status
> > file.  It's about the peak virtual memory usage so only user-level
> > tasks have that.  Also check "Threads:" line (which follows the VmPeak
> > line whether or not it exists) to be sure it's read enough data - just
> > in case of deeply nested pid namespaces or large number of
> > supplementary groups are involved.
>
> how much does this save? for kernel threads the maps file is empty
> and we just open the file and close
>
> also perhaps just stat(".....maps") and check the size would be easier?

The numbers are in the cover letter and it's around 5% on an idle
machine which has mostly kernel threads.  I think most of the win
came from this change.

It's just to avoid those syscalls, so I wanted to use the available
info in the status file.

Thanks,
Namhyung
