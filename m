Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C592E2F92F9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbhAQOfC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Jan 2021 09:35:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:56538 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbhAQOed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 09:34:33 -0500
IronPort-SDR: TmS50h5wLTjw7oqOp9gTeIyQPgJvry0KqUDttWfGTdyjhvf3H0ud4+2SRR8+uJyH6k2x+4liQI
 a9e8pvpOjBrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9866"; a="242790362"
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="scan'208";a="242790362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 06:33:50 -0800
IronPort-SDR: RPqjWVHwsC5ft9BNkhoG1R29mVjo8zKXyw6/KP64N2FGi3yMfpJFt4oBp1Ez0KxBYk6bHbwptb
 IM/4ADIT/DUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="scan'208";a="401801483"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2021 06:33:49 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 06:33:48 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 22:33:46 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Sun, 17 Jan 2021 22:33:46 +0800
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
Subject: RE: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
Thread-Topic: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
Thread-Index: AQHW7AYrkGH2U5eXgkirITO4BW5mdaorx78A
Date:   Sun, 17 Jan 2021 14:33:46 +0000
Message-ID: <70b71922e7f84234be70c7104969331f@intel.com>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-3-rui.zhang@intel.com>
 <YALhAmTgMHxEgeG4@hirez.programming.kicks-ass.net>
In-Reply-To: <YALhAmTgMHxEgeG4@hirez.programming.kicks-ass.net>
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

Hi, Peter,

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Saturday, January 16, 2021 8:50 PM
> To: Zhang, Rui <rui.zhang@intel.com>
> Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> kan.liang@linux.intel.com; ak@linux.intel.com
> Subject: Re: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
> platform
> Importance: High
> 
> On Fri, Jan 15, 2021 at 05:22:08PM +0800, Zhang Rui wrote:
> > There are several things special for the RAPL Psys energy counter, on
> > Intel Sapphire Rapids platform.
> > 1. it contains one Psys master package, and only CPUs on the master
> >    package can read valid value of the Psys energy counter, reading the
> >    MSR on CPUs in the slave package returns 0.
> > 2. The master package does not have to be Physical package 0. And when
> >    all the CPUs on the Psys master package are offlined, we lose the Psys
> >    energy counter, at runtime.
> > 3. The Psys energy counter can be disabled by BIOS, while all the other
> >    energy counters are not affected.
> >
> > It is not easy to handle all of these in the current RAPL PMU design
> > because
> > a) perf_msr_probe() validates the MSR on some random CPU, which may
> either
> >    be in the Psys master package or in the Psys slave package.
> > b) all the RAPL events share the same PMU, and there is not API to remove
> >    the psys-energy event cleanly, without affecting the other events in
> >    the same PMU.
> >
> > This patch addresses the problems in a simple way.
> >
> > First, by setting .no_check bit for RAPL Psys MSR, the psys-energy
> > event is always added, so we don't have to check the Psys
> > ENERGY_STATUS MSR on master package.
> >
> > Then, rapl_not_visible() is removed because 1. it is useless for RAPL
> > MSRs with .no_check cleared, because the
> >    .is_visible() callbacks is always overridden in perf_msr_probe().
> > 2. it is useless for RAPL MSRs with .no_check set, because we actually
> >    want the sysfs attributes always be visible for those MSRs.
> >
> > With the above changes, we always probe the psys-energy event on Intel
> > SPR platform. Difference is that the event counter returns 0 when the
> > Psys RAPL Domain is disabled by BIOS, or the Psys master package is
> offlined.
> 
> Maybe I'm too tired, but I cannot follow. How does this cure the fact that the
> rapl_cpu_mask might not include that master thing. And how can software
> detect what the master thing is to begin with?

To make things simple, I ignore the master thing, and probe the psys-energy counter blindly on SPR.
So rapl_cpu_mask still includes all the online CPUs.
This means that psys-energy is "valid" on all packages, and it just returns different values on different packages.
AKA, whole system power consumption on Psys master package, and Zero on Psys slave packages.

Not sure if I answered your question or not.

Thanks,
rui
