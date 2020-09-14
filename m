Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF2269164
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgINQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgINQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:20:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8A4206A4;
        Mon, 14 Sep 2020 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600100433;
        bh=dFrCdz3RXDvLvjPCdC9plqXVEKCgDyuw4Rrl1xvBiGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ0HGb6o9MqQIFRjnxDG8pGcZl2tZwDi29aKPHaB7Kw1/f0PVmTNGMh7HYAUgdcJ4
         3scGoYTREMUqteuMrm+efUBzvQhPqGJPsVg6CwYhVstyG4RW3y90xaBoxEl/lS0nAs
         SvKRldUDCIOLCeZc0rizWZLDPVFrZihU4euLhycM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0CA540D3D; Mon, 14 Sep 2020 13:20:30 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:20:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V3 0/4] TopDown metrics support for Ice Lake (perf tool)
Message-ID: <20200914162030.GA166601@kernel.org>
References: <20200911144808.27603-1-kan.liang@linux.intel.com>
 <CAM9d7cgnMcER9ZgB8jg4bHUuyf7h2HL47HD4=H+O-L165opShg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgnMcER9ZgB8jg4bHUuyf7h2HL47HD4=H+O-L165opShg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 09:51:03PM +0900, Namhyung Kim escreveu:
> On Fri, Sep 11, 2020 at 11:51 PM <kan.liang@linux.intel.com> wrote:
> > Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
> > TopDown metrics.

> > Andi Kleen (2):
> >   perf stat: Support new per thread TopDown metrics
> >   perf, tools: Add documentation for topdown metrics

> > Kan Liang (2):
> >   perf tools: Rename group to topdown
> >   perf record: Support sample-read topdown metric group

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
