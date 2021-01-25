Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A713302515
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbhAYMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbhAYMoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:44:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFAD622A84;
        Mon, 25 Jan 2021 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611574372;
        bh=zvGcvAbZxeaS91GmqlrL8rhrbP5aTskoffAf2GJZ5Y0=;
        h=From:To:Cc:Subject:Date:From;
        b=kUTFpQYw5TdsBGw4F25VVK/zFKfvZetV3mcOIPt6QI1p+V7aEh/5b3ubkGvpGWZMy
         WFfX8JT+W7GsvCYdSEdBqvsXu6MZTD2xdSjm1WDsFsc+8dew+lnk6TwHFWNQq+K4qL
         9BlaR2i02SEHome13p5tbBuDMdqziFKigs15ugFtqTJBT1cMFlRO0S46rk4NZIHwP+
         066eHnXPJiDiCb/VUwL/QoxLZBZdWXzOmpKGx104PjAHMIytEOkjqFoyHJVnJwvBEz
         s+rDBzjUQsiGlj4n8ClJis+KbQnF3gaR9+RfYRLEAurKs4XEHauhSG+DOK5oZBM/+w
         Zjt3NnQJxSfBQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <peter.chen@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: ehci-tegra: fix Kconfig depencies
Date:   Mon, 25 Jan 2021 12:32:30 +0100
Message-Id: <20210125113248.2268952-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Selecting the chipidea driver from the old Kconfig symbol
can lead to a missing dependency:

WARNING: unmet direct dependencies detected for USB_CHIPIDEA
  Depends on [m]: USB_SUPPORT [=y] && (USB_EHCI_HCD [=y] && USB_GADGET [=m] || USB_EHCI_HCD [=y] && !USB_GADGET [=m] || !USB_EHCI_HCD [=y] && USB_GADGET [=m]) && HAS_DMA [=y]
  Selected by [y]:
  - USB_EHCI_TEGRA [=y] && USB_SUPPORT [=y] && USB [=y] && USB_EHCI_HCD [=y] && ARCH_TEGRA [=y]
aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_handle_vbus_change':
otg.c:(.text+0x3c8): undefined reference to `usb_gadget_vbus_connect'
aarch64-linux-ld: otg.c:(.text+0x42c): undefined reference to `usb_gadget_vbus_disconnect'
aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_otg_work':
otg.c:(.text+0x5d4): undefined reference to `usb_gadget_vbus_disconnect'
...

Duplicate the dependency to ensure that this driver can
only be a loadable module if one of its dependencies is.

Fixes: c3590c7656fb ("usb: host: ehci-tegra: Remove the driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 160e5d3927e2..66b01b619ecd 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -269,6 +269,7 @@ config USB_EHCI_HCD_AT91
 config USB_EHCI_TEGRA
 	tristate "NVIDIA Tegra HCD support"
 	depends on ARCH_TEGRA
+	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
 	select USB_CHIPIDEA
 	select USB_CHIPIDEA_HOST
 	select USB_CHIPIDEA_TEGRA
-- 
2.29.2

