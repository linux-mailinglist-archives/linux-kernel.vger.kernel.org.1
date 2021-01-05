Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6FA2EADF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAEPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:11:10 -0500
Received: from tux.runtux.com ([176.9.82.136]:59742 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbhAEPLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:11:09 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 10:11:08 EST
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 864A26F08A;
        Tue,  5 Jan 2021 16:01:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IqvrxiLmhTSR; Tue,  5 Jan 2021 16:01:25 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 3D7C16EF52;
        Tue,  5 Jan 2021 16:01:25 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 62263473; Tue,  5 Jan 2021 16:01:24 +0100 (CET)
Date:   Tue, 5 Jan 2021 16:01:24 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] auxdisplay: HD44780 connected to I2C via PCF8574
Message-ID: <20210105150124.dvlochv3qrp4wpre@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Character LCD driver for the Hitachi HD44780 with I2C connection:
There already is a driver for displays with parallel gpio connections.
Re-uses the high-level API.

Concerning the compatible-string: I'm currently using

"hit,hd44780+nxp,pcf8575"

- "hit,hd44780" is used for the parallel-connected version of the display
- nxp,pcf8575 already exists in drivers/gpio/gpio-pcf857x.c which uses
  the same chip for gpio expansion.

Let me know if this choice of names is fine or should be changed.
For the other device-tree names I'm reusing (some of) the names from the
parallel connected display.

 .../auxdisplay/hit,hd44780+nxp,pcf8575.yaml (new)  |  65 +++++++
 drivers/auxdisplay/Kconfig                         |  14 +-
 drivers/auxdisplay/Makefile                        |   1 +
 drivers/auxdisplay/hd44780-pcf8574.c (new)         | 207 +++++++++++++++++++++
 4 files changed, 286 insertions(+), 1 deletion(-)

-- 
Ralf Schlatterbeck                      Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
