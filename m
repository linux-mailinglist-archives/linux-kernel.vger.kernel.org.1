Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960812725F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgIUNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgIUNoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:44:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B269220888;
        Mon, 21 Sep 2020 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600695844;
        bh=MWMbTeQXgsSrcke9ClQCdlLOJJmrD/yGsUoAPqwbB1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glGVInNpxoukIMGGUaJ7ob5aWbbmyaI3ZQ0mPg5DXA71utsj8OfFA/4d6AD47Gn3h
         ee1v1lAsMEkPgVJWp0qDUrlMre9NV6ogj4CXNgd+OVS7lNP+AnmAXrmlOg8xlOo6sM
         FLIUhvOeKaR2/dW/EY0bbeqkzOOHXbaDFSykNsoM=
Date:   Mon, 21 Sep 2020 14:43:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        swboyd@chromium.org, sumit.garg@linaro.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 2/7] arm64: perf: Avoid PMXEV* indirection
Message-ID: <20200921134357.GL2139@willie-the-truck>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200819133419.526889-3-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819133419.526889-3-alexandru.elisei@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:34:14PM +0100, Alexandru Elisei wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Currently we access the counter registers and their respective type
> registers indirectly. This requires us to write to PMSELR, issue an ISB,
> then access the relevant PMXEV* registers.
> 
> This is unfortunate, because:
> 
> * Under virtualization, accessing one register requires two traps to
>   the hypervisor, even though we could access the register directly with
>   a single trap.
> 
> * We have to issue an ISB which we could otherwise avoid the cost of.
> 
> * When we use NMIs, the NMI handler will have to save/restore the select
>   register in case the code it preempted was attempting to access a
>   counter or its type register.
> 
> We can avoid these issues by directly accessing the relevant registers.
> This patch adds helpers to do so.
> 
> In armv8pmu_enable_event() we still need the ISB to prevent the PE from
> reordering the write to PMINTENSET_EL1 register. If the interrupt is
> enabled before we disable the counter and the new event is configured,
> we might get an interrupt triggered by the previously programmed event
> overflowing, but which we wrongly attribute to the event that we are
> enabling.
> 
> In the process, remove the comment that refers to the ARMv7 PMU.
> 
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [Julien T.: Don't inline read/write functions to avoid big code-size
> 	increase, remove unused read_pmevtypern function,
> 	fix counter index issue.]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> [Removed comment, removed trailing semicolons in macros, added ISB]

nit: but it's customary to prefix these with your name, so it's easy to
figure out who made changes (like Julien did above).

(similar comment for other patches in this series)

> @@ -620,9 +686,14 @@ static void armv8pmu_enable_event(struct perf_event *event)
>  	 * Disable counter
>  	 */
>  	armv8pmu_disable_event_counter(event);
> +	/*
> +	 * Make sure the effects of disabling the counter are visible before we
> +	 * start configuring the event.
> +	 */
> +	isb();

With the isb() added by patch 1, why don't we just make these implicit
in armv8_{enable,disable}_event_counter() ?

Will
