Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCF29757C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbgJWREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:04:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:39748 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbgJWREa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:04:30 -0400
IronPort-SDR: ufMj7GUvg3xgsef4KcMLZYeD6JUTL6NVx5hT03dUEtTuItBIxnTHt+9l5p7HKzkqnaa1m/AF0H
 5KwYnZBqhA2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="165113116"
X-IronPort-AV: E=Sophos;i="5.77,409,1596524400"; 
   d="scan'208";a="165113116"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 10:04:25 -0700
IronPort-SDR: fz42lWdLA6Y6mVtYrpGTQqgMgaXWL+n93Ha+OLjKlC2bO1ShORHed66BOkS1E7r91dT2C8R6e+
 Z4wU0jKBctqA==
X-IronPort-AV: E=Sophos;i="5.77,409,1596524400"; 
   d="scan'208";a="534474865"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 10:04:24 -0700
Date:   Fri, 23 Oct 2020 10:04:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf stat: Support regex pattern in --for-each-cgroup
Message-ID: <20201023170422.GS466880@tassilo.jf.intel.com>
References: <20201023074234.395002-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023074234.395002-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 04:42:34PM +0900, Namhyung Kim wrote:
> To make the command line even more compact with cgroups, support regex
> pattern matching in cgroup names.
> 
>   $ perf stat -a -e cpu-clock,cycles --for-each-cgroup '^.$' sleep 1

The example doesn't exactly show the benefit. So ^.$ would be only
for one character cgroups?

Missing documentation updates.

-Andi

