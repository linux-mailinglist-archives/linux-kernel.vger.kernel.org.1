Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA726DA51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIQLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgIQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F6CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSf1CWwz9sVb; Thu, 17 Sep 2020 21:27:29 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
In-Reply-To: <20200807074517.27957-1-srikar@linux.vnet.ibm.com>
References: <20200807074517.27957-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Allow archs to override cpu_smt_mask
Message-Id: <160034200734.3339803.9987418393320708886.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:29 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 13:15:16 +0530, Srikar Dronamraju wrote:
> cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
> most architectures. One of the users of cpu_smt_mask(), would be to
> identify idle-cores. On Power9, a pair of SMT4 cores can be presented by
> the firmware as a SMT8 core for backward compatibility reasons.
> 
> Powerpc allows LPARs to be live migrated from Power8 to Power9. Do note
> Power8 had only SMT8 cores. Existing software which has been
> developed/configured for Power8 would expect to see SMT8 core.
> Maintaining the illusion of SMT8 core is a requirement to make that
> work.
> 
> [...]

Applied to powerpc/next.

[1/2] sched/topology: Allow archs to override cpu_smt_mask
      https://git.kernel.org/powerpc/c/3babbe447d76ac2919ec4d0eb3b0adfb22f5b03c
[2/2] powerpc/topology: Override cpu_smt_mask
      https://git.kernel.org/powerpc/c/f3232321db58480804f80d59aeb651a5c859a200

cheers
