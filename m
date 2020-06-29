Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9120E0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbgF2UvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgF2TNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE8C00861C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:32:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3B26E2A0EAA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org, kernel test robot <lkp@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: Add a dependency on USB_ROLE_SWITCH
Date:   Mon, 29 Jun 2020 12:32:23 +0200
Message-Id: <20200629103223.1284442-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by the kernel test robot the cros_ec_typec driver fails to
build if the USB_ROLE_SWITCH is not selected, to fix that, add a
dependency on that symbol. This fixes the following build error:

   drivers/platform/chrome/cros_ec_typec.c:133: undefined reference to `usb_role_switch_put'
   ld: drivers/platform/chrome/cros_ec_typec.o: in function `cros_typec_get_switch_handles':
   drivers/platform/chrome/cros_ec_typec.c:108: undefined reference to `fwnode_usb_role_switch_get'
   ld: drivers/platform/chrome/cros_ec_typec.c:117: undefined reference to `usb_role_switch_put'

Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index cf072153bdc5..a056031dee81 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -218,6 +218,7 @@ config CROS_EC_TYPEC
 	tristate "ChromeOS EC Type-C Connector Control"
 	depends on MFD_CROS_EC_DEV && TYPEC
 	depends on CROS_USBPD_NOTIFY
+	depends on USB_ROLE_SWITCH
 	default MFD_CROS_EC_DEV
 	help
 	  If you say Y here, you get support for accessing Type C connector
-- 
2.27.0

