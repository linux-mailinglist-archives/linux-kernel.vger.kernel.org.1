Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E510A2DAC83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgLOL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:57:58 -0500
Received: from foss.arm.com ([217.140.110.172]:36564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgLOL4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A67030E;
        Tue, 15 Dec 2020 03:56:07 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A72533F66E;
        Tue, 15 Dec 2020 03:56:06 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:56:05 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20201215115605.GB25331@arm.com>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 15 Dec 2020 at 11:04:16 (+0530), Viresh Kumar wrote:
> The AMU counters won't get used today if the cpufreq driver is built as
> a module as the amu core requires everything to be ready by late init.
> 
> Fix that properly by registering for cpufreq policy notifier. Note that
> the amu core don't have any cpufreq dependency after the first time
> CPUFREQ_CREATE_POLICY notifier is called for all the CPUs. And so we
> don't need to do anything on the CPUFREQ_REMOVE_POLICY notifier. And for
> the same reason we check if the CPUs are already parsed in the beginning
> of amu_fie_setup() and skip if that is true. Alternatively we can shoot
> a work from there to unregister the notifier instead, but that seemed
> too much instead of this simple check.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3:
> - This is a new patch.
> 
> Ionela,
> 
> I don't have a way to test the AMU stuff, will it be possible for you to
> give it a try ?
> 

I'll review this new patch and then I'll give the full set a try.

Thanks for the interest in improving this,
Ionela.
