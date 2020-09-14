Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C0268D68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgINOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgINOVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:21:22 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442362193E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600093282;
        bh=8fsFkxwq8ohGgDnSkTJRE8LxrldUSn3FHaVg9MHbuOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kua/74Z4bw7iHP3Y1dF2lBS/HOEFeyN6JIuVp3wYVeThQhYWv2+/2UL/hi5ANVjyq
         jTh0E5MRclUBNJ8U9/kwHLXZttTj3UWGg5wEY3dmci48H68ATE7oA/lxTXWglot0Ht
         H7P3PvF4O0/lS94ZLdiBj2LW+19pMeE9qFg7xgiQ=
Received: by mail-oi1-f175.google.com with SMTP id i17so12591oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:21:22 -0700 (PDT)
X-Gm-Message-State: AOAM533G7r+KeQS4MJbuNoV87zuPU8vEYcCDyzZNGjMgZHcKc66+boMy
        m7VGmC4JXa7rHucSCQ/DjWRQoQEDcTt2aMF6gg==
X-Google-Smtp-Source: ABdhPJye0QRCFqsF4MQijGViYqR+J8o9d4tiYkg+saM4x13nKJ5US1HIjANQvep4uY7KQjM/S2B5O2BsnlEfVpLwO/s=
X-Received: by 2002:aca:1711:: with SMTP id j17mr9162610oii.152.1600093281588;
 Mon, 14 Sep 2020 07:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200912205317.GG1714160@krava>
In-Reply-To: <20200912205317.GG1714160@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Sep 2020 08:21:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwMh9=ppdbY0sAQ8C--aH_XcJR3G4YCq7afAHnfTF9fw@mail.gmail.com>
Message-ID: <CAL_JsqKwMh9=ppdbY0sAQ8C--aH_XcJR3G4YCq7afAHnfTF9fw@mail.gmail.com>
Subject: Re: [PATCH v3 0/10] libperf and arm64 userspace counter access support
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 2:53 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Sep 11, 2020 at 03:51:08PM -0600, Rob Herring wrote:
> > This is resurrecting Raphael's series[1] to enable userspace counter
> > access on arm64. My previous versions are here[2][3].
> >
> > Changes in v3:
> >  - Dropped removing x86 rdpmc test until libperf tests can run via 'perf test'
> >  - Added verbose prints for tests
> >  - Split adding perf_evsel__mmap() to separate patch
>
> hi,
> which commit/branch did you base on? I can't apply arm bits:
>
> Applying: arm64: pmu: Add hook to handle pmu-related undefined instructions
> Applying: arm64: perf: Enable pmu counter direct access for perf event on armv8
> error: patch failed: arch/arm64/kernel/perf_event.c:836
> error: arch/arm64/kernel/perf_event.c: patch does not apply
> Patch failed at 0002 arm64: perf: Enable pmu counter direct access for perf event on armv8

It's on v5.9-rc2.

Rob
