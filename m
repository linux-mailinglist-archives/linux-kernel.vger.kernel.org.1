Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5674A2B0F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKLUjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgKLUjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:39:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B60C216C4;
        Thu, 12 Nov 2020 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605213594;
        bh=HzMiKq9A/i4kjo48D727cdLmgIACBPKIT2rdg3Wsk34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgLA807vDygo60JfvjQM4TBcySje0QzuP7RpTTY06VU8MSpE5bLKzFOVvCAOyze6d
         mXcdayOOorj6p7T+hO7YNPY8VTpO/H2BH4TRAyA04535ZJXR5Fd/oeAWoMnDO6V+XO
         jjcIrgmJrSkPhKgyIBkwH9CA2cxKQzheEzdvEGyY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FB4E411D1; Thu, 12 Nov 2020 17:39:52 -0300 (-03)
Date:   Thu, 12 Nov 2020 17:39:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/24] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201112203952.GA393548@kernel.org>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-25-jolsa@kernel.org>
 <20201111170046.GB466880@tassilo.jf.intel.com>
 <20201112115710.GE619201@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112115710.GE619201@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 12, 2020 at 12:57:10PM +0100, Jiri Olsa escreveu:
> On Wed, Nov 11, 2020 at 09:00:46AM -0800, Andi Kleen wrote:
> > On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> > > Adding --buildid-mmap option to enable build id in mmap2 events.
> > > It will only work if there's kernel support for that and it disables
> > > build id cache (implies --no-buildid).

> > What's the point of the option? Why not enable it by default
> > if the kernel supports it?
 
> > With the option most user won't get the benefit.
 
> > The only reason I can think of for an option would be to disable
> > so that old tools can still process.
 
> yes, that was request in the rfc post, we want the new default
> perf.data be still readable by older perf tools

We need to change perf so that when it finds some option it doesn't
grok, it just ignores extra things in a record like MMAP2 and just warns
the user that things are being ignored.

So that we can add new stuff by default without requiring an ever longer
command line option, like with --all-cgroups, etc.

And provide the options to avoid using new stuff if we know that the
perf.data file will be processed by someone with an older tool that
can't update.

- Arnaldo
