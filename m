Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F982F8C34
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 09:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAPIUW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 16 Jan 2021 03:20:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:29856 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbhAPIUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 03:20:21 -0500
IronPort-SDR: lG1AtSoZE6MxmB+hRogZYLFmsN1oPlkxyKyjPNTK0ZFQnSk85wa9OvcneoF3J0JxmGmb3mJLPF
 soQCzMmKqYNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="242721406"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="242721406"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 00:19:38 -0800
IronPort-SDR: Eg0Toc1M9TeXnMX6NPF3iACESND5MEmDDPSMYRHZEWdRa1Tt3miaRU0KZZBRJfjMhEyZ/FqgZf
 BFCWHrBYOWGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="346400223"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2021 00:19:38 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 16 Jan 2021 00:19:37 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 16 Jan 2021 16:19:35 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Sat, 16 Jan 2021 16:19:35 +0800
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
Thread-Index: AQHW63mj1W3psy/8iU6QoBa8JyfUwKop5ljg
Date:   Sat, 16 Jan 2021 08:19:35 +0000
Message-ID: <dfc2fc320c96408e86c2f23b21979a5b@intel.com>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-2-rui.zhang@intel.com>
 <YAH1DPNLltqN4zFR@hirez.programming.kicks-ass.net>
In-Reply-To: <YAH1DPNLltqN4zFR@hirez.programming.kicks-ass.net>
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
> Sent: Saturday, January 16, 2021 4:03 AM
> To: Zhang, Rui <rui.zhang@intel.com>
> Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> kan.liang@linux.intel.com; ak@linux.intel.com
> Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
> Importance: High
> 
> On Fri, Jan 15, 2021 at 05:22:07PM +0800, Zhang Rui wrote:
> > In the RAPL ENERGY_COUNTER MSR, only the lower 32bits represent the
> > energy counter, and the higher 32bits are reserved.
> >
> > Add the MSR mask for these MSRs to fix a problem that the RAPL PMU
> > events are added erroneously when higher 32bits contain non-zero value.
> 
> Why would these high bits be non-zero?

On SPR platform, the high bits of Psys energy counter are reused for other purpose.
High bits for other RAPL domains energy counters still return 0.

I didn't mention this because I thought this patch should be okay as a generic fix.

Thanks,
rui
