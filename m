Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB132B3505
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKONI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:08:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:39378 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgKONI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:08:26 -0500
IronPort-SDR: MLGlA74Tl0bhrMGuIDUDFg/QzesftYiATw1WvyK/mgR/EBG/ZWzeyef6/xRtO06CEY+bmq0S7S
 6gHd4lxndiIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="232266403"
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="232266403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 05:08:25 -0800
IronPort-SDR: MfLy4R2hZuIqC/KrcMslYzK0ROgSvqwgCA/ikRy8lUv1dxGtH2xGVN/oh3St3Z0aDOHjUpzvjz
 hlDmLrKm6ibg==
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="543247469"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 05:08:25 -0800
Date:   Sun, 15 Nov 2020 05:08:24 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf stat: Take cgroups into account for shadow stats
Message-ID: <20201115130824.GM894261@tassilo.jf.intel.com>
References: <20201114023643.211313-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114023643.211313-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually thinking about it more you should probably pass around ctx/cgroup
in a single abstract argument. Otherwise have to change all the metrics
functions for the next filter too.
