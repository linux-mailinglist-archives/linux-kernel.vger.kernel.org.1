Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6CF1A290A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgDHTDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:03:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHTDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:03:25 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mg6i8-1iniJB1vaA-00haOp; Wed, 08 Apr 2020 21:03:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Anson Huang <Anson.Huang@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: imx: fix compile-testing
Date:   Wed,  8 Apr 2020 21:02:57 +0200
Message-Id: <20200408190314.695067-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MHUnGS4mhb9c0Ayqn3vJzYSSZquf3HBpsl6Pj4L+hYt5iYBAWOf
 NQh3uzTRWIYhEs8jW8faJAnTJk1sI/KDx23ioLQUPjJX2ymq+WT9C90sPnhQEtj/KGaD/AM
 +WZqaXe0OeUIhN0W4OmyYU+szIvUsR2+EMH3qSgWOJuOmUACA36zNk+drKkP3RoK5/RbYeS
 goXPkv3p116iHhkEYCCqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7T+8WLgcDJs=:xUMyHkZ75drqypZQFuX28i
 BNKdAuhp5qRrP6PXAgJTf8JefObWnjvuFtnXdT2Y0qcGAOxXbIcgqRP3r4qUj86c1Cfo6Q9kr
 0WjSZ72l77/wNd8Ne9gV+YqS00a2Vd4opY4wjgbGG+pqvi5/kHvDXKAwQEqFgTP3gqIITeIp8
 UkGv08cjyAc5ZEWmt6sQd0ltYZP7fRtxAmLrl+ttXHcXOA8yyiNowvobBvSLJZBS961VO1Na1
 OtM+0yj8mhcYlrz3le4bPleUOuZ4C/T6psozIDGl1MEXreFuaBuVB6SbaztpiIDB4P0nNuUOZ
 YM/LA/hRIUkRp0Lb9GpbWBsNGpqD7dEB5EwbQrT8SZQjhdZ6v6WPBW+e0rtK0EMjvKuggSoEZ
 1sLaBnc/W1x5te3q+ynOTeokQxybC+nHK666kYUD6ABlp1+I0tqfzx31UNSj3sg1hD6LWgGFv
 s4xN9PcQ58f1zJjiRMwRX8wc81QMSzDWNcIS4E5tFUwaX2jfH9mNQui2pCPrigi+h92hQYeUC
 VG+0sXC+wCPNm8D6VS5eeT2YxR9xNqyqX2OgCPDIZUgmvyswHuFqPRNvAM3AAwaIMe6yRkmoJ
 S4SSAMBYz+67IgDq4YvvpuJXcKaeG/4PDTFIiGLtcPKrXf2VXU/Ab8uRYF2Lt6gshd3m0wLKN
 hvlkSfpdxj0bUuPfgXbi1JYtVEHEsCQbxS+B9XyQxaTq1xB5sKieNsuFkl3cVUHLXJuKzSN1E
 1fGWREn0Tf7JwuFBz2yQlGZ3RDYUmK10aAuq7YUdgqOFMWSCP2U/ZNC6UFr7niV/DTT2cnniZ
 DmisMpT2nbeXHz3zznECz2ugrkbgRNwXWTdMIYvi4g2iGaB27o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is nice to allow compile-testing the firmware drivers, but this
fails when the dependency is a loadable module:

aarch64-linux-ld: drivers/firmware/imx/scu-pd.o: in function `imx_sc_pd_power':
scu-pd.c:(.text+0xd8): undefined reference to `imx_scu_call_rpc'
aarch64-linux-ld: scu-pd.c:(.text+0x108): undefined reference to `imx_scu_call_rpc'
aarch64-linux-ld: drivers/firmware/imx/scu-pd.o: in function `imx_sc_pd_probe':

Change the dependencies to ensure that any driver we depend on is
either reachable or we are compile-testing and it is disabled,
effectively reverting most of the previous changes that turned
out to be incorrect.

Fixes: a9f85f93ed73 ("firmware: imx: add COMPILE_TEST support")
Fixes: 5b00b8375416 ("firmware: imx: add COMPILE_TEST for IMX_SCU driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/imx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 116707a075f3..1d2e5b85d7ca 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -12,7 +12,7 @@ config IMX_DSP
 
 config IMX_SCU
 	bool "IMX SCU Protocol driver"
-	depends on IMX_MBOX || COMPILE_TEST
+	depends on IMX_MBOX
 	help
 	  The System Controller Firmware (SCFW) is a low-level system function
 	  which runs on a dedicated Cortex-M core to provide power, clock, and
@@ -24,6 +24,6 @@ config IMX_SCU
 
 config IMX_SCU_PD
 	bool "IMX SCU Power Domain driver"
-	depends on IMX_SCU || COMPILE_TEST
+	depends on IMX_SCU
 	help
 	  The System Controller Firmware (SCFW) based power domain driver.
-- 
2.26.0

