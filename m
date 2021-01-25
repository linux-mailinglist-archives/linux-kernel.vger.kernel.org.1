Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9963C302420
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbhAYLKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbhAYLDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:03:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59CCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 03:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r+KBxMybDr1usbcaCcE0TrdbPjsSTRmFRC4Jt2BrQRs=; b=OiLH56of5BgccSMXzjF2EGN2UD
        /4bkt5n+QSXgGZbZtrySPl7T1ID/FYOMQ9iwE6t7w49GIAiN0rpkS1l6+MsoI+opT90Kfh3yPa0kS
        xIbZAx6CUQm4wxGu1W3Hinon+rXNTp6q0cTjygtg94Vjyo5w1gSkLwk8UuG+rmYf2LiFRuVbFBwrT
        uCNLXwgxgEBxd1QJCPtAaX31Fmc341rjxCBYWMGRnRv2NPpImQrlB++OCrrgjSJULbuHv9hAg+qzM
        3xWmOWeVfSlZ+CA6VQ8iuGhxYghY/nRZ6ifBQrMF+de9HQwsMdqN83uwM0J0vEh7E0f0U68U9ql8y
        qjOk9Dyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l3zd7-0046vd-70; Mon, 25 Jan 2021 11:02:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76E0C300DB4;
        Mon, 25 Jan 2021 12:01:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C50F207D3C61; Mon, 25 Jan 2021 12:01:56 +0100 (CET)
Date:   Mon, 25 Jan 2021 12:01:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Ingo Molnar <mingo@redhat.com>, will@kernel.org,
        mark.rutland@arm.com, mike.leach@linaro.org, al.grant@arm.com,
        anshuman.khandual@arm.com, mathieu.poirier@linaro.org,
        linux-arm-kernel@lists.infradead.org, jolsa@redhat.com,
        acme@kernel.org
Subject: Re: [RFC PATCH] perf: Handle multiple formatted AUX records
Message-ID: <YA6lJPG7DGnlL8yh@hirez.programming.kicks-ass.net>
References: <20210122151829.2890484-1-suzuki.poulose@arm.com>
 <20210122151829.2890484-2-suzuki.poulose@arm.com>
 <YA6cjdmfG8x2EggP@hirez.programming.kicks-ass.net>
 <b30069fb-3df4-8c8a-9ee8-471c0a6d5f38@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30069fb-3df4-8c8a-9ee8-471c0a6d5f38@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:45:06AM +0000, Suzuki K Poulose wrote:
> On 1/25/21 10:25 AM, Peter Zijlstra wrote:

> > Since we have a whole u64, do we want to reserve a whole nibble (or
> > maybe even a byte) for a format type? Because with a single bit like
> > this, we'll kick ourselves when we end up with the need for a 3rd format
> > type.
> > 
> 
> Sure, makes sense. We could do:
> 
> #define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00
> 
> Additionally, the values could be allocated by individual PMUs and
> interpreted by the corresponding counterpart. That way we don't
> have to worry about centralized allocation of the "TYPE" fields.
> 
> e,g:
> 
> #define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000
> #define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW		0x0100
> 
> #define PERF_AUX_FLAG_RANDOM_PMU_FORMAT_FMT1		0x0000
> #define PERF_AUX_FLAG_RANDOM_PMU_FORMAT_FMT2		0x0100
> 
> 
> What do you think ?

Sounds good to me.
