Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087CB27B0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgI1PXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:23:33 -0400
Received: from foss.arm.com ([217.140.110.172]:53448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1PXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:23:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5882B113E;
        Mon, 28 Sep 2020 08:23:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F193F70D;
        Mon, 28 Sep 2020 08:23:31 -0700 (PDT)
Date:   Mon, 28 Sep 2020 16:23:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        baolin.wang7@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Validate the node before setting node id for
 root bus
Message-ID: <20200928152326.GA15640@e121166-lin.cambridge.arm.com>
References: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
 <20200928140054.GA11500@willie-the-truck>
 <20200928144957.GA90366@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928144957.GA90366@VM20190228-100.tbsite.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:49:57PM +0800, Baolin Wang wrote:
> On Mon, Sep 28, 2020 at 03:00:55PM +0100, Will Deacon wrote:
> > [+ Lorenzo]
> > 
> > On Tue, Sep 22, 2020 at 06:33:24PM +0800, Baolin Wang wrote:
> > > If the BIOS disabled the NUMA configuration, but did not change the
> > > proximity domain description in the SRAT table, so the PCI root bus
> > > device may get a incorrect node id by acpi_get_node().
> > 
> > How "incorrect" are we talking here? What actually goes wrong? At some
> > point, we have to trust what the firmware is telling us.
> 
> What I mean is, if we disable the NUMA from BIOS

Please define what this means ie are you removing SRAT from ACPI static
tables ?

> but we did not change the PXM for the PCI devices, 

If a _PXM maps to a proximity domain that is not described in the SRAT
your firmware is buggy.

> so the PCI devices can still get a numa node id from acpi_get_node().
> For example, we can still get the numa node id = 1 in this case from
> acpi_get_node(), but the numa_nodes_parsed is empty, which means the
> node id 1 is invalid.  We should add a validation for the node id when
> setting the root bus node id.

The kernel is not a firmware validation test suite, so fix the firmware
please.

Having said that, please provide a trace log of the issue this is
causing, if any.

Thanks,
Lorenzo
