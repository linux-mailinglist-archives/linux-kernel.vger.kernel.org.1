Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CC2EAEA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbhAEPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:35:36 -0500
Received: from foss.arm.com ([217.140.110.172]:56198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbhAEPff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:35:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB11C1FB;
        Tue,  5 Jan 2021 07:34:49 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 108DF3F70D;
        Tue,  5 Jan 2021 07:34:48 -0800 (PST)
Date:   Tue, 5 Jan 2021 15:34:46 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update ARM SCMI entry
Message-ID: <20210105153446.GA44928@e120937-lin>
References: <20210105151945.406093-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105151945.406093-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

Cristian

Acked-by: Cristian Marussi <cristian.marussi@arm.com>

On Tue, Jan 05, 2021 at 03:19:45PM +0000, Sudeep Holla wrote:
> Cristian is actively developing new features and more involved than me.
> So add Cristian as a designated reviewer. Also add the newly added scmi
> regulator driver to the list.
> 
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6eff4f720c72..34e09b55f806 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17208,6 +17208,7 @@ F:	drivers/mfd/syscon.c
>  
>  SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message Protocol drivers
>  M:	Sudeep Holla <sudeep.holla@arm.com>
> +R:	Cristian Marussi <cristian.marussi@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
> @@ -17215,6 +17216,7 @@ F:	drivers/clk/clk-sc[mp]i.c
>  F:	drivers/cpufreq/sc[mp]i-cpufreq.c
>  F:	drivers/firmware/arm_scmi/
>  F:	drivers/firmware/arm_scpi.c
> +F:	drivers/regulator/scmi-regulator.c
>  F:	drivers/reset/reset-scmi.c
>  F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
> -- 
> 2.25.1
> 
