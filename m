Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722A92BA43F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgKTICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:02:47 -0500
Received: from verein.lst.de ([213.95.11.211]:41816 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKTICr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:02:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D6FE467373; Fri, 20 Nov 2020 09:02:43 +0100 (CET)
Date:   Fri, 20 Nov 2020 09:02:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Roeder <tmroeder@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201120080243.GA20463@lst.de>
References: <20201120012738.2953282-1-tmroeder@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120012738.2953282-1-tmroeder@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
> This patch changes the NVMe PCI implementation to cache host_mem_descs
> in non-DMA memory instead of depending on descriptors stored in DMA
> memory. This change is needed under the malicious-hypervisor threat
> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
> guest memory to make it unreadable. Some versions of these architectures
> also make it cryptographically hard to modify guest memory without
> detection.

I don't think this is a useful threat model, and I've not seen a
discussion on lkml where we had any discussion on this kind of threat
model either.

Before you start sending patches that regress optimizations in various
drivers (and there will be lots with this model) we need to have a
broader discussion first.

And HMB support, which is for low-end consumer devices that are usually
not directly assigned to VMs aren't a good starting point for this.
