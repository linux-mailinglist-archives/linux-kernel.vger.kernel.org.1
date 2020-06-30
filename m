Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3420F9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbgF3Qkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbgF3Qkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:40:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8B7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yKdZNHoBg53b/hVeYXoFqzfvLaS4RH0SHvXu7VLjagI=; b=wRLmPi/OzHA7KEt8qXKQj4l7zQ
        J0L0NG/t2hgsb7N5ObUMyi/tK6L3No7CwP9Rr3mkz2QH1ASsMPlXmruW3v+s3mQcoowyOYsGNo8nn
        VT6cjW3AGbJ/R97WpfxXpSfUAPnBLM1kfvA3/r9NAXyIL89rKUPC4HsOV2RmzoXUMKt4J8WoVeZ1Y
        wcuS7/SxmkO3vx602OJiCg6s2XJoQFcigLfPNgUr29G2i+/g/X4KfU2VVg0uGhRzuVm6ogRQq9xbx
        7CBqf+Ws19Z3oedJmwL0zRU1rbM2Ap0UobCSpjUmiywKqFp6MIFDt4uS5OqwwvOvB6jeu4f7zqv13
        FpI03pDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqJIa-0001mQ-IP; Tue, 30 Jun 2020 16:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92BDA306064;
        Tue, 30 Jun 2020 18:39:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FC0C20CF3986; Tue, 30 Jun 2020 18:39:54 +0200 (CEST)
Date:   Tue, 30 Jun 2020 18:39:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V2 08/23] perf/x86: Expose CPUID enumeration bits for
 arch LBR
Message-ID: <20200630163954.GY4817@hirez.programming.kicks-ass.net>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-9-git-send-email-kan.liang@linux.intel.com>
 <20200630150154.GS4781@hirez.programming.kicks-ass.net>
 <211b4d70-eec5-4577-45fb-99435023cab8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211b4d70-eec5-4577-45fb-99435023cab8@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:36:29AM -0400, Liang, Kan wrote:
> > Why keep the full CPUID leaf here? What's wrong with something like:
> > 
> > 	unsigned int	lbr_depth_mask:8;
> > 	unsigned int	lbr_deep_c_reset:1;
> > 	unsigned int	lbr_lip:1;
> > 	unsigned int	lbr_cpl:1;
> > 	unsigned int	lbr_filter:1;
> > 	unsigned int	lbr_call_stack:1;
> > 	unsigned int	lbr_mispred:1;
> > 	unsigned int	lbr_timed_lbr:1;
> > 	unsigned int	lbr_br_type:1;
> > 
> > That's only 2 bytes, instead of 24.
> 
> Yes, it can save the space.
> I will add some codes in patch 14 to initialize these items in
> intel_pmu_arch_lbr_init().

It also makes stuff like:

> +   if (!x86_pmu.lbr_ebx.split.lbr_cpl ||
> +       !x86_pmu.lbr_ebx.split.lbr_filter ||
> +       !x86_pmu.lbr_ebx.split.lbr_call_stack)

eminently more readable.
