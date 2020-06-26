Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF420BC05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 23:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgFZV6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 17:58:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:57247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgFZV6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:58:01 -0400
IronPort-SDR: BJHnpWhAfyXCaKFpKf2GTxUcbuIREp8G1uf+WeuA0eJi0mLM+xqEUvqc4BKR4QcETytIFK8q1V
 tXM4THXS0zkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143001176"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="143001176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 14:58:00 -0700
IronPort-SDR: NSAyYbDiA+tJ5jsIFgTWYxItlBUAdbRRKZJmDvJ7X1geYoQb2irFqU0HDwl7NGBzGNlYk+JXp3
 jnPlv40/pwvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="354893275"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 26 Jun 2020 14:57:59 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E2024301B9F; Fri, 26 Jun 2020 14:57:59 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:57:59 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
Message-ID: <20200626215759.GG818054@tassilo.jf.intel.com>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626212522.GF818054@tassilo.jf.intel.com>
 <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The name could be a metric or an event, the logic for each is quite

I would say collisions are unlikely. Event names follow quite structured
patterns.

> different. You could look up an event and when it fails assume it was
> a metric, but I like the simplicity of this approach.

I don't think it's simpler for the user.

> Maybe this
> change could be adopted more widely with something like "perf stat -e
> metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
> 1000".

I thought about just adding metrics to -e, without metric: of course.

-Andi
