Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69C25BF4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgICKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgICKpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:45:00 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9F320716;
        Thu,  3 Sep 2020 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599129900;
        bh=+niwvcTwlWvSoZv6kAV2JhpMuJDFPstWYms2USZ7d24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ny980hjyju00iDOjfOO3hsBIP++lWvh948a0EcV7re146EvnnvB0w+0AWdukZNNGJ
         cNrxyewXQ5B+/FLfYF5pxQOoP7uc3817+kQdOkZur7UaRTNv4sYS3aX5cHXwXFzSUK
         aVxoy9hfzbDeHwcf4pFlS2Iw6UBrcSskCz5MATJk=
Date:   Thu, 3 Sep 2020 16:14:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 00/10] soundwire: intel: add multi-link support
Message-ID: <20200903104456.GR2639@vkoul-mobl>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-20, 23:05, Bard Liao wrote:
> This series enables multi-link support for Intel platforms.

Applied all, thanks

> 
> Changes in v2:
> - Remove the "soundwire: intel: Only call sdw stream APIs for the first
>   cpu_dai" patch form this series. We will move the sounwdire stream
>   operations to machine driver in another series.
> - Update the commit message and title of "soundwire: intel: add error log
>   for clock-stop invalid configs"
> 
> Pierre-Louis Bossart (10):
>   soundwire: intel: disable shim wake on suspend
>   soundwire: intel: ignore software command retries
>   soundwire: intel: add multi-link support
>   soundwire: intel: add missing support for all clock stop modes
>   soundwire: bus: update multi-link definition with hw sync details
>   soundwire: intel: add multi-link hw_synchronization information
>   soundwire: stream: enable hw_sync as needed by hardware
>   soundwire: intel: add error log for clock-stop invalid configs
>   soundwire: intel: pass link_mask information to each master
>   soundwire: intel: don't manage link power individually
> 
>  drivers/soundwire/intel.c      | 264 ++++++++++++++++++++++++++++-----
>  drivers/soundwire/intel.h      |   2 +
>  drivers/soundwire/intel_init.c |   1 +
>  drivers/soundwire/stream.c     |  15 +-
>  include/linux/soundwire/sdw.h  |   6 +
>  5 files changed, 243 insertions(+), 45 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
