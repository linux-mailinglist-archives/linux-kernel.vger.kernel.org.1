Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B02BABDE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKTO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKTO36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:29:58 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED1A2224C;
        Fri, 20 Nov 2020 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605882597;
        bh=D7G2QiwBgP/TgokMQw/VvHYyaDp0QQP9o0ZunMnsyT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isGoTN8kfGIgpSbhE+UqwrB7/Skyo0gqfxICHnyceiFYzpW00hjsAjBTvntcyUKxY
         afDFDsZQttR236cf1dHhTGnTaLfA+HEH5+fdi4lZYwo2byBxGXd6i8OANyBUXmE2Xz
         trRVLG/1iNk40+kUv+JMvCu2+p4E75DwEvxTLhWM=
Date:   Fri, 20 Nov 2020 06:29:54 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Roeder <tmroeder@google.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201120142954.GC2855047@dhcp-10-100-145-180.wdc.com>
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120080243.GA20463@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
> > This patch changes the NVMe PCI implementation to cache host_mem_descs
> > in non-DMA memory instead of depending on descriptors stored in DMA
> > memory. This change is needed under the malicious-hypervisor threat
> > model assumed by the AMD SEV and Intel TDX architectures, which encrypt
> > guest memory to make it unreadable. Some versions of these architectures
> > also make it cryptographically hard to modify guest memory without
> > detection.
> 
> I don't think this is a useful threat model, and I've not seen a
> discussion on lkml where we had any discussion on this kind of threat
> model either.
> 
> Before you start sending patches that regress optimizations in various
> drivers (and there will be lots with this model) we need to have a
> broader discussion first.
> 
> And HMB support, which is for low-end consumer devices that are usually
> not directly assigned to VMs aren't a good starting point for this.

Yeah, while doing this for HMB isn't really a performance concern, this
method for chaining SGL/PRP lists would be.

And perhaps more importantly, the proposed mitigation only lets the
guest silently carry on from such an attack while the device is surely
corrupting something. I think we'd rather free the wrong address since
that may at least eventually raise an error.
