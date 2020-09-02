Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F825AC7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIBOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgIBNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:48:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE77BC061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2eWn70cvKHwjmwvoUiRDzH2BW9IOuObw3FKr69LZ4f8=; b=RowufVxN4uOHi/xqtqcHSLQ9Qg
        CVVf2YdOTg2YOVTdyy2ZqtyrI67y/QMh/oqJfJoB4ECzIu+P8WBwWdhyIUIBF8hNPLUzsHAavSnz0
        uhWeETwzOVZqvPJ7coi5fjgI3rZhYaHnTRoSE7nwO+7RVDLhQMP4LRa7Y4tF/bEBT1dykq7SRQS2I
        tTqB0We+gfJONqTS2Wrn7v/w60mYpn9ONyl2P+9lnrqsow6mq12a9QwlF3QfR7MP8cAMMUW3HZVbB
        vT35rS9j7pajHqKuDVCgl708tALo5bIiQTpluidFdK9tXJWmS9E9SasJK60Yk6y2S4s8zXi4WQjxH
        tCuvlMMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDT7P-0003kj-6K; Wed, 02 Sep 2020 13:48:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AEBE3056DE;
        Wed,  2 Sep 2020 15:48:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 283CB2127D319; Wed,  2 Sep 2020 15:48:05 +0200 (CEST)
Date:   Wed, 2 Sep 2020 15:48:05 +0200
From:   peterz@infradead.org
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] perf tsc: Add rdtsc() for Arm64
Message-ID: <20200902134805.GI1362448@hirez.programming.kicks-ass.net>
References: <20200902132131.36304-1-leo.yan@linaro.org>
 <20200902132131.36304-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902132131.36304-3-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:21:27PM +0100, Leo Yan wrote:
> The system register CNTVCT_EL0 can be used to retrieve the counter from
> user space.  Add rdtsc() for Arm64.

> +u64 rdtsc(void)
> +{
> +	u64 val;

Would it make sense to put a comment in that this counter is/could-be
'short' ? Because unlike x86-TSC, this thing isn't architecturally
specified to be 64bits wide.

> +	asm volatile("mrs %0, cntvct_el0" : "=r" (val));
> +
> +	return val;
> +}
> -- 
> 2.17.1
> 
