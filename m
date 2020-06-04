Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092731EE0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFDJQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 05:16:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgFDJQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:16:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51022AB87;
        Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Date:   Thu, 4 Jun 2020 11:16:19 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu: Don't attach deferred device in
 iommu_group_do_dma_attach
Message-ID: <20200604091619.GO6857@suse.de>
References: <20200604073142.74701-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604073142.74701-1-jsnitsel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Thu, Jun 04, 2020 at 12:31:42AM -0700, Jerry Snitselaar wrote:
> Attaching a deferred device should be delayed until dma api is called.
> 
> Cc: iommu@lists.linux-foundation.org
> Suggested-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> If you already have thrown a patch together, then ignore this. Also
> feel free to swap out the signed-off-by with your's since
> this is more your patch than mine. You can put a reviewed-by
> and tested-by instead for me.

Yeah, I already have a patch, just not sent out yet. I updated it with
your tags and will send it out shortly.

Regards,

	Joerg
