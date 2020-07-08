Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF746218F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGHSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 14:04:11 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:42952 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgGHSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:04:11 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4B26d3611Pz8v;
        Wed,  8 Jul 2020 20:04:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1594231449; bh=JDXQmGIW53NRlTH7B094Eeot8dV9wNZ5qBuxOCKPMUY=;
        h=Date:From:Subject:To:Cc:From;
        b=PWSI+uRcBncSl4v4Y0KIX6FfAslvyNgdf1s13olgeunJEUOKFpG9A8GYv+00Kjky7
         PqI7rKY+OJdFEq+bWOKX+OA3vLQmnjCmISkNask9a0pUYZtDO4ey1OeCAbgfwqJ+La
         LJmUctLEdKZLtYmgTCshYGGdmZzwoXtt7wdvNTc3nc0LWYS4u0NOhAyxHIITtm7z7S
         E1zn2am9t9aFHLFllBuEsOfYpZgECNQNZekhBYa1ibm3catVaZ1lGxAOlExcX8aeVP
         SBJrQBHxHu6eDzcZfzeUTCjkee8CCbxRs6iv5lH1EAQ8J72wtJxH9XK4vyq9Asy/hQ
         rHN6FsGnM5FnA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Wed, 08 Jul 2020 20:04:06 +0200
Message-Id: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH RESEND 0/3] usb: gadget: udc: atmel: assorted fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Songjun Wu <songjun.wu@atmel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two trivial fixes and .pullup implementation for Atmel UDC driver to
make composite gadget happy when handling reconfiguration.

Michał Mirosław (3):
  usb: gadget: udc: atmel: remove outdated comment in usba_ep_disable()
  usb: gadget: udc: atmel: fix uninitialized read in debug printk
  usb: gadget: udc: atmel: implement .pullup callback

 drivers/usb/gadget/udc/atmel_usba_udc.c | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.20.1

