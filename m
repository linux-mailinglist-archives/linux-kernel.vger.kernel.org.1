Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEB262722
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIIG0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 02:26:33 -0400
Received: from mail1.perex.cz ([77.48.224.245]:43806 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIG0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:26:30 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 411ECA003F;
        Wed,  9 Sep 2020 08:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 411ECA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599632788; bh=6TM8UZlhBVv9GZrB00/bGCYuJ/Qyusmp7Cmt1ltZKcU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FFf6yfDs3hx+hvXuYuWrkEfLUTOhqOAtk4wkhSPmdAVgR+55abBg9kGOR/HUGfNJJ
         Z5S2vP0gJXEQG/RBsVWsmRabvxqKUGHStNN06cMAPG+G1A3UBMmR0DJRiPUnfV3L7W
         I/6xuxSFxXgi5ZdnRcLvIMBY8M+Bs6Bt3Gc4IPzU=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  9 Sep 2020 08:26:13 +0200 (CEST)
Subject: Re: [PATCH] soundwire: Add generic bandwidth allocation algorithm
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <fdf22a3c-457f-09ef-8dc5-c0f3871cf2ce@perex.cz>
Date:   Wed, 9 Sep 2020 08:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 08. 09. 20 v 15:15 Bard Liao napsal(a):
> This algorithm computes bus parameters like clock frequency, frame
> shape and port transport parameters based on active stream(s) running
> on the bus.
> 
> Developers can also implement their own .compute_params() callback for
> specific resource management algorithm, and set if before calling
> sdw_add_bus_master()
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
> values were removed from the initial contribution to use BIOS
> information instead.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/Kconfig                     |   5 +
>  drivers/soundwire/Makefile                    |   3 +
>  drivers/soundwire/bus.c                       |   6 +
>  drivers/soundwire/bus.h                       |  46 +-
>  .../soundwire/generic_bandwidth_allocation.c  | 427 ++++++++++++++++++
>  drivers/soundwire/intel.c                     |   3 +
>  drivers/soundwire/stream.c                    |  12 +
>  include/linux/soundwire/sdw.h                 |   3 +
>  8 files changed, 503 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soundwire/generic_bandwidth_allocation.c

I did testing and I've not found any issues. The abstraction looks good.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
