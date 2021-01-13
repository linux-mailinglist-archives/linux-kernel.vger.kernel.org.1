Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5702F49FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbhAMLWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:22:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:40966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbhAMLVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:21:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 408ADAEE0;
        Wed, 13 Jan 2021 11:21:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>, linux-usb@vger.kernel.org
Cc:     linux@roeck-us.net, dianders@chromium.org, hminas@synopsys.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] usb: dwc2: Fixes and improvements
Date:   Wed, 13 Jan 2021 12:20:48 +0100
Message-Id: <20210113112052.17063-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm picking up this series by Guenter Roeck as he stated he has no time
for it ATM. It was found to solve some unaligned DMA access issues on
Raspberry Pi 3. You can find the original discussion here:
https://lore.kernel.org/linux-usb/20200226210414.28133-1-linux@roeck-us.net/

I removed the fist patch from the original series as it turned out to be
contententious and needs more in-depth testing. Following is the edited
origin series description. Note that extra testing was performed on
RPi3:

"This series addresses the following problems:

- Fix receive transfers with 0 byte transfer length
- Abort transactions after unknown receive errors
  if the receive buffer is full
- Reduce "trimming xfer length" logging noise

The problems fixed with this series were observed when connecting
a DM9600 Ethernet adapter to Veyron Chromebooks such as the ASUS
Chromebook C201PA. The series was tested extensively with this and
other adapters.

The observed problems are also reported when tethering various
phones, so test coverage with such phones would be very appreciated."

---

Guenter Roeck (3):
  usb: dwc2: Do not update data length if it is 0 on inbound transfers
  usb: dwc2: Abort transaction after errors with unknown reason
  usb: dwc2: Make "trimming xfer length" a debug message

 drivers/usb/dwc2/hcd.c      | 15 ++++++++-------
 drivers/usb/dwc2/hcd_intr.c | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.29.2

