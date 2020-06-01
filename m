Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F651E9D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 07:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFAFiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 01:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAFiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:38:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FDF20734;
        Mon,  1 Jun 2020 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590989893;
        bh=Sk+3FDa4eyUAb7Uu+3xSsOKJ9/rrBhWYlqzvji4jsXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krFlqurWHamzAuou74k9Q1caFDcOU2Tp99+qhvroOLva0bOLrtgurEv4RDVDX3XbU
         BcTR3q82CjAHixhwyYO1MMnZ4I4WGc3Rpcnz/ZfyIUEiAGVMoAHw9U5he4n5mev4VB
         FrZ+HJhYsjhY7opQm4fsciRg+eGXRSWAeoMhsbHQ=
Date:   Mon, 1 Jun 2020 07:38:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: clarify SPDX use of GPL-2.0
Message-ID: <20200601053809.GA1420218@kroah.com>
References: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 01:28:07AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Change SPDX from GPL-2.0 to GPL-2.0-only for Intel-contributed
> code. This was explicit before the transition to SPDX and lost in
> translation.

It is also explicit in the "GPL-2.0" lines as well, did you read the
LICENSES/preferred/GPL-2.0 file for the allowed tags to be used for this
license?

So this doesn't change anything, and we are trying to cut down on this
type of churn until, maybe, after the whole kernel has proper SPDX
lines.

thanks,

greg k-h
