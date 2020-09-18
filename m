Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759C426F8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIRItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:49:18 -0400
Received: from 8bytes.org ([81.169.241.247]:45172 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgIRItO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:49:14 -0400
X-Greylist: delayed 773 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 04:49:14 EDT
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E5DCC39A; Fri, 18 Sep 2020 10:49:12 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:49:11 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH] iommu/amd: Add prefetch iommu pages command build
 function
Message-ID: <20200918084911.GI31590@8bytes.org>
References: <20200905071420.20190-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905071420.20190-1-wesley.sheng@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 03:14:20PM +0800, Wesley Sheng wrote:
> +static void build_pf_iommu_pages(struct iommu_cmd *cmd, u64 address,
> +					u16 devid, int pfcnt, bool size,
> +					bool inv)
> +{
> +	memset(cmd, 0, sizeof(*cmd));
> +
> +	address &= PAGE_MASK;
> +
> +	cmd->data[0]  = devid;
> +	cmd->data[0] |= (pfcnt & 0xff) << 24;
> +	cmd->data[2]  = lower_32_bits(address);
> +	cmd->data[3]  = upper_32_bits(address;
> +	if (size)
> +		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
> +	if (inv)
> +		cmd->data[2] |= CMD_PF_IOMMU_PAGES_INV_MASK;
> +	CMD_SET_TYPE(cmd, CMD_PF_IOMMU_PAGES);
> +}

This also needs to add a user of this function.
