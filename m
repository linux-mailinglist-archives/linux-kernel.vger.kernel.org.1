Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D762FBE52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbhASRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405203AbhASOwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:52:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23A7321D1B;
        Tue, 19 Jan 2021 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611067901;
        bh=5eQUqo35H7Bc70t3PZ/r+dVaPIenZbDCpuM9ic622SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccw9Y4bbntd0K+FTaVUEotLQDh+oix5coXndu0/+ASsrKkeKgl6zklakxcLvzGrwn
         9cw2WMXw0JeUgSy9V2MZHeam1SUU9j6YoNtyp0P98CCDYbaRZMNgUq2dHB1yMrjus9
         RB6b6XkibhfpnNsKnr1R0lK1id8XOel81lmdFrwt+j7phuY2txv1dt/F+56Sf3dMOU
         b8KzzTvycJ6hzzeIotSdjuJ7PyUb/pXp8HcLNX6EMgP24Z2KgOBrYDSqAyav+1t1gj
         4gV6W6uJXnDWpS2iMkQt8CH8FpJDv+zWyZsFU265xNTkl3HJXQHvwBD262X14W27KF
         ynFQiQOWMVrVQ==
Date:   Tue, 19 Jan 2021 20:21:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: don't return error when clock stop
 failed
Message-ID: <20210119145135.GR2771@vkoul-mobl>
References: <20210114030248.9005-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114030248.9005-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-21, 11:02, Bard Liao wrote:
> dev->power.runtime_error will be set to the return value of the runtime
> suspend callback function, and runtime resume function will return
> -EINVAL if dev->power.runtime_error is not 0.
> 
> Somehow the codec rarely doesn't return an ACK to the clock prepare
> command. If we stop the runtime suspend process and return error, we
> will not be able to resume again. Likewise, if the codec lost sync and
> did not rejoin, the resume operation will also fail. As a result, the
> SoundWire bus can not be used anymore.
> 
> This patch suggests to finish the runtime suspend process even if we fail
> to stop sdw bus clock. In the case where we do a hardware reset, the codecs
> will be reconfigured completely. In the case where we use the regular clock
> stop, the codecs keep their state and worst case will fall off the bus and
> reattach.
> 
> The only drawback is that the power consumption may be higher and
> device-initiated interrupts may be lost, but at least audio function can
> still work after resume.

Applied, thanks

-- 
~Vinod
