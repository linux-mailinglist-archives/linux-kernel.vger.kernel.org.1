Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384F02B2458
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKMTSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:18:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:8607 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKMTSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:18:24 -0500
IronPort-SDR: FGyAQhm5QpLQBM4ZI++cX+tZcVuT+4DkUBeHVbNC6c2yeCKFxbCrsSggljWUu9J4BUAqAlG+DG
 v5LizxMOZikg==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232136849"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232136849"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 11:18:06 -0800
IronPort-SDR: iVmmRtd9iz+j1yeLIfDQPZK/dON7Rpe1JyQsIxRNU24ZxR2Ib0AiLUM+rS0Ok8+pofZF8G9aye
 k9L3Kou6x2vg==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="357620057"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 11:18:06 -0800
Date:   Fri, 13 Nov 2020 11:18:04 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Sam Xi <xyzsam@google.com>
Subject: Re: [PATCH] perf stat: Use proper cpu for shadow stats
Message-ID: <20201113191804.GH894261@tassilo.jf.intel.com>
References: <20201113050236.175141-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113050236.175141-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   CPU0      109,621,384      cycles
>   CPU1      159,026,454      cycles
>   CPU2       99,460,366      cycles
>   CPU3      124,144,142      cycles
>   CPU0       44,396,706      instructions      #    0.41  insn per cycle
>   CPU1      120,195,425      instructions      #    0.76  insn per cycle
>   CPU2       44,763,978      instructions      #    0.45  insn per cycle
>   CPU3       69,049,079      instructions      #    0.56  insn per cycle
> 
>        1.001910444 seconds time elapsed

Yes makes a lot of sense. Thanks for tracking that down.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
