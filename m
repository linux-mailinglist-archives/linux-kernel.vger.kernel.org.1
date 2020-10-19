Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A1B2926F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgJSMHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJSMHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:07:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D5C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:07:14 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B88B5E97; Mon, 19 Oct 2020 14:07:11 +0200 (CEST)
Date:   Mon, 19 Oct 2020 14:07:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
Message-ID: <20201019120708.GE3635@8bytes.org>
References: <20201013073055.11262-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201013073055.11262-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 09:30:55AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
> with no supported address widths") dmar.c needs struct iommu_device to
> be selected. We can drop this dependency by not dereferencing struct
> iommu_device if IOMMU_API is not selected and by reusing the information
> stored in iommu->drhd->ignored instead.
> 
> This fixes the following build error when IOMMU_API is not selected:
> 
> drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
> drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
>  1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
>                                                 ^
> 
> Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no supported address widths")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/iommu/intel/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

