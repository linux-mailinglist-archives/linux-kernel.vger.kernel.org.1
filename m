Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90F71E6247
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbgE1NaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:30:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:55917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390320AbgE1NaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:30:11 -0400
IronPort-SDR: JXCig5xqm0WyaJOrh98bp3e8I02OUIZ+Ei8U8f09qcMat/PtVX8deBa0azdF1JW6dPTl8Xrppv
 0brzmcJm1oaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:30:09 -0700
IronPort-SDR: yNgQRpzQQeWDsH7IIzyPbJXyHNFd1T1Ev6FEDI/mHl5BzWeZN2kEA2GuugDe9OVJjnJE28bFxe
 JyTiQM9WhHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="302813677"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2020 06:30:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E4E26301C5F; Thu, 28 May 2020 06:30:08 -0700 (PDT)
Date:   Thu, 28 May 2020 06:30:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com
Subject: Re: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
Message-ID: <20200528133008.GH611145@tassilo.jf.intel.com>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 06:15:27AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> An oops will be triggered, if perf tries to access an invalid address
> which exceeds the mapped area.
> 
> Check the address before the actual access to MMIO sapce of an uncore
> unit.

Ah ok the range check is here

> 
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore.c       |  3 +++
>  arch/x86/events/intel/uncore.h       | 12 ++++++++++++
>  arch/x86/events/intel/uncore_snbep.c |  6 ++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index cf76d66..284f8e7 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -132,6 +132,9 @@ u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
>  	if (!box->io_addr)
>  		return 0;
>  
> +	if (!is_valid_mmio_offset(box, event->hw.event_base))
> +		return 0;

Is this function used somewhere else? Otherwise it should be added
together with its users.

-Andi
