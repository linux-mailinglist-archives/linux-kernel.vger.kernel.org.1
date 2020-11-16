Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFD2B466D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgKPOyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:54:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:31603 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgKPOyA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:54:00 -0500
IronPort-SDR: Lc1Kinf5u41R787EDdjstzAdkkYcbRhstwfwVWISYQKDwWW3YuCloAa3JklNj6virHMqiBa2ao
 iJYcppiuWqEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="150025052"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="150025052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:53:57 -0800
IronPort-SDR: 4D3M3GrfcY3OGBuGYQE/mG5d7U2ks71wToYrCxIwJ+7269hMa00wyh2I1L3cyWPO78+4X5FXIR
 b9MEk69W5Jiw==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="367727077"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:53:57 -0800
Date:   Mon, 16 Nov 2020 06:53:55 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
Message-ID: <20201116145355.GU894261@tassilo.jf.intel.com>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
 <38be0597-7f93-0aa1-b4c5-3c7f23b74f13@linux.intel.com>
 <20201115133558.GN894261@tassilo.jf.intel.com>
 <CAP-5=fW-9oj4PK=hBmvrCqfzLnoqTe502FRb74Jwqpo+3KoJKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW-9oj4PK=hBmvrCqfzLnoqTe502FRb74Jwqpo+3KoJKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    I'd prefer if we could make a copy of these scripts into the kernel tree
>    along with the data files from:
>    https://download.01.org/perfmon/

FWIW I originally tried this to include the raw JSON files, but Ingo objected
and wanted the files to be split up[1] and avoiding redundant headers. 
That's why we ended up with the "compiled" format.

[1] https://lkml.org/lkml/2015/5/28/336

>    Having a generated file that can't be edited, reviewed, .. I also worry
>    that if/when we change the json format then event-converter-for-linux-perf
>    will need to support a multitude of perf versions.

You mean for backports? The assumption was that perf backports would backport
any perf changes for new formats too.

In general I generally discourage any perf tools backport, people should just use
a new version of the perf tool on old kernels.

In principle the scripts could be included, but without the raw files it would
be somewhat pointless.

-andi
