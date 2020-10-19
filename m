Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BFB2928AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgJSN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:58:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:24248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgJSN6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:58:54 -0400
IronPort-SDR: AUvylMeurAW/WQoFIm6v2Zv98wHTWHR88qgDkqmdscWpVOMMn6HYo5m5fGtdLCSOzZYUsy5YkJ
 OKqDkt8CrZmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167144768"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="167144768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:58:53 -0700
IronPort-SDR: FKZix4vtRyAEvoZVpVTSNpQJwX4eosj9NAfk0T9u6GaoJEvxSLHgqFNXzo98V32bTsqXg1GwDL
 Wzdz0wSbqtSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422188671"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:58:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:58:48 +0300
Date:   Mon, 19 Oct 2020 16:58:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        David Cohen <david.a.cohen@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: dwc3: ulpi: Fix UPLI registers read/write ops
Message-ID: <20201019135848.GL1667571@kuha.fi.intel.com>
References: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:23:48AM +0300, Serge Semin wrote:
> Our Baikal-T1 SoC is equipped with DWC USB3 IP core as a USB2.0 bus
> controller. In general the DWC USB3 driver is working well for it except
> the ULPI-bus part. We've found out that the DWC USB3 ULPI-bus driver detected
> PHY with VID:PID tuple as 0x0000:0x0000, which of course wasn't true since
> it was supposed to be 0x0424:0x0006. After a short digging inside the
> ulpi.c code and studying the DWC USB3 documentation, it has been
> discovered that the ULPI bus IO ops didn't work quite correct. The
> busy-loop had stopped waiting before the actual operation was finished. We
> found out that the problem was caused by several bugs hidden in the DWC
> USB3 ULPI-bus IO implementation.
> 
> First of all in accordance with the DWC USB3 databook [1] the ULPI IO
> busy-loop is supposed to use the GUSB2PHYACCn.VStsDone flag as an
> indication of the PHY vendor control access completion. Instead it polled
> the GUSB2PHYACCn.VStsBsy flag, which as we discovered can be cleared a
> bit before the VStsDone flag.
> 
> Secondly having the simple counter-based loop in the modern kernel is
> really a weak design of the busy-looping pattern especially seeing the
> ULPI operations delay can be easily estimated [2], since the bus clock is
> fixed to 60MHz.
> 
> Finally the root cause of the denoted in the prologue problem was due to
> the Suspend PHY DWC USB3 feature perception. The commit e0082698b689
> ("usb: dwc3: ulpi: conditionally resume ULPI PHY") introduced the Suspend
> USB2.0 HS/FS/LS PHY regression as the Low-power consumption mode would be
> disable after a first attempt to read/write from the ULPI PHY control
> registers, and still didn't fix the problem it was originally intended for
> since the very first attempt of the ULPI PHY control registers IO would
> need much more time than the busy-loop provided. So instead of disabling
> the Suspend USB2.0 HS/FS/LS PHY feature we suggest to just extend the
> busy-loop delay in case if the GUSB2PHYCFGn.SusPHY flag set to 1. By doing
> so we'll eliminate the regression and the fix the false busy-loop timeout
> problem.
> 
> [1] Synopsys DesignWare Cores SuperSpeed USB 3.0 xHCI Host Controller
>     Databook, 2.70a, December 2013, p.388
> 
> [1] UTMI+ Low Pin Interface (ULPI) Specification, Revision 1.1,
>     October 20, 2004, pp. 30 - 36.
> 
> Fixes: e0082698b689 ("usb: dwc3: ulpi: conditionally resume ULPI PHY")
> Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (3):
>   usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
>   usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
>   usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression
> 
>  drivers/usb/dwc3/core.h |  1 +
>  drivers/usb/dwc3/ulpi.c | 38 +++++++++++++++++++++-----------------
>  2 files changed, 22 insertions(+), 17 deletions(-)

FWIW, for the whole series:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
