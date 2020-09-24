Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AB276CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgIXJJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:09:00 -0400
Received: from 8bytes.org ([81.169.241.247]:46258 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgIXJI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:08:59 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C04143D1; Thu, 24 Sep 2020 11:08:58 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:08:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     ahuang12@lenovo.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/amd: Treat per-device exclusion ranges as
 r/w unity-mapped regions"
Message-ID: <20200924090857.GG27174@8bytes.org>
References: <20200923022655.750-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923022655.750-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:26:55AM +0800, Baoquan He wrote:
> A regression failure of kdump kernel boot was reported on a HPE system.
> Bisect points at commit 387caf0b759ac43 ("iommu/amd: Treat per-device
> exclusion ranges as r/w unity-mapped regions") as criminal. Reverting it
> fix the failure.
> 
> With the commit, kdump kernel will always print below error message, then
> naturally AMD iommu can't function normally during kdump kernel bootup.
> 
>   ~~~~~~~~~
>   AMD-Vi: [Firmware Bug]: IVRS invalid checksum
> 
> Why commit 387caf0b759ac43 causing it haven't been made clear.

I think this should be debugged further, in future IOMMUs the exclusion
range feature will not be available anymore (mmio-fields get re-used for
SNP). So starting to use them again is not going to work.

Regards,

	Joerg

