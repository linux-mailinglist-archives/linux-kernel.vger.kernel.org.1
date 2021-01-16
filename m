Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998EA2F8D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAPMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:51:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B4C061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4YEUW17kBdpspVxo0YSx9FEO0A/vnfADhbD1A91oJE=; b=PbS7quIhRV7+72+c2gs+1J/zho
        /1AFiqa7vDUiQrOWA/aVFzzhzT7/hEe0aGQeGNscJlzW29zJ6f0T9j7e3uwLgZ7sSvUl7TbdGHhFU
        iluqP3RolB8l3bH7EWiEGn/SNQ3y5+dw3wvfAV9XaEtRiddaP4uktNQIAW2AWen1HUCnK2U8hRdNb
        Uoh7Ugeglcs77fzvpnyEgh1T+n8Nmvh9+KrmtOMxKunSH0SzgqtfTh0RsqCFtrwbwsI8D9yBNNdmu
        Po4FP3y3kT80gbbDdwUvCeStOwqUkCJflybjF1FkYN23nNXSXvfP8iZkYm+fOmwwlIP2ThIJxTjbz
        pGwjzX6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0l1w-0005oI-3b; Sat, 16 Jan 2021 12:50:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 804BB30377D;
        Sat, 16 Jan 2021 13:50:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F28420299B4E; Sat, 16 Jan 2021 13:50:10 +0100 (CET)
Date:   Sat, 16 Jan 2021 13:50:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
Message-ID: <YALhAmTgMHxEgeG4@hirez.programming.kicks-ass.net>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-3-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115092208.20866-3-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:22:08PM +0800, Zhang Rui wrote:
> There are several things special for the RAPL Psys energy counter, on
> Intel Sapphire Rapids platform.
> 1. it contains one Psys master package, and only CPUs on the master
>    package can read valid value of the Psys energy counter, reading the
>    MSR on CPUs in the slave package returns 0.
> 2. The master package does not have to be Physical package 0. And when
>    all the CPUs on the Psys master package are offlined, we lose the Psys
>    energy counter, at runtime.
> 3. The Psys energy counter can be disabled by BIOS, while all the other
>    energy counters are not affected.
> 
> It is not easy to handle all of these in the current RAPL PMU design
> because
> a) perf_msr_probe() validates the MSR on some random CPU, which may either
>    be in the Psys master package or in the Psys slave package.
> b) all the RAPL events share the same PMU, and there is not API to remove
>    the psys-energy event cleanly, without affecting the other events in
>    the same PMU.
> 
> This patch addresses the problems in a simple way.
> 
> First, by setting .no_check bit for RAPL Psys MSR, the psys-energy event
> is always added, so we don't have to check the Psys ENERGY_STATUS MSR on
> master package.
> 
> Then, rapl_not_visible() is removed because
> 1. it is useless for RAPL MSRs with .no_check cleared, because the
>    .is_visible() callbacks is always overridden in perf_msr_probe().
> 2. it is useless for RAPL MSRs with .no_check set, because we actually
>    want the sysfs attributes always be visible for those MSRs.
> 
> With the above changes, we always probe the psys-energy event on Intel SPR
> platform. Difference is that the event counter returns 0 when the Psys
> RAPL Domain is disabled by BIOS, or the Psys master package is offlined.

Maybe I'm too tired, but I cannot follow. How does this cure the fact
that the rapl_cpu_mask might not include that master thing. And how can
software detect what the master thing is to begin with?
