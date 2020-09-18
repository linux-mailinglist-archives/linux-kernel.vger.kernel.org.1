Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0B22704E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRTUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:20:37 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEB120848;
        Fri, 18 Sep 2020 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600456837;
        bh=Ojjtf3XxHVf8O7TWPo1OaH20IQUd/Rub717GJHX/1Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rndya9PoIkPmLOdSjEDwVErbNQhO1Zhg3JzC0oan4cqT20VceloTqr22iTh8cNJaF
         3X5iVX8aJ9l2+1WkAuh7o7jAkMlrmDL6C/ttRv9Klw6u9BLt2dYF0ttqtMs/sN1VCa
         3wLNQAMVdH692FpMKFDPJTDKaZHu4+sVIPFtUWnE=
Date:   Fri, 18 Sep 2020 12:20:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Message-ID: <20200918192034.GA4030837@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200918104420.30219-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918104420.30219-1-tian.xianting@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:44:20PM +0800, Xianting Tian wrote:
> @@ -940,7 +940,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> +	if (unlikely(cqe->command_id >=
> +			nvmeq->qid ? nvmeq->dev->tagset.queue_depth :
> +			nvmeq->dev->admin_tagset.queue_depth)) {

Both of these values are set before blk_mq_alloc_tag_set(), so you still
have a race. The interrupt handler probably just shouldn't be registered
with the queue before the tagset is initialized since there can't be any
work for the handler to do before that happens anyway.

The controller is definitely broken, though, and will lead to
unavoidable corruption if it's really behaving this way.
