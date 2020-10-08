Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34240286EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgJHGZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgJHGZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:25:04 -0400
Received: from mail.kernel.org (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B75F2076B;
        Thu,  8 Oct 2020 06:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602138303;
        bh=I/B0kp3ARjjOr2EdohWzw1fW9/WWzCKhi9MQ6lwtZzE=;
        h=From:To:Cc:Subject:Date:From;
        b=AFSNFovOamJgk13lvpBjVuVarJikdXc70TH6mJAXwWoIcQrwyePCvggNpMogrnyU0
         wP5oNTvA6GGJzCP8UofAVDIEBj3379YWcko4LjT92/dJCh70Fempwn+S1bpoh44OuQ
         piJcXPQRU1tPbmScBT+HnZjBhvf6ZhwHa47jyI/Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kQPMI-0025b5-55; Thu, 08 Oct 2020 08:24:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] misc: Kconfig: fix a HISI_HIKEY_USB dependency
Date:   Thu,  8 Oct 2020 08:24:53 +0200
Message-Id: <0b6dff854c4bb412c2c11f17803e84d61385415f.1602138248.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency should be just USB_ROLE_SWITCH, instead
of CONFIG_USB_ROLE_SWITCH.

Fixes: 2827d98bc5d6 ("misc: Kconfig: add a new dependency for HISI_HIKEY_USB")

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7cee2b72c09e..d5ce8082b0a0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -459,7 +459,7 @@ config PVPANIC
 config HISI_HIKEY_USB
 	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
 	depends on (OF && GPIOLIB) || COMPILE_TEST
-	depends on CONFIG_USB_ROLE_SWITCH
+	depends on USB_ROLE_SWITCH
 	help
 	  If you say yes here this adds support for the on-board USB GPIO hub
 	  found on HiKey 960/970 boards, which is necessary to support
-- 
2.26.2

