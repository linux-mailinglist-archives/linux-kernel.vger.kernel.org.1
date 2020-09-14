Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40A1268408
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgINFZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:25:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52707 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgINFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:25:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id q9so9353321wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7HOZbUgNHvFsPMQU6cZ31wrCEcVN9PuSG2phiaTblo=;
        b=spHkyiogNZffnKsCNN3z8OwumSHRiklSfrwS0q9rces2sSCStKUxRx7JZevV4Q4/bN
         b4nAESBgq8+ehr5XSmatMTUYy8+B5heshmetM4cyCXhTGws5xilLRV1MB4euivQxopt3
         9m5RoGO/J2ElzMfKWSgcZtGUUvAO2QQWnskcXeaN7METYwOGX4HZA6ILtjswynwmLrmI
         +ZLIlFC0CYzo6r4ITga5pFlS94TBMjCPeSjKajKmjiBs13Mtw0AcTJtzGK9VtkL02Wft
         H5zW3SuGcKVZgYPGAFIRdeZxYYkQ/QmD13dyaWL79s/MlWg3dIFBGqvGzwP7+41YIURH
         OsfA==
X-Gm-Message-State: AOAM531smWJ+zg36SV38j+O0bR+22iOFARDr7PfyFv8cytIpDkU50uvc
        kdFmlnLXZcMaH9gfMpwJpFmMes23HHcCaXBB3dk=
X-Google-Smtp-Source: ABdhPJznlOyo84iHMphhoyjTr+9VWsIClljEwUtiLoffMica6HBBfOzB6JQIkVXO5hQemUSi+/M5YUwcjQ/NbOhCD9Q=
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr13084064wmm.128.1600061136206;
 Sun, 13 Sep 2020 22:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 14:25:25 +0900
Message-ID: <CAM9d7ci4VUuAguynK76Zd7YSnNoAErsgabucUjb3qcuXj5m7Pg@mail.gmail.com>
Subject: Re: [RFC 00/26] perf: Add mmap3 support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> while playing with perf daemon support I realized I need
> the build id data in mmap events, so we don't need to care
> about removed/updated binaries during long perf runs.
>
> This RFC patchset adds new mmap3 events that copies mmap2
> event and adds build id in it. It makes mmap3 the default
> mmap event for synthesizing kernel/modules/tasks and adds
> some tooling enhancements to enable the workflow below.

Cool! It's nice that we can skip the final build-id collection stage
with this while data size will be bigger.

Thanks
Namhyung
