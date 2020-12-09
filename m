Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634CE2D497A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgLISvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732952AbgLISvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:51:06 -0500
Date:   Wed, 9 Dec 2020 18:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607539825;
        bh=SmGD0Wngs0iUrS/PQuc7mTBZo1p0nDrXrdnb6+e6Q8c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=h514HCk5J29VZl6jAzdiaTmwdyhtAwB4Efnqyjv0E9sWa6jSVwwpeEPdOChE15rDt
         EyFwPWhGW160CrgbIKrD6eZWty4qYvBEIgOgNbweHYTIZyf0wBHumOmMfxShsgtDS+
         QtDnSjmM4+HYYK/sPYDLh+DSXvxU9aWpoNlziEZhgWbO4wpPo2fmYWlpSJ/6V/ItVP
         t7MxYJioTGYWd7Ynq/eA+SW2X7DIJhIuIngVnMWEJ4mB1AdKQUr7BaHrOZskK2bbra
         JUWvs2RVNBrWFfpR5AO7TE5yszlzeF9G7ShZW7zyH14dzX+syRLZrkbsxrcc0IDwDF
         nOd6FHcGNHrWQ==
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
Message-ID: <20201209185020.GC8778@willie-the-truck>
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
> >
> > Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
> > for a fix, where the size of the interrupt remapping table was increased
> > but a related constant for the size of the interrupt table was forgotten.
> 
> Pulled.

Thanks.

> However, why didn't this then add some sanity checking for the two
> different #defines to be in sync?
> 
> IOW, something like
> 
>    #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
> 
>    #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
>    #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)
> 
> or whatever. Hmm?

This looks like a worthwhile change to me, but I don't have any hardware
so I've been very reluctant to make even "obvious" driver changes here.

Suravee -- please can you post a patch implementing the above?

> That way this won't happen again, but perhaps equally importantly the
> linkage will be more clear, and there won't be those random constants.
> 
> Naming above is probably garbage - I assume there's some actual
> architectural name for that irq table length field in the DTE?

The one in the spec is even better: "IntTabLen".

Will
