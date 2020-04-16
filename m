Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE51AB929
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437468AbgDPHBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:01:15 -0400
Received: from verein.lst.de ([213.95.11.211]:49709 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436624AbgDPHBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:01:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E33368C4E; Thu, 16 Apr 2020 09:01:03 +0200 (CEST)
Date:   Thu, 16 Apr 2020 09:01:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/3] iommu/vt-d: Allow 32bit devices to uses DMA
 domain
Message-ID: <20200416070102.GA12588@lst.de>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com> <20200416062354.10307-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416062354.10307-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 02:23:52PM +0800, Lu Baolu wrote:
> Currently, if a 32bit device initially uses an identity domain,
> Intel IOMMU driver will convert it forcibly to a DMA one if its
> address capability is not enough for the whole system memory.
> The motivation was to overcome the overhead caused by possible
> bounced buffer.
> 
> Unfortunately, this improvement has led to many problems. For
> example, some 32bit devices are required to use an identity
> domain, forcing them to use DMA domain will cause the device
> not to work anymore. On the other hand, the VMD sub-devices
> share a domain but each sub-device might have different address
> capability. Forcing a VMD sub-device to use DMA domain blindly
> will impact the operation of other sub-devices without any
> notification. Further more, PCI aliased devices (PCI bridge
> and all devices beneath it, VMD devices and various devices
> quirked with pci_add_dma_alias()) must use the same domain.
> Forcing one device to switch to DMA domain during runtime
> will cause in-fligh DMAs for other devices to abort or target
> to other memory which might cause undefind system behavior.

This commit log doesn't actually explain what you are chaning, and
as far as I can tell it just removes the code to change the domain
at run time, which seems to not actually match the subject or
description.  I'd need to look at the final code, but it seems like
this will still cause bounce buffering instead of using dynamic
mapping, which still seems like an awful idea.

Also from a purely stylistic perspective a lot of the lines seem
very short and not use up the whole 73 charaters allowed.
