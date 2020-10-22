Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516BC29649C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902472AbgJVSWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:22:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900523AbgJVSWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:22:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76477D6E;
        Thu, 22 Oct 2020 11:22:41 -0700 (PDT)
Received: from bogus (unknown [10.57.22.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5246A3F719;
        Thu, 22 Oct 2020 11:22:40 -0700 (PDT)
Date:   Thu, 22 Oct 2020 19:22:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
Message-ID: <20201022182233.hklq6j5n5kkqg4yv@bogus>
References: <20201021183104.27949-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021183104.27949-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:31:03PM +0100, Sudeep Holla wrote:
> Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> _allocate_opp_table() which is called from dev_pm_opp_add and it
> now propagates the error back to the caller.
> 
> SCMI performance domain re-used clock bindings to keep it simple. However
> with the above mentioned change, if clock property is present in a device
> node, opps can't be added until clk_get succeeds. So in order to fix the
> issue, we can register dummy clocks which is completely ugly.
> 
> Since there are no upstream users for the SCMI performance domain clock
> bindings, let us introduce separate performance domain bindings for the
> same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> v1[1]->v2:
> 	- Changed the generic #perf-domain-cells to more SCMI specific
> 	  property #arm,scmi-perf-domain-cells
>

Is more specific #arm,scmi-perf-domain-cells acceptable ?
Sorry for the rush, but this fixes SCMI cpufreq which is broken after
commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
-EPROBE_DEFER")

-- 
Regards,
Sudeep
