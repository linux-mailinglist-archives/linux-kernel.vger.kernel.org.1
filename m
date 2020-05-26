Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5031BB423
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD1Crp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 22:47:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:21588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgD1Cro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:47:44 -0400
IronPort-SDR: +Ga1UgSlbW8FPEo41r0AB+0ny+BMs/j+BhdV5K/GKyZvgJTeHyl8XbW+ECy8uhK/gJ4v3iBORE
 9OA7NX+dLfAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 19:47:44 -0700
IronPort-SDR: WUy7Ml9OpMwqewlj0CA3nQMy8vgjApChiB0WwhLzBf1Y/8ICVCC3IobYn+MtLLcveRZiY6VbmU
 X747U76pT5qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="275687726"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2020 19:47:44 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 52280301A71; Mon, 27 Apr 2020 19:47:44 -0700 (PDT)
Date:   Mon, 27 Apr 2020 19:47:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        acme@redhat.com, jolsa@redhat.com, irogers@google.com,
        kan.liang@intel.com
Subject: Re: [PATCH] perf/script: remove extraneous newline in
 perf_sample__fprintf_regs()
Message-ID: <20200428024744.GA703870@tassilo.jf.intel.com>
References: <20200418231908.152212-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418231908.152212-1-eranian@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 04:19:08PM -0700, Stephane Eranian wrote:
> When printing iregs, there was a double newline printed because
> perf_sample__fprintf_regs() was printing its own and then at the
> end of all fields, perf script was adding one.
> This was causing blank line in the output:

I don't think the patch is quite correct because there could be
other fields after it, and they need to be separated by a 
new line too.

e.g. i suspect if someone prints iregs,uregs or iregs,brstack
or something else that is printed in process_event after *regs
you would get garbled output.

So you have to track if the newline is needed or not.

-Andi
