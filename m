Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B514C1C0EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgEAHdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 03:33:00 -0400
Received: from verein.lst.de ([213.95.11.211]:45092 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:33:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A94968D07; Fri,  1 May 2020 09:32:56 +0200 (CEST)
Date:   Fri, 1 May 2020 09:32:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 15/15] nvme: avoid gcc-10 zero-length-bounds warning
Message-ID: <20200501073256.GA23452@lst.de>
References: <20200430213101.135134-1-arnd@arndb.de> <20200430213101.135134-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430213101.135134-16-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:30:57PM +0200, Arnd Bergmann wrote:
> When CONFIG_ARCH_NO_SG_CHAIN is set, op->sgl[0] cannot be dereferenced,
> as gcc-10 now points out:
> 
> drivers/nvme/host/fc.c: In function 'nvme_fc_init_request':
> drivers/nvme/host/fc.c:1774:29: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct scatterlist[0]' [-Wzero-length-bounds]
>  1774 |  op->op.fcp_req.first_sgl = &op->sgl[0];
>       |                             ^~~~~~~~~~~
> drivers/nvme/host/fc.c:98:21: note: while referencing 'sgl'
>    98 |  struct scatterlist sgl[NVME_INLINE_SG_CNT];
>       |                     ^~~
> 
> I don't know if this is a legitimate warning or a false-positive.
> If this is just a false alarm, the warning is easily suppressed
> by interpreting the array as a pointer.

This looks like a surpression to be, but then again I find the new
code actually cleaner, so I'm fine with it :)
