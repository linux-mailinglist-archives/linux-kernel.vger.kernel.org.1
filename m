Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC391D0B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbgEMIvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgEMIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:51:07 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E91C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:51:07 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 723CA379; Wed, 13 May 2020 10:51:04 +0200 (CEST)
Date:   Wed, 13 May 2020 10:51:03 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
Message-ID: <20200513085102.GD9820@8bytes.org>
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 09:59:44AM +0800, Lu Baolu wrote:
> Lu Baolu (3):
>   iommu/vt-d: Allow 32bit devices to uses DMA domain
>   iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
>   iommu/vt-d: Apply per-device dma_ops
> 
>  drivers/iommu/intel-iommu.c | 396 +++---------------------------------
>  1 file changed, 26 insertions(+), 370 deletions(-)

Applied, thanks Baolu.
