Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4B2B1CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKMOL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:11:57 -0500
Received: from foss.arm.com ([217.140.110.172]:38882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMOL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:11:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09123142F;
        Fri, 13 Nov 2020 06:11:56 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298863F6CF;
        Fri, 13 Nov 2020 06:11:53 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:11:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] arm64: wrap and generalise counter read functions
Message-ID: <20201113141151.wyc6yk2lopp4ldxn@bogus>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106125334.21570-2-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:53:32PM +0000, Ionela Voinescu wrote:
> In preparation for other uses of Activity Monitors (AMU) cycle counters,
> place counter read functionality in generic functions that can reused:
> read_corecnt() and read_constcnt().
> 
> As a result, implement update_freq_counters_refs() to replace
> init_cpu_freq_invariance_counters() and both initialise and update
> the per-cpu reference variables.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
