Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D862C4E73
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 06:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbgKZFfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 00:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387735AbgKZFfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 00:35:08 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4735206F4;
        Thu, 26 Nov 2020 05:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606368907;
        bh=SQ9EM5DKO0FDPcLkKrOAzp0Hp/ce+DVQ/7l3J/t9VW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGO0lGepBUjnAlHlzQN4Jlh4CXkMW1fymbSXk+6d15tvpFg3wHnRD4iO2LEhoIQh5
         VSSwmroq4BFfe+OQUvkxwztb50N6mLqusiFQ2p/4+CX8UtuvDgiJqQwgY2q9X8rDE4
         r9Uyj/JvQW6+kfH4chIFlYTlKwMXnTAhO0v/fBjg=
Date:   Thu, 26 Nov 2020 06:35:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] regmap: sdw: add required header files
Message-ID: <X78+hlJTgA3FdmxY@kroah.com>
References: <20201125130128.15952-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125130128.15952-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:01:28PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Explicitly add header files used by regmap SoundWire support.

What is failing to build without this?

thanks,

greg k-h
