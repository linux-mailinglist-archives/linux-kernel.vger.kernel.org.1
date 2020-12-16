Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B622DC1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLPOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLPOCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:02:00 -0500
Date:   Wed, 16 Dec 2020 11:01:33 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608127279;
        bh=MEIw5PsbXofDkOhD+FZDY4YnyLVat3Wjv/iN2/5FUMc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjJph53mY2NYGKk71bzgstYAzcb2hvL/U83C32eF6VB+0Z9cCDA4IGbTwgvhGcq3K
         F0ILMpiFjrtIOr7ELre2GRO0hEK1DIOTZF7pYqP0nPMl6SrrJb84/2KK++SdRY8gQh
         3chQeRiiIY2NKgKh+EAkH23bglhvWHlz6XNph+TjM04IiCUgHwp5dAKwt0abtSmzpL
         OTeIa5DZA6jP1soRIbZ00xAAheiKvPt42JGvwgpbVBaMgtcfNaCSVNKL/pokR0kY9+
         pTHtIt/rT9zORw4WbGYGpkUke7wRxxxeRDleKWOmE8feqXNPBDWT1DlAtR18isZnRH
         GU0CS4r+t6wJg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [BUG] jevents problem when cross building Re: [PATCH 2/3] perf
 tools: Allow to enable/disable events via control file
Message-ID: <20201216140133.GB294100@kernel.org>
References: <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava>
 <20201210171503.GA195565@kernel.org>
 <20201210171903.GB195565@kernel.org>
 <20201210172608.GC195565@kernel.org>
 <30e7907d-868a-a673-59a7-3bb4766093b4@huawei.com>
 <20201210181708.GD195565@kernel.org>
 <1a608e92-d0d0-2e5e-ba7e-e9fa2e02b0f9@huawei.com>
 <650baaf2-36b6-a9e2-ff49-963ef864c1f3@huawei.com>
 <3323c9fa-3e71-2426-4f53-f6740fa71112@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3323c9fa-3e71-2426-4f53-f6740fa71112@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 16, 2020 at 11:41:10AM +0000, John Garry escreveu:
> On 10/12/2020 19:57, John Garry wrote:
> > Obviously I never tested building for one of test architectures which
> > does not use PMU events - sorry!
 
> Just wondering if you have had any more problems here? Shall I send a formal
> patch? I tested that change and it looked ok.

I thought I had replied to this, I'll check my logs, but yeah, it fixed
the problem, I folded into the cset that caused the problem, all my
tests are Ok now and I've pushed it out to perf/core on git.kernel.org.

Thanks!

- Arnaldo
