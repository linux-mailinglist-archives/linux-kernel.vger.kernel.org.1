Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E12B1CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:13:05 -0500
Received: from foss.arm.com ([217.140.110.172]:38898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMONE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:13:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 690EE142F;
        Fri, 13 Nov 2020 06:13:04 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBDF3F6CF;
        Fri, 13 Nov 2020 06:13:02 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:12:59 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm64: split counter validation function
Message-ID: <20201113141259.hrvpir2oit3ncm7t@bogus>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106125334.21570-3-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:53:33PM +0000, Ionela Voinescu wrote:
> In order for the counter validation function to be reused, split
> validate_cpu_freq_invariance_counters() into:
>  - freq_counters_valid(cpu) - check cpu for valid cycle counters
>  - freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate) -
>    generic function that sets the normalization ratio used by
>    topology_scale_freq_tick()
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
