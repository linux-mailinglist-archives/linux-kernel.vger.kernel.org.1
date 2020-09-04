Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5625D545
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgIDJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:39:49 -0400
Received: from 8bytes.org ([81.169.241.247]:41010 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgIDJjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:39:49 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2631D9CE; Fri,  4 Sep 2020 11:39:47 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:39:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Message-ID: <20200904093945.GO6714@8bytes.org>
References: <20200828000615.8281-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828000615.8281-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 08:06:15AM +0800, Lu Baolu wrote:
> The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG General
> Description) that:
> 
> If multiple control fields in this register need to be modified, software
> must serialize the modifications through multiple writes to this register.
> 
> However, in irq_remapping.c, modifications of IRE and CFI are done in one
> write. We need to do two separate writes with STS checking after each. It
> also checks the status register before writing command register to avoid
> unnecessary register write.
> 
> Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out security warning mess")
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/irq_remapping.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied for v5.9, thanks.

