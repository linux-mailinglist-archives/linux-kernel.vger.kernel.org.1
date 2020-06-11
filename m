Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C582B1F6DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFKTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:17:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A210C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:17:55 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jjSi1-0002Iw-3x; Thu, 11 Jun 2020 21:17:53 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jjSi0-0000xr-87; Thu, 11 Jun 2020 21:17:52 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v1 0/8] watchdog: f71808e_wdt: migrate to kernel
Date:   Thu, 11 Jun 2020 21:17:41 +0200
Message-Id: <20200611191750.28096-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series fixes some issues I ran into with the status UAPI of the driver and
then migrates it over to the kernel watchdog API.

I tested it on a f81866.

Cheers,
Ahmad Fatoum (8):
  docs: watchdog: codify ident.options as superset of possible status
    flags
  watchdog: f71808e_wdt: indicate WDIOF_CARDRESET support in
    watchdog_info.options
  watchdog: f71808e_wdt: remove use of wrong watchdog_info option
  watchdog: f71808e_wdt: clear watchdog timeout occurred flag
  watchdog: f71808e_wdt: do stricter parameter validation
  watchdog: f71808e_wdt: consolidate variant handling into single array
  watchdog: f71808e_wdt: migrate to new kernel watchdog API
  watchdog: f71808e_wdt: rename variant-independent identifiers
    appropriately

 Documentation/watchdog/watchdog-api.rst |   2 +-
 drivers/watchdog/Kconfig                |   1 +
 drivers/watchdog/f71808e_wdt.c          | 784 ++++++++----------------
 3 files changed, 242 insertions(+), 545 deletions(-)

-- 
2.27.0

