Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5D247E78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 02:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgHRGbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:31:34 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC62D20738;
        Tue, 18 Aug 2020 06:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597732293;
        bh=nMXqbm32hbEmgherpbeAfukazmSMKSnx5p8qVF7HpdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xokRm1Y5cHMsvqz/9Dee/dubm0DU44Vxjn19pOHo29aeICf2tae4OLfSA+MCqpMO4
         e5S2jfTqb1N5wTVId+DYtV+h56Cay/Q7sMAMprQC4b37RP5OeMdYIsiqBXy6H8HPLW
         suLU3wAe2Auawk26nxHlWfJ8Pj0u3kL4olz+pmHA=
Date:   Tue, 18 Aug 2020 12:01:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 00/12] soundwire: intel: add power management support
Message-ID: <20200818063129.GU2639@vkoul-mobl>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 23:29, Bard Liao wrote:
> This series adds power management support for Intel soundwire links.

Applied all, thanks

> 
> Changes in v2:
> - Move "#include <linux/pm_runtime.h>" to the first required patch.
> - Fit debug log in single line. 
> 
> Bard Liao (1):
>   soundwire: intel: reinitialize IP+DSP in .prepare(), but only when
>     resuming
> 
> Pierre-Louis Bossart (9):
>   soundwire: intel: add pm_runtime support
>   soundwire: intel: reset pm_runtime status during system resume
>   soundwire: intel: fix race condition on system resume
>   soundwire: intel: call helper to reset Slave states on resume
>   soundwire: intel: pm_runtime idle scheduling
>   soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
>   soundwire: intel: add CLK_STOP_NOT_ALLOWED support
>   soundwire: intel_init: handle power rail dependencies for clock stop
>     mode
>   soundwire: intel: support clock_stop mode without quirks
> 
> Rander Wang (2):
>   soundwire: intel: add CLK_STOP_BUS_RESET support
>   soundwire: intel: refine runtime pm for SDW_INTEL_CLK_STOP_BUS_RESET
> 
>  drivers/soundwire/cadence_master.h |   4 +
>  drivers/soundwire/intel.c          | 363 ++++++++++++++++++++++++++++-
>  drivers/soundwire/intel.h          |   2 +
>  drivers/soundwire/intel_init.c     |  19 +-
>  4 files changed, 382 insertions(+), 6 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
