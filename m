Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5072A244C52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgHNPti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 11:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgHNPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:49:37 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE1B2065C;
        Fri, 14 Aug 2020 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597420177;
        bh=nKMB2n6h4H07i5MOFAlmOIgxd/q+six6L2vpUwy5jBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bx+CZz3fLDRBLGzM/6BNkOTVSb8YrcUs4/ZqqRdTjJvZ7kuJbWEiV8YfSKfQcv+0e
         NR+4SvAPHpL5tfohmUeYweSO9zOffLkhfb4cOf3mmKYmeVE4Q/C4NSoFgxkisvsBdx
         j4sfplKo8mCwger95kM2iHh4swLhTLJ8BuqTLraw=
Date:   Fri, 14 Aug 2020 08:49:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth and
 nvme_queue.q_depth
Message-ID: <20200814154934.GB3772144@dhcp-10-100-145-180.wdl.wdc.com>
References: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:34:25PM +0800, John Garry wrote:
> Fix by making onto a u32.
> 
> Also use u32 for nvme_dev.q_depth, as we assign this value from
> nvme_dev.q_depth, and nvme_dev.q_depth will possibly hold 65536 - this
> avoids the same crash as above.
> 
> Fixes: 61f3b8963097 ("nvme-pci: use unsigned for io queue depth")
> Signed-off-by: John Garry <john.garry@huawei.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
