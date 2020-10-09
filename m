Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8146288702
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbgJIKeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbgJIKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:34:12 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EBDC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 03:34:12 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7F749300002D8;
        Fri,  9 Oct 2020 12:34:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6926081F81; Fri,  9 Oct 2020 12:34:07 +0200 (CEST)
Date:   Fri, 9 Oct 2020 12:34:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Add check for DL_ACTIVE bit in
 pciehp_check_link_status()
Message-ID: <20201009103407.GA9629@wunner.de>
References: <1602008668-43646-1-git-send-email-Sanju.Mehta@amd.com>
 <20201006193830.GA32510@wunner.de>
 <7309c7f3-a895-e4aa-578e-444c5d5734d6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7309c7f3-a895-e4aa-578e-444c5d5734d6@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:43:17PM +0530, Sanjay R Mehta wrote:
> On 10/7/2020 1:08 AM, Lukas Wunner wrote:
> > On Tue, Oct 06, 2020 at 01:24:28PM -0500, Sanjay R Mehta wrote:
> I am supposed to use PCI_EXP_LNKSTA_DLLLA bit in my patch but have
> used PCI_EXP_DPC_CAP_DL_ACTIVE.
> 
> The correct code should be as below,
> 
> -     if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
> +     if (((lnk_status & PCI_EXP_LNKSTA_LT) &
> +          !(lnk_status & PCI_EXP_LNKSTA_DLLLA )) ||

So you want to ignore a set Link Training bit if the DLLLA bit is also
set (i.e. the link is up).  Why do you need this?  Is there broken AMD
hardware which fails to clear the Link Training bit when the LTSSM
exits the Configuration/Recovery state?

Again, please note that you need && instead of &.

Thanks,

Lukas

> >> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> >> ---
> >>  drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> >> index 53433b3..81d1348 100644
> >> --- a/drivers/pci/hotplug/pciehp_hpc.c
> >> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> >> @@ -309,7 +309,8 @@ int pciehp_check_link_status(struct controller *ctrl)
> >>
> >>       pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> >>       ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> >> -     if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
> >> +     if (((lnk_status & PCI_EXP_LNKSTA_LT) &
> >> +          !(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)) ||
> >>           !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
> >>               ctrl_err(ctrl, "link training error: status %#06x\n",
> >>                        lnk_status);
> >> --
> >> 2.7.4
