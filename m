Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373CC2B3503
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKONF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:05:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:45656 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgKONF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:05:26 -0500
IronPort-SDR: TvmTn46vySo7pcxa47A5u9mYhZuP+Xc79DOOsTZ3zInTPUYNsSONV354cKhgb0Hlm1KaEJA3CD
 dBKb/x2o+VBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="188686986"
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="188686986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 05:05:25 -0800
IronPort-SDR: M5fUKI7iZIgMhYqL/ymWNDzdoK+ygXYGPr0w85UP00EhfFJDNnrMpgKWtZ2CF8LdNg41YT1NV+
 /fHa66mBenjQ==
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="475234796"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 05:05:25 -0800
Date:   Sun, 15 Nov 2020 05:05:24 -0800
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
Message-ID: <20201115130524.GL894261@tassilo.jf.intel.com>
References: <20201114023643.211313-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114023643.211313-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -57,6 +59,9 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
>  	if (a->ctx != b->ctx)
>  		return a->ctx - b->ctx;
>  
> +	if (a->cgrp != b->cgrp)
> +		return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;

This means the sort order will depend on heap randomization, 
which will make it harder to debug.

Better use something stable like the inode number of the cgroup.

Do we have the same problem with other filters?

The rest of the patch looks good to me.

-Andi
