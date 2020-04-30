Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268291BEE10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 04:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgD3CJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 22:09:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:43401 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgD3CJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:09:02 -0400
IronPort-SDR: JJQalPwEsayv6UwnqOebbrTxeM+fgFr3y+HoOkUQpvPkC8jj6Vv+sEJqgd374U0/0nvhYjEKYt
 UGrjBZGhyRMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 19:09:01 -0700
IronPort-SDR: zBgAtl8/TZEyl3/1bRQfDWBdxpFSgnk1pqExldm0ubv31vBu/ATCmg7epE00CadkKK/EBaWmYZ
 mLVvSnkxADDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="405242122"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2020 19:09:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C52C8301AAA; Wed, 29 Apr 2020 19:09:01 -0700 (PDT)
Date:   Wed, 29 Apr 2020 19:09:01 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH] perf/script: remove extraneous newline in
 perf_sample__fprintf_regs()
Message-ID: <20200430020901.GC874567@tassilo.jf.intel.com>
References: <20200418231908.152212-1-eranian@google.com>
 <20200428024744.GA703870@tassilo.jf.intel.com>
 <CABPqkBQkmPOM7xRkXFbtAtcLVdoJ=XY6uG3k3FoEAWABJaSCQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQkmPOM7xRkXFbtAtcLVdoJ=XY6uG3k3FoEAWABJaSCQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I was under the impression that perf script was generating one line
> per sample. Otherwise, seems hard to parse.

That's only true for simple cases. A lot of the extended output options
have long generated multiple lines. And of course call stacks always did.

> Could you give me the cmdline options of perf script that justify the newline.

e.g.  perf script -F iregs,uregs

-Andi
