Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4012D5758
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgLJJip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:38:45 -0500
Received: from foss.arm.com ([217.140.110.172]:59668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgLJJif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:38:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942CA1FB;
        Thu, 10 Dec 2020 01:37:49 -0800 (PST)
Received: from bogus (unknown [10.57.54.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9CF3F68F;
        Thu, 10 Dec 2020 01:37:47 -0800 (PST)
Date:   Thu, 10 Dec 2020 09:37:44 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Drop the useless update to per-cpu
 cycles
Message-ID: <20201210093744.ienqd3aciv3oulag@bogus>
References: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:17:40AM +0530, Viresh Kumar wrote:
> The previous call to update_freq_counters_refs() has already updated the
> per-cpu variables, don't overwrite them with the same value again.
>

Good catch!

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
