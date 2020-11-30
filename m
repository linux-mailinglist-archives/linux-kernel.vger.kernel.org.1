Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DF2C89DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgK3Qri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgK3Qrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:47:37 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4696B2067C;
        Mon, 30 Nov 2020 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606754817;
        bh=PBQifm6DraFNejjKgt0IKbv0mnlfO+5mof3SFPnhpQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikl7B+DnVwstqClfpP0q/Fquj3ruBoS1ZKuF7gfnl/X1ekHtUWtafmtU9kSJjR3by
         2Qc0owC0FKifGosDMbYAooeLvRoNLfOB44jmw4uWZws5jsfr99kCN+nBi18jrnWugW
         zo6aDJjYasN1Iim/fQAtoYN8SOxK+WOWyY15KfHc=
Date:   Mon, 30 Nov 2020 16:46:51 +0000
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Message-ID: <20201130164650.GA25187@willie-the-truck>
References: <20201130162454.28255-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130162454.28255-1-james.clark@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
> Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> This flag is required to get PID data in the SPE trace. Without
> it the perf tool will report 0 for PID which isn't very useful,
> especially when doing system wide profiling or profiling
> applications that fork.

Can perf not figure out the pid some other way? (e.g. by tracing context
switches and correlating that with the SPE data?). Also, how does this
work with pid namespaces?

> There is a small performance overhead when enabling
> PID_IN_CONTEXTIDR, but SPE itself is optional and not enabled by
> default so the impact is minimised.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/perf/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 130327ff0b0e..47ede46c3d57 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -125,6 +125,7 @@ config XGENE_PMU
>  config ARM_SPE_PMU
>  	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
>  	depends on ARM64
> +	select PID_IN_CONTEXTIDR

Probably better to make PID_IN_CONTEXTIDR 'default y' if SPE is enabled,
rather than selecting it directly. That way, at least people can turn it
off if they don't want it.

Will
