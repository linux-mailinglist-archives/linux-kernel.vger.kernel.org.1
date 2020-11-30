Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A992C8180
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgK3Jz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgK3Jz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:55:59 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073F7206D5;
        Mon, 30 Nov 2020 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606730118;
        bh=VJxe+aZIiySmBjnGlaSzQW1nZfVZVMjYsyKKXY2wN24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTc/MyMDZGaQb1aWyIXJO7isKzXuHw9n3D796W6lqshME6XMC6XtpUiAnp9oTN8ip
         cH6isvEIFEg0WYo/rfqT9aJcJliG5TrjVweoLcpc6YnZ9bX+xzWRFovsqcybXekYST
         b1V+2pDOrKh4pwVV+MgOPI2lm1HSsKdhW9PYoz+E=
Date:   Mon, 30 Nov 2020 09:55:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
Subject: Re: [PATCH v3] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20201130095512.GA24098@willie-the-truck>
References: <20201127060322.29025-1-liwei391@huawei.com>
 <861cf678-3e6f-7627-8d41-b9395cb6e5e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861cf678-3e6f-7627-8d41-b9395cb6e5e0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 12:03:35PM +0000, Suzuki K Poulose wrote:
> On 11/27/20 6:03 AM, Wei Li wrote:
> > Armv8.3 extends the SPE by adding:
> > - Alignment field in the Events packet, and filtering on this event
> >    using PMSEVFR_EL1.
> > - Support for the Scalable Vector Extension (SVE).
> > 
> > The main additions for SVE are:
> > - Recording the vector length for SVE operations in the Operation Type
> >    packet. It is not possible to filter on vector length.
> > - Incomplete predicate and empty predicate fields in the Events packet,
> >    and filtering on these events using PMSEVFR_EL1.
> > 
> > Update the check of pmsevfr for empty/partial predicated SVE and
> > alignment event in SPE driver. For adaption by the version of SPE,
> > expose 'pmsver' as cap attribute to userspace.
> > 
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> nit: Do we need to update the Kconfig help text too ? Right now that says :
> 
> --
> 
> 
> tristate "Enable support for the ARMv8.2 Statistical Profiling Extension""
> ....
> 
> help
>   Enable perf support for the ARMv8.2 Statistical Profiling
>   Extension, which provides periodic sampling of operations in

I think it's ok as-is, to be honest. It identifies the version of the
architecture when the feature was introduced, and I think it's only
reasonable to assume that subsequent versions of the architecture might
add extensions.

Will
