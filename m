Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9F2F1B33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbhAKQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:41:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:39838 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbhAKQlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:41:14 -0500
IronPort-SDR: fpE9PYAcfWlhKyljkrAHLe9X+Sb7+axLGKLb96CGT2qn7rJxxkPs74BLrHmRDDLHFytpEP7GHv
 vP6rNsQU32lQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="241965016"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="241965016"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 08:39:28 -0800
IronPort-SDR: okmijB6pK3Lhm52pmv0ELX5gRiRSZd8ahVZvHV+DGR1zNO9zoLalHFWpdKIHNqG59+5rYf242o
 m/h8Xs3084kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464214361"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 08:39:24 -0800
Received: from [10.254.78.146] (kliang2-MOBL.ccr.corp.intel.com [10.254.78.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D723658090E;
        Mon, 11 Jan 2021 08:39:22 -0800 (PST)
Subject: Re: [PATCH 0/2] perf/x86/intel/uncore: Derive die id from NUMA info
 with more than 8 nodes
To:     Steve Wahl <steve.wahl@hpe.com>, rja_direct@groups.int.hpe.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     "Liang, Kan" <kan.liang@intel.com>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fa012ba7-714a-00bc-257c-62f7ddcde7fc@linux.intel.com>
Date:   Mon, 11 Jan 2021 11:39:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108153549.108989-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2021 10:35 AM, Steve Wahl wrote:
> For Intel uncore, the registers being used to identify the die don't
> contain enough bits to uniquely identify more than 8 dies.  On
> systems with more than 8 dies, this results in error messages of the
> form "skx_uncore: probe of XXXX:XX:XX.X failed with error -22", and
> some perf counters showing up as "<not supported>".
> 
> On such systems, use NUMA information to determine die id.
> 
> Continue to use the register information with 8 or fewer numa nodes to
> cover cases like NUMA not being enabled.
> 
> The first patch moves translation from physical to logical die id
> earlier in the code, and stores only the logical id.  The logical id
> is the only one that is really used.  Without this change the second
> patch would have to store both physical and logical id, which was much
> more complicated.
> 
> The second patch adds the alternative of deriving the logical die id
> from the NUMA information when there are more than 8 nodes.
> 
> Steve Wahl (2):
>    perf/x86/intel/uncore: Store the logical die id instead of the
>      physical die id.
>    perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA
>      info
> 
>   arch/x86/events/intel/uncore.c       |  58 +++++---------
>   arch/x86/events/intel/uncore.h       |   5 +-
>   arch/x86/events/intel/uncore_snb.c   |   2 +-
>   arch/x86/events/intel/uncore_snbep.c | 114 ++++++++++++++++++---------
>   4 files changed, 99 insertions(+), 80 deletions(-)
> 

Thanks Steve for working on the issue. The patch set looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
