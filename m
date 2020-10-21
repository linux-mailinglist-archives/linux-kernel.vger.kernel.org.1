Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A642954DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 00:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506844AbgJUWjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 18:39:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:55175 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506826AbgJUWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:39:35 -0400
IronPort-SDR: rIDdQlgALiuoSJ1dD096SBs0B7om9x/klowQ08DEGFjO8V56oZdGoeYIkIQpztGzAf7SsdkyeG
 FumbZR5brqNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="163951281"
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="163951281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 15:39:33 -0700
IronPort-SDR: W97OYR0agkN6TAlZuHKb58WWV18JKY9PMagwAJUdkPPFOgMMn7bUVubWgpxgo1WWgs/xNz3rx3
 6ub3EJ7AoNfA==
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="533706728"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 15:39:33 -0700
Date:   Wed, 21 Oct 2020 15:39:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com,
        jolsa@redhat.com, peterz@infradead.org, mingo@elte.hu,
        irogers@google.com, namhyung@kernel.org
Subject: Re: [PATCH] perf/x86/intel: make anythread filter support conditional
Message-ID: <20201021223932.GP466880@tassilo.jf.intel.com>
References: <20201021211612.2026234-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021211612.2026234-1-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:16:12PM -0700, Stephane Eranian wrote:
> Starting with Arch Perfmon v5, the anythread filter on generic counters may be
> deprecated. The current kernel was exporting the any filter without checking.
> On Icelake, it means you could do cpu/event=0x3c,any/ even though the filter
> does not exist. This patch corrects the problem by relying on the CPUID 0xa leaf
> function to determine if anythread is supported or not as described in the
> Intel SDM Vol3b 18.2.5.1 AnyThread Deprecation section.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
