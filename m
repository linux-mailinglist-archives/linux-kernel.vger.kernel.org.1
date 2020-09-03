Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481EB25BF39
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgICKnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICKmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:42:53 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F72D20767;
        Thu,  3 Sep 2020 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599129773;
        bh=Y17fOItbzHxWxDdPgwuBKoBEommCrq+F8Xn4jHcXZAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJ1xUt//QkPMx0Cfc4p/DXpBnaafHLIK6mBMO4UnmugYOZ0hJi4IYYDgPYjBHzZS7
         qoCUTd5cy14V3mj7Xs5Ax+ZdUenLGKJngmE15ChxdkThCBPQJA1475Xkaook6vHjVS
         mAo2GA4iU++XEza0AFZqh0jHjA67DZPjqkPqoVyw=
Date:   Thu, 3 Sep 2020 16:12:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 0/7] ASoC: soundwire: Move sdw stream operations to
Message-ID: <20200903104248.GQ2639@vkoul-mobl>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-20, 23:02, Bard Liao wrote:
> sdw stream operation APIs can be called once per stream. dailink
> callbacks are good places to call these APIs.

Again, please mention here if this is to be merged thru sdw tree or ASoC
tree

> 
> Pierre-Louis Bossart (7):
>   ASoC: soc-dai: clarify return value for get_sdw_stream()
>   soundwire: stream: fix NULL/IS_ERR confusion
>   soundwire: intel: fix NULL/ERR_PTR confusion
>   ASOC: Intel: sof_sdw: add dailink .trigger callback
>   ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback

These should be ASoC

>   soundwire: intel: remove .trigger operation
>   soundwire: intel: remove stream handling from .prepare and .hw_free
> 
>  drivers/soundwire/intel.c        | 60 ++++-------------------
>  drivers/soundwire/stream.c       |  2 +-
>  include/sound/soc-dai.h          |  3 +-
>  sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+), 54 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
