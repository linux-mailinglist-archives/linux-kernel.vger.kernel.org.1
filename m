Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CB2A46AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgKCNhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:37:31 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E95C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 05:37:31 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CD294433; Tue,  3 Nov 2020 14:37:29 +0100 (CET)
Date:   Tue, 3 Nov 2020 14:37:28 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com,
        jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 0/2] iommu: Fix a few issues related to PRQ
Message-ID: <20201103133728.GJ22888@8bytes.org>
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:37:22AM +0800, Yi Sun wrote:
> We found a few issues about PRQ. So, two patches are cooked to
> fix them. Please have a review. Thanks!
> 
> Changes from v1:
> ================
> - Modify subject of patch 1 to make it more accurate.
> - Move get_domain_info() up to the sanity check part in patch 1.
> - Remove v1 patch 2 which is not suitable.
> - Add description for current patch 2.
> - Add 'Fixes:' tags for all patches.
> 
> Liu Yi L (1):
>   iommu/vt-d: Fix sid not set issue in in intel_svm_bind_gpasid()
> 
> Liu, Yi L (1):
>   iommu/vt-d: Fix a bug for PDP check in prq_event_thread
> 
>  drivers/iommu/intel/svm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied for v5.10, thanks.
