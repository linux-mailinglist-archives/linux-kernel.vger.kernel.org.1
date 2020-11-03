Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5E2A4620
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgKCNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgKCNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:21:37 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3616C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 05:21:36 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 517183A5; Tue,  3 Nov 2020 14:21:35 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:21:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Increase interrupt remapping table limit to
 512 entries
Message-ID: <20201103132133.GF22888@8bytes.org>
References: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:50:02AM +0000, Suravee Suthikulpanit wrote:
> Certain device drivers allocate IO queues on a per-cpu basis.
> On AMD EPYC platform, which can support up-to 256 cpu threads,
> this can exceed the current MAX_IRQ_PER_TABLE limit of 256,
> and result in the error message:
> 
>     AMD-Vi: Failed to allocate IRTE
> 
> This has been observed with certain NVME devices.
> 
> AMD IOMMU hardware can actually support upto 512 interrupt
> remapping table entries. Therefore, update the driver to
> match the hardware limit.
> 
> Please note that this also increases the size of interrupt remapping
> table to 8KB per device when using the 128-bit IRTE format.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied for 5.10, thanks.

