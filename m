Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4418D2CA981
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbgLARWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389109AbgLARWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:22:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x0XHf59KGZcgvn21tEeZCHzW0XTFgVINGVzfBJCJ+k0=; b=gNdPeg7MYayD7Lvs1w7OiBk/Rq
        AlCIZXFYLXTSjgwABuq+KqRG67cGfjUrJKgg2OXkmcc75g/fKxgcdvHBMwOa579syxyAPlLphD3Ve
        nHWRPn/TpBQlfwMcKhACZxUI3TU3pu6GPK7Ejzp5MwPNo4ut+f8yCyOSj1PpOPUKZMdhxqEK8Lf9y
        3q5GtPZQJfQV6HG097ZYIoqSdpMWhu+KuHgl4vCTXoUHHHY3EiYZ2cr3HWmV9eexeO7gKp6l00QwV
        NjXARxTve8cXZM0nfwCNCKACcHEI7D44fqNkDmj8oLEz+kKvYY2bBGlmoBJbGpsxHuA4zl5+FaG3G
        DZgvRsfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk9LW-0007KZ-OY; Tue, 01 Dec 2020 17:21:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD7DF30018A;
        Tue,  1 Dec 2020 18:21:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BA9E20103D72; Tue,  1 Dec 2020 18:21:43 +0100 (CET)
Date:   Tue, 1 Dec 2020 18:21:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH V2 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
Message-ID: <20201201172143.GS3040@hirez.programming.kicks-ass.net>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130193842.10569-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:38:40AM -0800, kan.liang@linux.intel.com wrote:
> +static DEFINE_PER_CPU(int, perf_sched_cb_usages);

% s/perf_sched_cb_usages/perf_sched_cb_usage/g
