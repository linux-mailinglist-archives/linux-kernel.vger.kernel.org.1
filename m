Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD261C116F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgEALWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 07:22:02 -0400
Received: from 8bytes.org ([81.169.241.247]:40862 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgEALWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:22:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5836A3A4; Fri,  1 May 2020 13:22:00 +0200 (CEST)
Date:   Fri, 1 May 2020 13:21:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jon.grimm@amd.com
Subject: Re: [PATCH] iommu/amd: Fix legacy interrupt remapping for
 x2APIC-enabled system
Message-ID: <20200501112157.GA18423@8bytes.org>
References: <1587562202-14183-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587562202-14183-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:30:02AM -0500, Suravee Suthikulpanit wrote:
> Currently, system fails to boot because the legacy interrupt remapping
> mode does not enable 128-bit IRTE (GA), which is required for x2APIC
> support.
> 
> Fix by using AMD_IOMMU_GUEST_IR_LEGACY_GA mode when booting with
> kernel option amd_iommu_intr=legacy instead. The initialization
> logic will check GASup and automatically fallback to using
> AMD_IOMMU_GUEST_IR_LEGACY if GA mode is not supported.
> 
> Fixes: 3928aa3f5775 ("iommu/amd: Detect and enable guest vAPIC support")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for v5.7, thanks Suravee.
