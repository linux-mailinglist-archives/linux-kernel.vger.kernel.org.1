Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB862C40A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgKYM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:56:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38827 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgKYM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:56:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id s27so2987645lfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqwyg7MSfWUX6L8eKkBDrNKNwxGOYtH/pKCZSpNPBII=;
        b=WKpGlLkyZuk9Rs/xQob3LJ9Fsv0Z4GczvgbXZwpeS5jsOK4fo8kagM8F9phgnp9ONi
         F84p1QjGbB4RjCIyvJ9yaTezwUQQAAf+KmkjGVQr0ckDLWtsgwJLpUdOgHbqBa4yYQM0
         WVIfYroHPnX+nYLdxqNqYVCnCxtOx0WErk0ss0ILZDFyuGAmNmVaekEHWrG+hfmFE5l4
         WRka2xDOmNJcW9mdRjSI8cm1ijkbHkUT4uSdDb+6Hsy8nYtADv0NeaQ9HE38l3tDLGC8
         3er4iFV1he6Nokut6Kmr6BQG4FRkJXGDyW0IboxaiSESwiEsza9qxmEDEGJgFpaZ6ueO
         jIlQ==
X-Gm-Message-State: AOAM533OPwFwL0QyQWRXpL8tgyjZDprz1txri4dg0EMAW2FRQCnsSbEZ
        lSZ77BEln8ErXyjmUr34iRbvDo87sKHsJ3peX4Q=
X-Google-Smtp-Source: ABdhPJzBbKBqLvC0f5xer38N8NazYTVErcgR77cvTuPf1VAe9uOzHdyFWsFfclv+RW0WOumJHh6IoNKrJNBKIk8CSvg=
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr1350307lfr.149.1606309002124;
 Wed, 25 Nov 2020 04:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20201123230512.2097312-1-jolsa@kernel.org> <20201123230512.2097312-14-jolsa@kernel.org>
In-Reply-To: <20201123230512.2097312-14-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Nov 2020 21:56:31 +0900
Message-ID: <CAM9d7ciq_D2F_bPoq7S5aw+0jPZ0EokCNDadEcO2KF_rYsL8VQ@mail.gmail.com>
Subject: Re: [PATCH 13/25] perf tools: Store build id from mmap2 events
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 8:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When processing mmap2 event, check on the build id
> misc bit: PERF_RECORD_MISC_MMAP_BUILD_ID and if it
> is set, store the build id in mmap's dso object.
>
> Also adding the build id data arts to struct

s/arts/args/ ?

Thanks,
Namhyung


> perf_record_mmap2 event definition.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
