Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA227AF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1OBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgI1OBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:01:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D924221548;
        Mon, 28 Sep 2020 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601301660;
        bh=/ELCcQyKlXa9GsKHkE/2hJw5eZU7yb263YSBGGdaC7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjYAfab1eKYDxlwjsoNB8Um7O2aDemw232xfilyQlrRSF5j9t6AFkCJCrNZwpWAeH
         ShYhbTZjTA8W4v2gpR8/mrnsov1/N7R24mz6Y1hDbZWgiBmEwmBbl+Q7hvg1JEDZ0O
         tsrYiUBBWiiXlFXzKW3wrL29nLhY5FKMtO5OFpDs=
Date:   Mon, 28 Sep 2020 15:00:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        lorenzo.pieralisi@arm.com
Cc:     catalin.marinas@arm.com, baolin.wang7@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Validate the node before setting node id for
 root bus
Message-ID: <20200928140054.GA11500@willie-the-truck>
References: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Lorenzo]

On Tue, Sep 22, 2020 at 06:33:24PM +0800, Baolin Wang wrote:
> If the BIOS disabled the NUMA configuration, but did not change the
> proximity domain description in the SRAT table, so the PCI root bus
> device may get a incorrect node id by acpi_get_node().

How "incorrect" are we talking here? What actually goes wrong? At some
point, we have to trust what the firmware is telling us.

> Thus better to add a numa node validation before setting numa node
> for the PCI root bus, like pci_acpi_root_get_node() does for X86
> architecture.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/kernel/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2..24fe2bd 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -86,9 +86,13 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  		struct pci_config_window *cfg = bridge->bus->sysdata;
>  		struct acpi_device *adev = to_acpi_device(cfg->parent);
>  		struct device *bus_dev = &bridge->bus->dev;
> +		int node = acpi_get_node(acpi_device_handle(adev));
> +
> +		if (node != NUMA_NO_NODE && !node_online(node))
> +			node = NUMA_NO_NODE;

Hmm. afaict, acpi_get_node() tries quite hard to return a valid node when
it gets back NUMA_NO_NODE in acpi_map_pxm_to_node(). Seems like we're
undoing all of that here, which worries me because NUMA_NO_NODE is a bit
of a loaded gun if you interpret it as a valid node.

Anyway, I defer to Lorenzo on this.

Will
