Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52926FB26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRLHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:07:50 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B3220874;
        Fri, 18 Sep 2020 11:07:48 +0000 (UTC)
Date:   Fri, 18 Sep 2020 12:07:46 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Clint Sbisa <csbisa@amazon.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200918110745.GD6335@gaia>
References: <20200918033312.ddfpibgfylfjpex2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918033312.ddfpibgfylfjpex2@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 03:33:12AM +0000, Clint Sbisa wrote:
> This change exposes write-combine mappings under sysfs for
> prefetchable PCI resources on arm64.
> 
> Originally, the usage of "write combine" here was driven by the x86
> definition of write combine. This definition is specific to x86 and
> does not generalize to other architectures. However, the usage of WC
> has mutated to "write combine" semantics, which is implemented
> differently on each arch.
> 
> Generally, prefetchable BARs are accepted to allow speculative
> accesses, write combining, and re-ordering-- from the PCI perspective,
> this means there are no read side effects. (This contradicts the PCI
> spec which allows prefetchable BARs to have read side effects, but
> this definition is ill-advised as it is impossible to meet.) On x86,
> prefetchable BARs are mapped as WC as originally defined (with some
> conditionals on arch features). On arm64, WC is taken to mean normal
> non-cacheable memory.
> 
> In practice, write combine semantics are used to minimize write
> operations. A common usage of this is minimizing PCI TLPs which can
> significantly improve performance with PCI devices. In order to
> provide the same benefits to userspace, we need to allow userspace to
> map prefetchable BARs with write combine semantics. The resourceX_wc
> mapping is used today by userspace programs and libraries.
> 
> While this model is flawed as "write combine" is very ill-defined, it
> is already used by multiple non-x86 archs to expose write combine
> semantics to user space. We enable this on arm64 to give userspace on
> arm64 an equivalent mechanism for utilizing write combining with PCI
> devices.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Clint Sbisa <csbisa@amazon.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
