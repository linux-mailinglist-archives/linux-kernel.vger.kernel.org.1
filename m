Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77471E464C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbgE0OpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:45:24 -0400
Received: from 8bytes.org ([81.169.241.247]:45026 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387942AbgE0OpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:45:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 985AE3C3; Wed, 27 May 2020 16:45:22 +0200 (CEST)
Date:   Wed, 27 May 2020 16:45:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] ia64: Hide the archdata.iommu field behind generic
 IOMMU_API
Message-ID: <20200527144521.GL5221@8bytes.org>
References: <20200518120855.27822-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518120855.27822-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:08:54PM +0200, Krzysztof Kozlowski wrote:
> There is a generic, kernel wide configuration symbol for enabling the
> IOMMU specific bits: CONFIG_IOMMU_API.  Implementations (including
> INTEL_IOMMU driver) select it so use it here as well.
> 
> This makes the conditional archdata.iommu field consistent with other
> platforms and also fixes any compile test builds of other IOMMU drivers,
> when INTEL_IOMMU is not selected).
> 
> For the case when INTEL_IOMMU and COMPILE_TEST are not selected, this
> should create functionally equivalent code/choice.  With COMPILE_TEST
> this field could appear if other IOMMU drivers are chosen but
> INTEL_IOMMU not.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> See:
> https://lore.kernel.org/lkml/202005181412.frC4juFy%25lkp@intel.com/
> ---
>  arch/ia64/include/asm/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied both to iommu/fixes.

