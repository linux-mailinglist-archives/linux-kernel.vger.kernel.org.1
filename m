Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A434F2684B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgINGUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgINGUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:20:44 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79FF207C3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600064444;
        bh=8yrIONlA7T6epKuACwY7mydmwH8bBcfbQ9uiv/lSUHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=huN7E5LTGuYVvWBq0G48DvFGua2cYGantzDvXfUhhJ0DH5QgWXAVbTRGP+F6m43+k
         VAImKGCZKqTisH1nUVoGJhGfh+Ou1D009FLLEHhaLkqLAllwU/cNK3wROAGk/lbLV+
         vuxjRCMF3q0k5C1+TfcpaCeRv3PkiOuSMM8F+jDc=
Received: by mail-lj1-f171.google.com with SMTP id a22so17541249ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:20:43 -0700 (PDT)
X-Gm-Message-State: AOAM5310IAsNBuDH0oa0BzZnPitbs/9WjkkXX/XJn6UXZEvpIIzvGaNW
        fssLsVqF/lCWHqK12wJVEt7StwWbtHsDZlP3TrE=
X-Google-Smtp-Source: ABdhPJxZhljT8pCP3GGpRoDBqAKY6v2Rd4z1ygyBL3kG9+juiniMaTz2w5weP9cysIAIweiK+/Cj84vXAytmwxqQU1I=
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr4247446lji.392.1600064442189;
 Sun, 13 Sep 2020 23:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
In-Reply-To: <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Sep 2020 23:20:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7sd5wD1a+aeRs+6ppgurxF6QsAcOLSh_JzgZA7AaGCMQ@mail.gmail.com>
Message-ID: <CAPhsuW7sd5wD1a+aeRs+6ppgurxF6QsAcOLSh_JzgZA7AaGCMQ@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sun, Sep 13, 2020 at 10:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add new version of mmap event. The MMAP3 record is an
> > augmented version of MMAP2, it adds build id value to
> > identify the exact binary object behind memory map:
> >
> >   struct {
> >     struct perf_event_header header;
> >
> >     u32                      pid, tid;
> >     u64                      addr;
> >     u64                      len;
> >     u64                      pgoff;
> >     u32                      maj;
> >     u32                      min;
> >     u64                      ino;
> >     u64                      ino_generation;
> >     u32                      prot, flags;
> >     u32                      reserved;

I guess we need reserved _after_ buildid, no?

> >     u8                       buildid[20];
>
> Do we need maj, min, ino, ino_generation for mmap3 event?
> I think they are to compare binaries, then we can do it with
> build-id (and I think it'd be better)..

+1 we shouldn't need maj, min, etc.

Thanks,
Song

[...]
