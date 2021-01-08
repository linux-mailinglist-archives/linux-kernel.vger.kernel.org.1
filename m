Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA02EF532
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAHPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:54:22 -0500
Received: from foss.arm.com ([217.140.110.172]:53392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbhAHPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:54:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F75831B;
        Fri,  8 Jan 2021 07:53:36 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5ED33F70D;
        Fri,  8 Jan 2021 07:53:35 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:53:34 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/3] arm64: topology: improvements
Message-ID: <20210108155334.GA21679@arm.com>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610104461.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jan 2021 at 16:46:50 (+0530), Viresh Kumar wrote:
> Hi,
> 
> Here is the V4 with the general improvements for topology stuff. This
> cleans up the code and makes it work with cpufreq modules.
> 
> V4:
> - Added Rby from Ionela.
> - In 3/3, Print cpus instead of amu_fie_cpus and make it pr_debug
>   instead.
> 
> Viresh Kumar (3):
>   arm64: topology: Avoid the have_policy check
>   arm64: topology: Reorder init_amu_fie() a bit
>   arm64: topology: Make AMUs work with modular cpufreq drivers
> 
>  arch/arm64/kernel/topology.c | 115 +++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 59 deletions(-)
> 

Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>

..for the full set.

Thanks,
Ionela.

> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
