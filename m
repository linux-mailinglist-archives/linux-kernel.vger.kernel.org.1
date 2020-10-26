Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87282992A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786288AbgJZQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:41:17 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:55834 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786238AbgJZQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:41:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 488068030867;
        Mon, 26 Oct 2020 16:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AxqfK58WGdc8; Mon, 26 Oct 2020 19:40:52 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Cohen <david.a.cohen@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 0/3] usb: dwc3: ulpi: Fix UPLI registers read/write ops
Date:   Mon, 26 Oct 2020 19:40:47 +0300
Message-ID: <20201026164050.30380-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our Baikal-T1 SoC is equipped with DWC USB3 IP core as a USB2.0 bus
controller. In general the DWC USB3 driver is working well for it except
the ULPI-bus part. We've found out that the DWC USB3 ULPI-bus driver detected
PHY with VID:PID tuple as 0x0000:0x0000, which of course wasn't true since
it was supposed to be 0x0424:0x0006. After a short digging inside the
ulpi.c code and studying the DWC USB3 documentation, it has been
discovered that the ULPI bus IO ops didn't work quite correct. The
busy-loop had stopped waiting before the actual operation was finished. We
found out that the problem was caused by several bugs hidden in the DWC
USB3 ULPI-bus IO implementation.

First of all in accordance with the DWC USB3 databook [1] the ULPI IO
busy-loop is supposed to use the GUSB2PHYACCn.VStsDone flag as an
indication of the PHY vendor control access completion. Instead it polled
the GUSB2PHYACCn.VStsBsy flag, which as we discovered can be cleared a
bit before the VStsDone flag.

Secondly having the simple counter-based loop in the modern kernel is
really a weak design of the busy-looping pattern especially seeing the
ULPI operations delay can be easily estimated [2], since the bus clock is
fixed to 60MHz.

Finally the root cause of the denoted in the prologue problem was due to
the Suspend PHY DWC USB3 feature perception. The commit e0082698b689
("usb: dwc3: ulpi: conditionally resume ULPI PHY") introduced the Suspend
USB2.0 HS/FS/LS PHY regression as the Low-power consumption mode would be
disable after a first attempt to read/write from the ULPI PHY control
registers, and still didn't fix the problem it was originally intended for
since the very first attempt of the ULPI PHY control registers IO would
need much more time than the busy-loop provided. So instead of disabling
the Suspend USB2.0 HS/FS/LS PHY feature we suggest to just extend the
busy-loop delay in case if the GUSB2PHYCFGn.SusPHY flag set to 1. By doing
so we'll eliminate the regression and fix the false busy-loop timeout
problem.

[1] Synopsys DesignWare Cores SuperSpeed USB 3.0 xHCI Host Controller
    Databook, 2.70a, December 2013, p.388

[2] UTMI+ Low Pin Interface (ULPI) Specification, Revision 1.1,
    October 20, 2004, pp. 30 - 36.

Link: https://lore.kernel.org/linux-usb/20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru
Changelog v2:
- Add Heikki'es acked-byt tag.
- Resend the series so it wouldn't be lost but merged in the kernel 5.10.

Fixes: e0082698b689 ("usb: dwc3: ulpi: conditionally resume ULPI PHY")
Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
  usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
  usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression

 drivers/usb/dwc3/core.h |  1 +
 drivers/usb/dwc3/ulpi.c | 38 +++++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.28.0

