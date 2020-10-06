Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3381285293
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgJFTif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:38:35 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:35539 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJFTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:38:34 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E95E1100EF4DD;
        Tue,  6 Oct 2020 21:38:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B7738656AC; Tue,  6 Oct 2020 21:38:30 +0200 (CEST)
Date:   Tue, 6 Oct 2020 21:38:30 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Add check for DL_ACTIVE bit in
 pciehp_check_link_status()
Message-ID: <20201006193830.GA32510@wunner.de>
References: <1602008668-43646-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602008668-43646-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 01:24:28PM -0500, Sanjay R Mehta wrote:
> if DL_ACTIVE bit is set it means that there is no need to check
> PCI_EXP_LNKSTA_LT bit, as DL_ACTIVE would have set only if the link
> is already trained. Hence adding a check which takes care of this
> scenario.

Sorry for being dense but I don't understand this at all:

The PCI_EXP_DPC_CAP_DL_ACTIVE bit which you check here indicates
that the port is capable of sending an ERR_COR interrupt whenever
the link transitions from inactive to active.

What is the connection to the PCI_EXP_LNKSTA_LT bit (which indicates
that the link is still being trained)?

Also, the negation of a bitwise AND is always either 0 or 1
(!(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)), so bit 0 is set or not set.
However PCI_EXP_LNKSTA_LT is bit 11.  A bitwise AND of bit 11 and 0 is
always 0, so the expression can never be 1.

Am I missing something?

Thanks,

Lukas

> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 53433b3..81d1348 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -309,7 +309,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>  	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> -	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
> +	if (((lnk_status & PCI_EXP_LNKSTA_LT) &
> +	     !(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)) ||
>  	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
>  		ctrl_err(ctrl, "link training error: status %#06x\n",
>  			 lnk_status);
> -- 
> 2.7.4
