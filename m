Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC8C27B047
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgI1OuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:50:09 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54060 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgI1OuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:50:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UAN8ezQ_1601304597;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UAN8ezQ_1601304597)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Sep 2020 22:49:57 +0800
Date:   Mon, 28 Sep 2020 22:49:57 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, catalin.marinas@arm.com,
        baolin.wang7@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Validate the node before setting node id for
 root bus
Message-ID: <20200928144957.GA90366@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
 <20200928140054.GA11500@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928140054.GA11500@willie-the-truck>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:00:55PM +0100, Will Deacon wrote:
> [+ Lorenzo]
> 
> On Tue, Sep 22, 2020 at 06:33:24PM +0800, Baolin Wang wrote:
> > If the BIOS disabled the NUMA configuration, but did not change the
> > proximity domain description in the SRAT table, so the PCI root bus
> > device may get a incorrect node id by acpi_get_node().
> 
> How "incorrect" are we talking here? What actually goes wrong? At some
> point, we have to trust what the firmware is telling us.

What I mean is, if we disable the NUMA from BIOS, but we did not change
the PXM for the PCI devices, so the PCI devices can still get a numa
node id from acpi_get_node(). For example, we can still get the numa
node id = 1 in this case from acpi_get_node(), but the numa_nodes_parsed
is empty, which means the node id 1 is invalid. We should add a
validation for the node id when setting the root bus node id.

> 
> > Thus better to add a numa node validation before setting numa node
> > for the PCI root bus, like pci_acpi_root_get_node() does for X86
> > architecture.
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >  arch/arm64/kernel/pci.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 1006ed2..24fe2bd 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -86,9 +86,13 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >  		struct pci_config_window *cfg = bridge->bus->sysdata;
> >  		struct acpi_device *adev = to_acpi_device(cfg->parent);
> >  		struct device *bus_dev = &bridge->bus->dev;
> > +		int node = acpi_get_node(acpi_device_handle(adev));
> > +
> > +		if (node != NUMA_NO_NODE && !node_online(node))
> > +			node = NUMA_NO_NODE;
> 
> Hmm. afaict, acpi_get_node() tries quite hard to return a valid node when
> it gets back NUMA_NO_NODE in acpi_map_pxm_to_node(). Seems like we're
> undoing all of that here, which worries me because NUMA_NO_NODE is a bit
> of a loaded gun if you interpret it as a valid node.

I did not treate NUMA_NO_NODE as a valid node, I just add a validation
to validate if it is a valid node before setting. See my previous comments,
hopes I make things clear. Thanks.

> 
> Anyway, I defer to Lorenzo on this.
> 
> Will
