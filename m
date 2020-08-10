Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B78241278
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHJVku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:40:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hIC4nBESd4zToW5Sc0fID23FT9N4BYzYAMVr8zEiy7A=; b=2VOuU14y1BxiSq4dBYYCUOlZq+
        lyZ0jiA/51ojVIin6yueleBlNOiIfSPO2636E1VHzwTYAlreRF0XN33sjMgFvdVLLMALm3FLTh0s+
        +4m5vgzp4X6X254i8ndat45aKGVJSEBviuZW4KIiEw3PaLBZQXfeZN7fY4ZMOw3exksbgfTMX3nnU
        stdVfWA03XtQjAdNGpO+wGIAo6rrq0hDgoXXMIr+JeyOgLHecnEmm//T59UDpwHVbaD7uERdBRj9c
        KELx6T8hlY8x+CfS40G9kXFj9ytbvUwl9tpfKYj7FjqV/0emI8nEK788gPxqejOsD8nWsvzXvjuZR
        PzIsDswg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5FX8-0005As-0Y; Mon, 10 Aug 2020 21:40:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67BDF980D39; Mon, 10 Aug 2020 23:40:40 +0200 (CEST)
Date:   Mon, 10 Aug 2020 23:40:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 02/16] perf/x86/intel: Support
 PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20200810214040.GK3982@worktop.programming.kicks-ass.net>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810212436.8026-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:24:22PM -0700, Kan Liang wrote:
> The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
> address. Update the data->addr if the sample type is set.
> 
> The large PEBS is disabled with the sample type, because perf doesn't
> support munmap tracking yet. The PEBS buffer for large PEBS cannot be
> flushed for each munmap. Wrong page size may be calculated. The large
> PEBS can be enabled later separately when munmap tracking is supported.


You also get to fix up Power.

arch/powerpc/perf/core-book3s.c:                    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))

