Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8E2F863F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbhAOUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbhAOUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:05:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6EC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jR4Z0QZqbVTnC1VKL7VW3Y7xnFPeU+uPaP6sUltjm/k=; b=n8ZvYLAiYTwTHlyt3/Ub7Lp4fm
        G275ZZoPGb8iAWKbYAWhcdVN34r0/w1mqRUE/guLT2UYYjuTW8vpYAjEaU/v15NWQ1k+TP/YHZ9du
        Ta4GFtQJD1s5I1Ht606ZRzKqj+n8VV5RpCJiwsoUNT2EwcfIdeojenJSLjx9oasIoXL7cV/pF94Wn
        Gol1k/amP0bOUYLHYiITG37Q0zKUv2+wVeYX7OgR+1RM2ulGZ89Bgxxr9rzrwC60Re5EvYdYW+jq9
        JOzrKpDAyyvJnaW3XS0p0oZKXKwOVCQjGrxWts4B3ervNx6BhkkLcyz0u2UT1vnCA6Y/fP0k5eZeK
        1QFZGZ9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0VJf-009Njo-FL; Fri, 15 Jan 2021 20:03:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE2BF305CC3;
        Fri, 15 Jan 2021 21:03:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 796C020291083; Fri, 15 Jan 2021 21:03:24 +0100 (CET)
Date:   Fri, 15 Jan 2021 21:03:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
Message-ID: <YAH1DPNLltqN4zFR@hirez.programming.kicks-ass.net>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-2-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115092208.20866-2-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:22:07PM +0800, Zhang Rui wrote:
> In the RAPL ENERGY_COUNTER MSR, only the lower 32bits represent the
> energy counter, and the higher 32bits are reserved.
> 
> Add the MSR mask for these MSRs to fix a problem that the RAPL PMU events
> are added erroneously when higher 32bits contain non-zero value.

Why would these high bits be non-zero?
