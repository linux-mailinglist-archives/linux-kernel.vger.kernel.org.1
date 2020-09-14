Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FC2691E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgINQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgINPNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:13:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39BDB20829;
        Mon, 14 Sep 2020 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600096393;
        bh=2n6xn1dNb+jBWIYWoXM59/cL0r2SN9OLGc/w/yYX4lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX21HqYOSTW7DxJJi9tuQNthrvklblenjRZ8AKtZedFGn5cnOcyTnun31WvqoZvUu
         vt/mlbJvtmTMtGM+Rx2kQUQeVHlUaFraOTtA7nKxTyzGlBe6INrZLXSaayWu4LpVSr
         Q1/eyCA5lY3hFIeaFqEteERMOwqykEL70biA9hwA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1370440D3D; Mon, 14 Sep 2020 12:13:11 -0300 (-03)
Date:   Mon, 14 Sep 2020 12:13:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [RFC 00/26] perf: Add mmap3 support
Message-ID: <20200914151310.GA160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <CAM9d7ci4VUuAguynK76Zd7YSnNoAErsgabucUjb3qcuXj5m7Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci4VUuAguynK76Zd7YSnNoAErsgabucUjb3qcuXj5m7Pg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 02:25:25PM +0900, Namhyung Kim escreveu:
> On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > while playing with perf daemon support I realized I need
> > the build id data in mmap events, so we don't need to care
> > about removed/updated binaries during long perf runs.

> > This RFC patchset adds new mmap3 events that copies mmap2
> > event and adds build id in it. It makes mmap3 the default
> > mmap event for synthesizing kernel/modules/tasks and adds
> > some tooling enhancements to enable the workflow below.

> Cool! It's nice that we can skip the final build-id collection stage
> with this while data size will be bigger.

Yeah, this is something long overdue, comes with extra cost for people
not wanting build-ids, but then they can just use MMAP2 or even MMAP if
that is enough.

More comments on the other patches.

- Arnaldo
