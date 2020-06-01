Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511BB1EB248
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgFAXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 19:37:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:35790 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgFAXhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:37:33 -0400
IronPort-SDR: pzFqz6AXy3aAmN+R1DT9XDh1ZAKGolt22Zpj1u3nvgbpDnB02PeGgIFU/qzw1/AsjDbqpzgE3z
 ++pPGjzBtLlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 16:37:33 -0700
IronPort-SDR: vvL2Lps+K9jGjKC4llNqRQeeD7mgnGfmsRhdPfouypantp5TMVUI1fsJ3dwLJ4xdr5anl7XQJn
 NPQr4wImOMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="444465628"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2020 16:37:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E9EDB301C5F; Mon,  1 Jun 2020 16:37:32 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:37:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
Message-ID: <20200601233732.GA691017@tassilo.jf.intel.com>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
 <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
 <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
 <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > or a pathname, or including also the event default of "disabled".
> 
> For my cases conversion of pathnames into open fds belongs to external
> controlling process e.g. like in the examples provided in the patch set.
> Not sure about "event default of 'disabled'"

It would be nicer for manual use cases if perf supported the path names
directly like in Adrian's example, not needing a complex wrapper script.

-Andi
> 
> > 
> > e.g. add "--control" and support all of:
> > 
> > --control
> > --control 11
> > --control 11,15
> > --control 11,15,disabled
> > --control 11,,disabled
> > --control /tmp/my-perf.fifo
> > --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
> > --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
> > --control /tmp/my-perf.fifo,,disabled
> > 
> > Regards
> > Adrian
> > 
> 
> Regards,
> Alexey
> 
