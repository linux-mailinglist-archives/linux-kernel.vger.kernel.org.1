Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF12B3510
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKONgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:36:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:38747 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgKONgA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:36:00 -0500
IronPort-SDR: a3N91jvkPWzm9T5apkvTonmqdsO+1V88PhL5girCHeODo0PZusJ0Xqib7kAJVUi/orTB3JT24o
 su7yG7iio63g==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="169867793"
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="169867793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 05:35:59 -0800
IronPort-SDR: OXyplTdUA374csWsx2LSh0va392bqSob2IUPRE1GFOcsb1BSEFKLEwAoiyK58ey4hhI2lvobbU
 xzWhM5PtHi3A==
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="475242634"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 05:35:59 -0800
Date:   Sun, 15 Nov 2020 05:35:58 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>, yao.jin@intel.com,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
Message-ID: <20201115133558.GN894261@tassilo.jf.intel.com>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
 <38be0597-7f93-0aa1-b4c5-3c7f23b74f13@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38be0597-7f93-0aa1-b4c5-3c7f23b74f13@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can I get ACK for this patch?
> 
> It's mainly for fixing the perf-test issue and MEM_Parallel_Reads issue.

Acked-by: Andi Kleen <ak@linux.intel.com>

The JSON updates should be imho just merged automatically. Not much
point in doing code review on them. If there's a problem it has 
to be fixed JSON upstream anyways.

-Andi
