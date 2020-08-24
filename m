Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD42500B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgHXPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:16:46 -0400
Received: from verein.lst.de ([213.95.11.211]:54830 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgHXPN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:13:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26FBD68AFE; Mon, 24 Aug 2020 17:13:01 +0200 (CEST)
Date:   Mon, 24 Aug 2020 17:13:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     syzbot <syzbot+3f86afd0b1e4bf1cb64c@syzkaller.appspotmail.com>,
        thomas.tai@oracle.com, airlied@redhat.com, kraxel@redhat.com,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, hch@lst.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Is: virtio_gpu_object_shmem_init  issues? Was:Re: upstream
 boot error: general protection fault in swiotlb_map
Message-ID: <20200824151300.GA28575@lst.de>
References: <0000000000000c1f0005ac333382@google.com> <20200824150650.GD21321@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824150650.GD21321@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:06:51AM -0400, Konrad Rzeszutek Wilk wrote:
> So it fails at
> 
> 683                 dev_WARN_ONCE(dev, 1,                                           
> 684                         "swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> 685                         &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);   
> 
> 
> which makes no sense to me as `dev` surely exists. I can see in the console log:
> 
> virtio-pci 0000:00:01.0: vgaarb: deactivate vga console
> 
> So what gives?

Well, look at the if around the WARN_ON - dma_capable failed on the
swiotlb buffer. This means the virtio drm thingy has a dma mask
(either the actual one set by the driver, or bus_dma_mask), which isn't
enough to address the swiotlb buffer.
