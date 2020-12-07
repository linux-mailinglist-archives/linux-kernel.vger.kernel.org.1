Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A032D09CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgLGEoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 23:44:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgLGEoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:44:19 -0500
Date:   Mon, 7 Dec 2020 10:13:34 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607316218;
        bh=qMWn0JbXUrp9SaF1F1XZeFEE50NfhTPxRsyzNxWxLk4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuFnNHRjXlgFURZ9+tIowoiVvL5eT7tpdqInm1mu0CGTCTH3jrtMxnlvno0K/qYh5
         U08lebcc8G+fHy1Cooft8+GjB21xPo+KdQOZYNn5M36C1b56DJT6XLrLp32A2DxXlZ
         FM473Vy0OVcrYWKiDhykpLbgrJTXFtbgaWge8e+GKDAp8bFZ3gBBg5VyRE8cfb6RFU
         o20jLriO3ha76Nra0tlNhxM+1NaC6jssq90YPur3IBw++x/6ClJ1KWK9x+3xpUhqx3
         iMgWO2dU10x3ZYDovI182JCWprt4GHVpZEoE3Wb78dmg8CzwBEMPpuxWH18qfq/iia
         9tyTyuJU6q9TQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/7] soundwire: bus: use sdw_update_no_pm when
 initializing a device
Message-ID: <20201207044334.GA8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
 <20201205074508.GQ8403@vkoul-mobl>
 <1db93c2e-3c87-bc5e-ddeb-56424870b897@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db93c2e-3c87-bc5e-ddeb-56424870b897@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-20, 08:59, Pierre-Louis Bossart wrote:
> Thanks for the review Vinod.
> 
> On 12/5/20 1:45 AM, Vinod Koul wrote:
> > On 03-12-20, 04:46, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > When a Slave device is resumed, it may resume the bus and restart the
> > > enumeration. During that process, we absolutely don't want to call
> > > regular read/write routines which will wait for the resume to
> > > complete, otherwise a deadlock occurs.
> > > 
> > > Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')
> > 
> > Change looks okay, but not sure why this is a fix for adding no pm
> > version?
> 
> when we added the no_pm version, we missed the two cases below where
> sdw_update() was used and that creates a deadlock. To me that's a conceptual
> bug, we didn't fully use the no_pm versions, hence the Fixes tag.

Documentation says:
"A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
is used to make it easy to determine where a bug originated, which can help
review a bug fix. This tag also assists the stable kernel team in determining
which stable kernel versions should receive your fix. This is the preferred
method for indicating a bug fixed by the patch. See :ref:`describe_changes`
for more details."

I do not this this helps here as this does not help distros etc
I would say this is incremental development which improved a case not
done properly earlier, unless you would like this to be backported.. In
that case it helps folks...

> It's ok to remove the tag if you don't think it's useful/relevant, what
> matters is that we agree on the content.

-- 
~Vinod
