Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70848224B34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGRMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 08:38:52 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:36322 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgGRMiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 08:38:51 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id A58C4BC064;
        Sat, 18 Jul 2020 12:38:46 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        josh@joshtriplett.org, jbrasen@nvidia.com, krzk@kernel.org,
        kai.heng.feng@canonical.com, tbogendoerfer@suse.de,
        masahiroy@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] tty: serial: Replace HTTP links with HTTPS ones
Date:   Sat, 18 Jul 2020 14:38:40 +0200
Message-Id: <20200718123840.19957-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/tty/serial/8250/Kconfig     | 4 ++--
 drivers/tty/serial/jsm/jsm_driver.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d2ae033aea40..603137da4736 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -222,7 +222,7 @@ config SERIAL_8250_MANY_PORTS
 	  Say Y here if you have dumb serial boards other than the four
 	  standard COM 1/2/3/4 ports. This may happen if you have an AST
 	  FourPort, Accent Async, Boca (read the Boca mini-HOWTO, available
-	  from <http://www.tldp.org/docs.html#howto>), or other custom
+	  from <https://www.tldp.org/docs.html#howto>), or other custom
 	  serial port hardware which acts similar to standard serial port
 	  hardware. If you only use the standard COM 1/2/3/4 ports, you can
 	  say N here to save some memory. You can also say Y if you have an
@@ -266,7 +266,7 @@ config SERIAL_8250_BOCA
 	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
 	help
 	  Say Y here if you have a Boca serial board.  Please read the Boca
-	  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>
+	  mini-HOWTO, available from <https://www.tldp.org/docs.html#howto>
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_boca.
diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 592e51d8944e..cd30da0ef083 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -16,7 +16,7 @@
 
 #include "jsm.h"
 
-MODULE_AUTHOR("Digi International, http://www.digi.com");
+MODULE_AUTHOR("Digi International, https://www.digi.com");
 MODULE_DESCRIPTION("Driver for the Digi International Neo and Classic PCI based product line");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("jsm");
-- 
2.27.0

