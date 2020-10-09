Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681812887C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgJIL0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:26:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731442AbgJIL0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:26:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602242804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SuCMHls48f4xLMwBK0m/Wzqo51WwaFK9373PeeO+uwo=;
        b=mZnwceWeAenutkEypdAM2WaVtaYclewuw0N8vBzN3RFN+NdfP5m15ymsCxtfWUHeQ+5T5M
        uvSTSKHgfpjweQO57N5YesKoet2VB09b7VbqL0XLC4stJTimcTQi0Imr/+rsXkcySbdszv
        FiuFvpPuThPxXoTiQnYfliujgb+FRyI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50C14AC84;
        Fri,  9 Oct 2020 11:26:44 +0000 (UTC)
Date:   Fri, 9 Oct 2020 13:26:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009112643.GM4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007122144.GF2628@hirez.programming.kicks-ass.net>
 <20201007123553.GK29020@dhcp22.suse.cz>
 <20201009094741.GH2628@hirez.programming.kicks-ass.net>
 <20201009101405.GI4967@dhcp22.suse.cz>
 <20201009102009.GK2628@hirez.programming.kicks-ass.net>
 <20201009104808.GK4967@dhcp22.suse.cz>
 <20201009111703.GL4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009111703.GL4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 13:17:04, Michal Hocko wrote:
[...]
> +config PREEMPT_DYNAMIC
> +	bool "Allow boot time preemption model selection"

	depends on !ARCH_NO_PREEMPT

> +	depends on PREEMPT_NONE || PREEMPT_VOLUNTARY
> +	help
> +	  This option allows to define the preemption model on the kernel
> +	  command line parameter and thus override the default preemption
> +	  model defined during compile time.
> +
> +	  The feature is primarily interesting for Linux distributions which
> +	  provide a pre-built kernel binary to reduce the number of kernel
> +	  flavors they offer while still offering different usecases.
> +
> +	  The runtime overhead is negligible with JUMP_LABELS enabled but if
> +	  runtime patching is not available for the specific architecture then
> +	  the potential overhead should be considered.
> +
> +	  Select if you the same pre-built kernel should be used for both Server
> +	  and Desktop workloads.
> +
>  config PREEMPT_COUNT
>         bool
-- 
Michal Hocko
SUSE Labs
