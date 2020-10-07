Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0F285807
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgJGFKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 01:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJGFKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:10:03 -0400
Received: from mail.kernel.org (ip5f5ad5a2.dynamic.kabel-deutschland.de [95.90.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F38208C7;
        Wed,  7 Oct 2020 05:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602047403;
        bh=Qcs5wI40IaT7X+ONV6r+agRPh9SxEGQo1TVtBJRGz9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDZPzdRPkYOyNfj+VKMtvmylyHUuovufrWYCjzWEJxhyHP0RCenKtUjg9TFDQZjyB
         urCntIc/vVdUCedhDQ+kq+PZ+qyIJzsoZtdFT89FaqGQPUslUgBw0ZyPzoavYtF1Oa
         /5rK2dWA87mhVAXo0ZmqsUrNoVoe+2Rs19rVMkaU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kQ1iC-001SVv-A3; Wed, 07 Oct 2020 07:10:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] misc: Kconfig: add a new dependency for HISI_HIKEY_USB
Date:   Wed,  7 Oct 2020 07:09:54 +0200
Message-Id: <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CALAqxLU672fOHudfvZWDEoO=fHYt79isz35e9EaJAsvTCg5How@mail.gmail.com>
References: <CALAqxLU672fOHudfvZWDEoO=fHYt79isz35e9EaJAsvTCg5How@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by Randy:

	on x86_64:
	CONFIG_USB_ROLE_SWITCH=m
	and HISI_HIKEY_USB=y.

	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_remove':
	hisi_hikey_usb.c:(.text+0x61): undefined reference to `usb_role_switch_unregister'
	ld: hisi_hikey_usb.c:(.text+0xa4): undefined reference to `usb_role_switch_put'
	ld: drivers/misc/hisi_hikey_usb.o: in function `hub_usb_role_switch_set':
	hisi_hikey_usb.c:(.text+0xd3): undefined reference to `usb_role_switch_get_drvdata'
	ld: drivers/misc/hisi_hikey_usb.o: in function `relay_set_role_switch':
	hisi_hikey_usb.c:(.text+0x54d): undefined reference to `usb_role_switch_set_role'
	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_probe':
	hisi_hikey_usb.c:(.text+0x8a5): undefined reference to `usb_role_switch_get'
	ld: hisi_hikey_usb.c:(.text+0xa08): undefined reference to `usb_role_switch_register'
	ld: hisi_hikey_usb.c:(.text+0xa6e): undefined reference to `usb_role_switch_put'

Make it dependent on CONFIG_USB_ROLE_SWITCH.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e19e1dcceb41..7cee2b72c09e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -459,6 +459,7 @@ config PVPANIC
 config HISI_HIKEY_USB
 	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
 	depends on (OF && GPIOLIB) || COMPILE_TEST
+	depends on CONFIG_USB_ROLE_SWITCH
 	help
 	  If you say yes here this adds support for the on-board USB GPIO hub
 	  found on HiKey 960/970 boards, which is necessary to support
-- 
2.26.2

