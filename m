Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4415B226193
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGTOGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:06:05 -0400
Received: from verein.lst.de ([213.95.11.211]:47128 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:06:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA26068BFE; Mon, 20 Jul 2020 16:06:01 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:06:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 3/9] nvme: Move nvme_passthru_[start|end]() calls
 to common helper
Message-ID: <20200720140601.GC4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com> <20200716203319.16022-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:33:13PM -0600, Logan Gunthorpe wrote:
> Introduce a new nvme_execute_passthru_rq() helper which calls
> nvme_passthru_[start|end]() around blk_execute_rq(). This ensures
> all passthru calls (including nvme_submit_io()) will be wrapped
> appropriately.
> 
> nvme_execute_passthru_rq() will also be useful for the nvmet passthru
> code.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

although maybe you could have moved the code you changed in the
last patch up already to not just move it after changing it in the
last one.
