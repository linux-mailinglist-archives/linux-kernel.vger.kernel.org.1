Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0E2F03CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhAIV0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:26:50 -0500
Received: from netrider.rowland.org ([192.131.102.5]:34189 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726068AbhAIV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:26:49 -0500
Received: (qmail 1137346 invoked by uid 1000); 9 Jan 2021 16:26:08 -0500
Date:   Sat, 9 Jan 2021 16:26:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: ohci: Default to per-port over-current
 protection
Message-ID: <20210109212608.GB1136657@rowland.harvard.edu>
References: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
 <X+huemxT9XOeDi5E@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X+huemxT9XOeDi5E@aptenodytes>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 12:22:34PM +0100, Paul Kocialkowski wrote:
> Hi,

Sorry it has taken so long to respond to this.  The holidays intervened, 
but that's no excuse.

> On Fri 11 Sep 20, 09:25, Hamish Martin wrote:
> > Some integrated OHCI controller hubs do not expose all ports of the hub
> > to pins on the SoC. In some cases the unconnected ports generate
> > spurious over-current events. For example the Broadcom 56060/Ranger 2 SoC
> > contains a nominally 3 port hub but only the first port is wired.
> > 
> > Default behaviour for ohci-platform driver is to use global over-current
> > protection mode (AKA "ganged"). This leads to the spurious over-current
> > events affecting all ports in the hub.
> > 
> > We now alter the default to use per-port over-current protection.
> 
> This specific patch lead to breaking OHCI on my mom's laptop (whom was about
> to buy a new one thinking the hardware had failed). I get no OHCI interrupt at
> all and no USB 1 device is ever detected.
> 
> I haven't really found a reasonable explanation about why that is, but here
> are some notes I was able to collect:
> - The issue showed up on 5.8,18 and 5.9.15, which don't include the patch
>   from this series that sets distrust_firmware = false; This results in the NPS
>   bit being set via OHCI_QUIRK_HUB_POWER.
> - Adding val &= ~RH_A_PSM; (as was done before this change) solves the issue
>   which is weird because the bit is supposed to be inactive when NPS is set;
> - Setting ohci_hcd.distrust_firmware=0 in the cmdline results in not setting
>   the NPS bit and also solves the issue;
> - The initial value of the register at function entry is 0x1001104 (PSM bit
>   is set, NPS is unset);
> - The OHCI controller is the following:
> 00:03.0 USB controller: Silicon Integrated Systems [SiS] USB 1.1 Controller (rev 0f) (prog-if 10 [OHCI])
> 	Subsystem: ASUSTeK Computer Inc. Device 1aa7

Great reporting -- thanks.

> Does that make any sense to you?
> 
> I really wonder what a proper fix could be and here are some suggestions:
> - Adding a specific quirk to clear the PSM bit for this hardware which seems to
>   consider the bit regardless of NPS;

We don't need a quirk for this.  There shouldn't be anything wrong with 
_always_ clearing PSM whenever NPS is set, since the controller is 
supposed to ignore PSM under that condition.

Would you like to submit a patch for this?

> - Adding the patch that sets distrust_firmware = false to stable branches;

That's certainly reasonable.  Nobody has reported any problems caused by 
that patch, so adding it to the stable branches should be safe enough.

> What do you think?

We could even do both.  That would help if, for example, somebody 
decided to set ohci_hcd.distrust_firmware=true explicitly.

Greg, in the meantime can we have commit c4005a8f65ed ("usb: ohci: Make 
distrust_firmware param default to false") added to all the stable 
kernels which have back-ported versions of commit b77d2a0a223b?

Alan Stern
