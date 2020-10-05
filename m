Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58142835ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJEMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEMss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:48:48 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9DBC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:48:47 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id cCok2300t4C55Sk01Cok9c; Mon, 05 Oct 2020 14:48:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPPv2-0006Yz-OV; Mon, 05 Oct 2020 14:48:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPPv2-0006xB-Lf; Mon, 05 Oct 2020 14:48:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vadim Pasternak <vadimp@mellanox.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] hwmon: (mlxreg-fan) Fix double "Mellanox"
Date:   Mon,  5 Oct 2020 14:48:43 +0200
Message-Id: <20201005124843.26688-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplicate "Mellanox" in the help text for the Mellanox FAN
driver configuration option.

Fixes: 65afb4c8e7e4e7e7 ("hwmon: (mlxreg-fan) Add support for Mellanox FAN driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8dc28b26916ec4c8..64abec37ca9d5d0d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1080,7 +1080,7 @@ config SENSORS_MCP3021
 	  will be called mcp3021.
 
 config SENSORS_MLXREG_FAN
-	tristate "Mellanox Mellanox FAN driver"
+	tristate "Mellanox FAN driver"
 	depends on MELLANOX_PLATFORM
 	imply THERMAL
 	select REGMAP
-- 
2.17.1

