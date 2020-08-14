Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22FD244B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgHNPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 11:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHNPEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:04:36 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9396A20774;
        Fri, 14 Aug 2020 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597417476;
        bh=oisErVD0u+lyl37V1wBsI8bt6Y7+p7CbVMU/YvPDXtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrTxXsd1uArNVJnUs+ss6N08rc0GDHeyOnV/HaAHn0kjrRVBpJKfhpX7Q848Unzxm
         HTMX/XkrnvZztSYLgOghV6i4G0XxInbW0Gg6mYtsoc6uIKXUG2I9aVJwYa4o1dryRi
         fnPEdxXyrqpHLX83WXeO7t0EDMYe3WmxhPba1lyw=
Date:   Fri, 14 Aug 2020 08:04:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814071431.201400-1-ztong0001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ba725ae47305..c4f1ce0ee1e3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		dev_warn_ratelimited(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
>  			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, true);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +		nvme_dev_disable(dev, true);
>  		return BLK_EH_DONE;

Shouldn't this flag have been set in nvme_cancel_request()?  It's not
like the timeout out command is the only command to have been cancelled
by this action, nor is it guaranteed that getting here will mean the
request was in fact cancelled. The controller could still provide a real
completion.
