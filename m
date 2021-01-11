Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0792F1ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbhAKQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:19:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:59104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbhAKQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:19:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F6A4AD57;
        Mon, 11 Jan 2021 16:18:57 +0000 (UTC)
Date:   Mon, 11 Jan 2021 17:18:57 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210111161857.okecoo4h4b4prpic@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
 <20210104210610.hliiupywksawgei3@hyori>
 <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
 <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:00:18PM +0100, Hannes Reinecke wrote:
> Yeah, using the controller node for devm allocations is quite dodgy.
> Does this one help?
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 6fdd07fb3001..7260af028cf7 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -226,7 +226,7 @@ static const struct hwmon_chip_info
> 
>  int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  {
> -       struct device *dev = ctrl->dev;
> +       struct device *dev = ctrl->device;

This is what I tried. Yes, it fixes the obvious problem and moves the
hwmon entry under the nvme entry. When the nvme is destroyed, the hwmon
entry is not accessible. But as ctrl->device is not managed by devm the
resources are not freed.

