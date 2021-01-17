Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46E2F9300
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbhAQOo5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Jan 2021 09:44:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:15609 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbhAQOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 09:44:49 -0500
IronPort-SDR: QfBnCkIn1dny/XqLK8kqiRZg4A+oooH7jZ5GPz11ZqbWJ+TVnZTkZOqgHcZgBuwDJiAviuwy8K
 CncovBQOqWYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="240263202"
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="scan'208";a="240263202"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 06:44:07 -0800
IronPort-SDR: PHLTqQLErwFSKoss1laPyL9cYqZ37JqPDaftn7REW/aEF+gQ1mzYDu+OFfgwCY9MBDVpPF1Pbv
 UxP1qSX26T3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="scan'208";a="570470386"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2021 06:44:07 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 06:44:06 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 22:44:04 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Sun, 17 Jan 2021 22:44:04 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: RE: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
Thread-Topic: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
Thread-Index: AQHW63mj1W3psy/8iU6QoBa8JyfUwKop5ljg///IXYCAAjXjwA==
Date:   Sun, 17 Jan 2021 14:44:04 +0000
Message-ID: <b27f97d12329452bb95c1345a0bbdd3f@intel.com>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-2-rui.zhang@intel.com>
 <YAH1DPNLltqN4zFR@hirez.programming.kicks-ass.net>
 <dfc2fc320c96408e86c2f23b21979a5b@intel.com>
 <YALgm2b0YNkO7Qtd@hirez.programming.kicks-ass.net>
In-Reply-To: <YALgm2b0YNkO7Qtd@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Saturday, January 16, 2021 8:48 PM
> To: Zhang, Rui <rui.zhang@intel.com>
> Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> kan.liang@linux.intel.com; ak@linux.intel.com
> Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
> Importance: High
> 
> On Sat, Jan 16, 2021 at 08:19:35AM +0000, Zhang, Rui wrote:
> >
> >
> > > -----Original Message-----
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Sent: Saturday, January 16, 2021 4:03 AM
> > > To: Zhang, Rui <rui.zhang@intel.com>
> > > Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> > > alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> > > namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> > > kan.liang@linux.intel.com; ak@linux.intel.com
> > > Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
> > > Importance: High
> > >
> > > On Fri, Jan 15, 2021 at 05:22:07PM +0800, Zhang Rui wrote:
> > > > In the RAPL ENERGY_COUNTER MSR, only the lower 32bits represent
> > > > the energy counter, and the higher 32bits are reserved.
> > > >
> > > > Add the MSR mask for these MSRs to fix a problem that the RAPL PMU
> > > > events are added erroneously when higher 32bits contain non-zero
> value.
> > >
> > > Why would these high bits be non-zero?
> >
> > On SPR platform, the high bits of Psys energy counter are reused for other
> purpose.
> > High bits for other RAPL domains energy counters still return 0.
> >
> > I didn't mention this because I thought this patch should be okay as a
> generic fix.
> 
> But it doesn't fix anything.. there's not anything broken, except on that daft
> SPR thing.

Well, yes.
Before SPR, this is just a potential issue. But things on SPR suggests that this potential issue may become a real one.
So are you suggesting me to also include the SPR information as the justification of this patch?

Thanks,
rui
