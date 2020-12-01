Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3202CA6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbgLAPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389082AbgLAPRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:17:15 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F562076C;
        Tue,  1 Dec 2020 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606835794;
        bh=kaWvN9i8+huMf6AvIgORWlRpPgxN5rIfIaVjaqvGCOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzlUt+pJA+53SO3UFHzReNIIGMqWwngpZV58v7zwdNbEPDLYhfZ7hSfaKCR/PE0Pr
         WZMdHo+6deBAaRDCbOKL8BxTOMUAY7Un0N86t/8fCgnojRxVUk0N+XS/nWrm9gWT/z
         U19oFOIyk90LIC7gNQkqXYcXKhd2gWICcgGc+BPw=
Date:   Wed, 2 Dec 2020 00:16:28 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk,
        damien.lemoal@wdc.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        selvajove@gmail.com, nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com
Subject: Re: [RFC PATCH 2/2] nvme: add simple copy support
Message-ID: <20201201151628.GA27728@redsun51.ssa.fujisawa.hgst.com>
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e@epcas5p4.samsung.com>
 <20201201053949.143175-3-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201053949.143175-3-selvakuma.s1@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:09:49AM +0530, SelvaKumar S wrote:
> +static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
> +				       struct nvme_id_ns *id)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	struct request_queue *queue = disk->queue;
> +
> +	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
> +		queue->limits.max_copy_sectors = 0;
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
> +		return;
> +	}
> +
> +	/* setting copy limits */
> +	ns->mcl = le64_to_cpu(id->mcl);
> +	ns->mssrl = le32_to_cpu(id->mssrl);
> +	ns->msrc = id->msrc;

These are not used anywhere outside this function, so there's no need to
add members to the struct.

> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue))
> +		return;

The queue limits are not necessarily the same each time we're called to
update the disk info, so this return shouldn't be here.

> +
> +	queue->limits.max_copy_sectors = ns->mcl * (1 << (ns->lba_shift - 9));
> +	queue->limits.max_copy_range_sectors = ns->mssrl *
> +		(1 << (ns->lba_shift - 9));
> +	queue->limits.max_copy_nr_ranges = ns->msrc + 1;
> +}

<>

> @@ -2045,6 +2133,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	set_capacity_and_notify(disk, capacity);
>  
>  	nvme_config_discard(disk, ns);
> +	nvme_config_copy(disk, ns, id);
>  	nvme_config_write_zeroes(disk, ns);
>  
>  	if (id->nsattr & NVME_NS_ATTR_RO)
> @@ -3014,6 +3103,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	ctrl->oaes = le32_to_cpu(id->oaes);
>  	ctrl->wctemp = le16_to_cpu(id->wctemp);
>  	ctrl->cctemp = le16_to_cpu(id->cctemp);
> +	ctrl->ocfs = le32_to_cpu(id->ocfs);

ocfs is not used anywhere.
