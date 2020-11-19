Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7747C2B9CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgKSVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgKSVJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:09:18 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20E822255;
        Thu, 19 Nov 2020 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605820157;
        bh=wobWbrfe+CcBfAqh6g1sHmyepcpP3tuS6adaYB2sqNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX9gKLP40Y036drTN5kXwWv7ntyy0/4K4wht1FrMjOGTY7+WYClrYAi61GWWeUcda
         QHt7JNCDAr6UlQTfIXDfl21Z7SKYuakRPErWkTMlfS4eCZ50RmSNgrKPC6qDUs+005
         hO0pO+OriwUpiDtdlBoYNC2MLiaz7UCAEab/zPRg=
Date:   Thu, 19 Nov 2020 13:09:14 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Tom Roeder <tmroeder@google.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201119210914.GB2855047@dhcp-10-100-145-180.wdc.com>
References: <20201119185919.2742954-1-tmroeder@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119185919.2742954-1-tmroeder@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:59:19AM -0800, Tom Roeder wrote:
> This patch changes the NVMe PCI implementation to cache host_mem_descs
> in non-DMA memory instead of depending on descriptors stored in DMA
> memory. This change is needed under the malicious-hypervisor threat
> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
> guest memory to make it unreadable. Some versions of these architectures
> also make it cryptographically hard to modify guest memory without
> detection.
> 
> On these architectures, Linux generally leaves DMA memory unencrypted so
> that devices can still communicate directly with the kernel: DMA memory
> remains readable to and modifiable by devices. This means that this
> memory is also accessible to a hypervisor.
> 
> However, this means that a malicious hypervisor could modify the addr or
> size fields of descriptors and cause the NVMe driver to call
> dma_free_attrs on arbitrary addresses or on the right addresses but with
> the wrong size. To prevent this attack, this commit changes the code to
> cache those descriptors in non-DMA memory and to use the cached values
> when freeing the memory they describe.
 
If the hypervisor does that, then the device may use the wrong
addresses, too. I guess you can't do anything about that from the
driver, though.

> +	/* Cache the host_mem_descs in non-DMA memory so a malicious hypervisor
> +	 * can't change them.
> +	 */
> +	struct nvme_host_mem_buf_desc *host_mem_descs_cache;
>  	void **host_mem_desc_bufs;

This is never seen by an nvme device, so no need for an nvme specific
type here. You can use arch native types.
