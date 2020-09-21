Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD4272989
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgIUPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgIUPIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:08:37 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC00C2075E;
        Mon, 21 Sep 2020 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600700917;
        bh=GEfKBDsAq9Cn4LzuqJLcIihd6H6TDcY0ig26pwzvOu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSZlx7OJA7OyfF9J5l44+k6f8IVBUKDnylqW7KkV1ZVRwCJx+zSfr8oDEiJKtP1IK
         g5aP48XSvXBMN4bXc9ytiUWSn2M9Gj/INQbLERiHnXiLcxRXJ/49vYo3U79ZocFNKe
         Z5Ip7591VPGM63DBJNo9GMxUMZXQ034BW21evelY=
Date:   Mon, 21 Sep 2020 08:08:24 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Message-ID: <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921021052.10462-1-tian.xianting@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:10:52AM +0800, Xianting Tian wrote:
> @@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> -		dev_warn(nvmeq->dev->ctrl.device,
> -			"invalid id %d completed on queue %d\n",
> -			cqe->command_id, le16_to_cpu(cqe->sq_id));
> -		return;
> -	}
> -
>  	/*
>  	 * AEN requests are special as they don't time out and can
>  	 * survive any kind of queue freeze and often don't respond to
> @@ -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (unlikely(!req)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"req is null for tag %d completed on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}

This is making sense now, though I think we should retain the existing
dev_warn() since it's still accurate and provides continuity for people
who are used to looking for these sorts of messages.

Your changelog is a bit much though. I think we can say it a bit more
succinctly. This is what I'm thinking:

  The driver registers interrupts for queues before initializing the
  tagset because it uses the number of successful request_irq() calls
  to configure the tagset parameters. This allows a race condition with
  the current tag validity check if the controller happens to produce
  an interrupt with a corrupted CQE before the tagset is initialized.

  Replace the driver's indirect tag check with the one already provided
  by the block layer.
