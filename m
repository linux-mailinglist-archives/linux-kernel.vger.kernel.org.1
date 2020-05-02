Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291D11C24F5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEBL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 07:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgEBL41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:56:27 -0400
Received: from localhost (unknown [117.99.89.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229292137B;
        Sat,  2 May 2020 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588420587;
        bh=1yEsKoU0oUSVvOLYtVrEg1plY1Addk/1bazSbloP00c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKaTQpT73raZfKKWJXWPxWtNmxWPm+a18Wdh5WRmTe2QX+EhMC8PV25R0y20AJE/n
         tBWi37pQnaRl3hyl1JzL+hV1JP3VXLRXGZFjv8A6XLoHSYoHtrG3fe2NC7VH/QXv24
         1lElS1Cpbce2EvnfcOc/1P0dXErb1lioXWWCNJR8=
Date:   Sat, 2 May 2020 17:26:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/4] Documentation: SoundWire: clarify TDM mode support
Message-ID: <20200502115614.GR948789@vkoul-mobl.Dlink>
References: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20, 02:51, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The current description of stream topologies does not explicitly
> mention 'mirror' topologies used for audio amplifiers, where all
> amplifiers see the same data and generate a different output based on
> configuration or dynamic information. Add examples and notes to
> explain how channels can be transmitted and mapped.

Applied all, thanks
-- 
~Vinod
