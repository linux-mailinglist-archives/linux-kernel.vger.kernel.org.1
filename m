Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B82D98AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407907AbgLNNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407824AbgLNNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:22:28 -0500
Date:   Mon, 14 Dec 2020 10:22:00 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607952108;
        bh=YvPRAoFh/1PBbqqsdrT/ENiurC/6qbev1hpAYS1UY4Y=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENwTOFYH79YKK7/LlwtDZFkByo25692cNzLsUJwEjOjv9znwqbJAdFJbffSUONHDQ
         oj8CVLondrW8mAnG8PJaH8nN1jTt8qp+v+DfBIpPwRAfRRd980iPMKOXfO3gvoPJz4
         tDsiLHzh2uEroABGur3EVt8xtqjPb76wXVi3cC1I/hyGZIM2PKRsRHre290Trpj8Wx
         jpKeNdkKU8jJ06uzkVWFRBCvWx1C4Ll/O88PiOTjwPcChKIrJAY770AfuhzLVUtmUJ
         +yWVtJ9+DPBaE/uN7tNOux9HGgATRsepOP6A8m0i/DXMby5/svfY37oHc6cP1NYhP7
         9t81ZK3VXu+4w==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] perf evlist: Support pipe mode display
Message-ID: <20201214132200.GB238399@kernel.org>
References: <20201210061302.88213-1-namhyung@kernel.org>
 <20201210061302.88213-2-namhyung@kernel.org>
 <20201213230035.GC502638@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213230035.GC502638@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 12:00:35AM +0100, Jiri Olsa escreveu:
> On Thu, Dec 10, 2020 at 03:13:02PM +0900, Namhyung Kim wrote:
> > Likewise, perf evlist command should print event attributes by reading
> > PERF_RECORD_HEADER_ATTR records.
> > 
> > Before:
> >   $ perf record -o- true | ./perf evlist -i-
> >   (prints nothing)
> > 
> > After:
> >   $ perf record -o- true | ./perf evlist -i-
> >   cycles:pppH
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>


Thanks, applied.

- Arnaldo

