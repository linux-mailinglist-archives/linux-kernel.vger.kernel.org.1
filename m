Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C426CD03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIPUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIPQy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:56 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9762221F1;
        Wed, 16 Sep 2020 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600275276;
        bh=Ggu67kQ5Z6Y2gHRAwgKBqvNHtiu2B+7/8drm5WugluM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVRuy/9TjeVkfwZYcbT1oCJkkYu7TBej+6nKXQPKxmKMxqFJOPxa88bFP+19ymmrj
         BSHB8MAMBhLTkjfpsB0sD20wGRZsKz3zj2biOWQFMxA4mHfLPCatUp+q9jZmf3SRVm
         8bt0/gIzYHAei9/QHb9+C/J2x0ZEfHpq1GjYWSOk=
Date:   Wed, 16 Sep 2020 09:54:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
Message-ID: <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153648.5475-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916153648.5475-1-ztong0001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:36:49AM -0400, Tong Zhang wrote:
> @@ -960,6 +960,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (!req)
> +		return;

As I mentioned before, blk_mq_tag_to_rq() returns NULL if the tag
exceeds the depth. We already verify the tag prior to calling this
function, so what's the real root cause for how we're winding up with
NULL here? I'm only asking this because it sounds like there's a bug
somewhere else and this change is masking over it.


>  	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>  	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
>  		nvme_pci_complete_rq(req);
