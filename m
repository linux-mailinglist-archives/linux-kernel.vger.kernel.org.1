Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC927FC00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgJAIzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:55:51 -0400
Received: from foss.arm.com ([217.140.110.172]:56276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgJAIzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:55:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BF8D6E;
        Thu,  1 Oct 2020 01:55:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B29D3F70D;
        Thu,  1 Oct 2020 01:55:44 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:55:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        baolin.wang7@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Validate the node before setting node id for
 root bus
Message-ID: <20201001085538.GA5142@e121166-lin.cambridge.arm.com>
References: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
 <20200928140054.GA11500@willie-the-truck>
 <20200928144957.GA90366@VM20190228-100.tbsite.net>
 <20200928152326.GA15640@e121166-lin.cambridge.arm.com>
 <26284ca5-ea05-0496-629d-9951f49dda8f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26284ca5-ea05-0496-629d-9951f49dda8f@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:41:29PM +0800, Baolin Wang wrote:
> Hi,
> 
> 锟斤拷 2020/9/28 23:23, Lorenzo Pieralisi 写锟斤拷:
> > On Mon, Sep 28, 2020 at 10:49:57PM +0800, Baolin Wang wrote:
> > > On Mon, Sep 28, 2020 at 03:00:55PM +0100, Will Deacon wrote:
> > > > [+ Lorenzo]
> > > > 
> > > > On Tue, Sep 22, 2020 at 06:33:24PM +0800, Baolin Wang wrote:
> > > > > If the BIOS disabled the NUMA configuration, but did not change the
> > > > > proximity domain description in the SRAT table, so the PCI root bus
> > > > > device may get a incorrect node id by acpi_get_node().
> > > > 
> > > > How "incorrect" are we talking here? What actually goes wrong? At some
> > > > point, we have to trust what the firmware is telling us.
> > > 
> > > What I mean is, if we disable the NUMA from BIOS
> > 
> > Please define what this means ie are you removing SRAT from ACPI static
> > tables ?
> 
> Yes.
> 
> > 
> > > but we did not change the PXM for the PCI devices,
> > 
> > If a _PXM maps to a proximity domain that is not described in the SRAT
> > your firmware is buggy.
> 
> Sorry for confusing, that's not what I mean. When the BIOS disable the NUMA
> (remove the SRAT table), but the PCI devices' _PXM description is still
> available, which means we can still get the pxm from acpi_evaluate_integer()
> in this case.

There should not be a _PXM object if the SRAT is not available, that's
a firmware bug.

> So we can get below inconsistent log on ARM platform:
> "No NUMA configuration found
> PCI_bus 0000:00 on NUMA node 0
> ...
> PCI_bus 0000:e3 on NUMA node 1"
> 
> On X86, the pci_acpi_root_get_node() will validate the node before setting
> the node id for root bus. So I think we can add this validation for ARM
> platform. Or anything else I missed?

We are not adding checks because x86 does it, it is certainly to paper
over a firmware bug that you hopefully still have a chance to fix,
let's do that instead of adding code that is not necessary.

Lorenzo
