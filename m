Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086DC2CB5BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgLBHU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLBHU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:20:27 -0500
Date:   Wed, 2 Dec 2020 12:49:42 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606893587;
        bh=X4r+iT7gA+qhcSzwcOzyTZ4y8Ixf+TG2omJrcZ75MQI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZHIb0b5Hs/sFJWT6xZsyHskbCCcI1rZC8lJtJ/hWPaXKPn7ZjXC8AR599zWRNAxk
         0qyp0ewnCHhC5ex8Xu3MNTbOMaTJIBowrTfCH9Qt1WS00iH4wEjRolFUpP8XXFVA3x
         dFOIOUphIrKPAo8dtVhBy0MfB8Ysp3akf4b/vTro=
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Message-ID: <20201202071942.GH8403@vkoul-mobl>
References: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-20, 21:07, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The 'master' device acts as a glue layer used during bus
> initialization only, and it needs to be 'transparent' for pm_runtime
> management. Its behavior should be that it becomes active when one of
> its children becomes active, and suspends when all of its children are
> suspended.
> 
> In our tests on Intel platforms, we routinely see these sort of
> warnings on the initial boot:
> 
> [ 21.447345] rt715 sdw:3:25d:715:0: runtime PM trying to activate
> child device sdw:3:25d:715:0 but parent (sdw-master-3) is not active
> 
> This is root-caused to a missing setup to make the device 'active' on
> probe. Since we don't want the device to remain active forever after
> the probe, the autosuspend configuration is also enabled at the end of
> the probe - the device will actually autosuspend only in the case
> where there are no devices physically attached. In practice, the
> master device will suspend when all its children are no longer active.

Applied, thanks

-- 
~Vinod
