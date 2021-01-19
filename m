Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31812FAEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394524AbhASCs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:48:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:17797 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbhASCsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:48:51 -0500
IronPort-SDR: rVTY+pv7nd30aUIYwRCzPlO/ZQAPXrf+qqOU6kX7E3NG2pBPnP5Qs+VnfTOiNj3n/GEOqLQu1I
 HJBfTU9nIv4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="197571123"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="197571123"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 18:47:05 -0800
IronPort-SDR: QbnPoavpYIEOL8Av9ZMrn59/UhQXh2rRMRqLb2IBAjyvpfQFSi4BpC4csLZu6aEpGeBOpaLqeb
 Zcj+CrSEwDVw==
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="383763560"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 18:47:04 -0800
Date:   Mon, 18 Jan 2021 18:46:57 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
Message-ID: <20210119024657.GA3526@tassilo.jf.intel.com>
References: <20210118034323.427029-1-namhyung@kernel.org>
 <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
 <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
 <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net>
 <CAM9d7cg_Agin3C0iuigDzQjZEZNtVXPe9z9eaDZsdyNoVa_wxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg_Agin3C0iuigDzQjZEZNtVXPe9z9eaDZsdyNoVa_wxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't think I object to having an even in the stream, but your LOST
> > event is unfortunate in that it itself can get lost when there's no
> > space in the buffer (which arguably is unlikely, but still).
> >
> > So from that point of view, I think overloading LOST is not so very nice
> > for this.
> 
> But anything can get lost in case of no space.
> Do you want to use something other than the LOST event?

Could always reserve the last entry in the ring buffer for a LOST event,
that would guarantee you can always get one out.

-Andi
