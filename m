Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D282B4C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgKPRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbgKPRFz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:05:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1211620789;
        Mon, 16 Nov 2020 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546355;
        bh=uSeNifIg5XCm+1azktg72IpBuggN058yACIQFg1CkbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuhCzxr9VhPFH3XHDFZBBXD4YFKFadfGGVdsRKJKW6JsvCNDw+GmM+9TbR+LPQppM
         ei9Xo2hU/prRSjqDDwb66f8bYa+DA/r2W5A4cB+vKMIF991MEqpbTbj6PPK66tjEth
         1Ckv5mORhKSt34K0TOp1JfZTAU1gJ9qJgPVItQ2w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F48D411D1; Mon, 16 Nov 2020 14:05:53 -0300 (-03)
Date:   Mon, 16 Nov 2020 14:05:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, yao.jin@intel.com,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
Message-ID: <20201116170553.GG509215@kernel.org>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 06, 2020 at 01:21:58PM +0900, Namhyung Kim escreveu:
> On Fri, Nov 6, 2020 at 12:12 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > >
> > > It seems not applied to acme/perf/core cleanly.
> > >
> > > Thanks,
> > > Namhyung
> > >
> >
> > It seems the patch mail is truncated. :(
> >
> > I attach the patch file in the mail. Sorry for inconvenience.
> 
> I've checked it fixed the perf test on my laptop (skylake).
> 
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

