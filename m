Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E667F2F8B02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbhAPDdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPDdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:33:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E5CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 19:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eZT6tHWRhXXRhQv4aQp2/PCdg2nPnQ4d2Dc2ZbwaK5o=; b=Dxy0y9YO61K0FCOl3ZJZhBIp1i
        mPlN+EsRB4OSa9b9mkKNiHF0CVtPLIzX9mg69crjsFDkMhDG8XT63lRxA2HING0IfOD1rnIUCK3zY
        p/GR8QsnhiyxBq0xfjDYYC4uabwIJoJqVVAIIqImPl9HD/ivWSSALEVRPBKvdKx6HqL7eb9bBtqlJ
        7ORDYeMVdWXyRPeSdyY+/YGah1lNfLagta1yqA1ql7JAi9HHLa883M58iY8LW6sFzaHT8pmZHK6y2
        OuowKpMPRA3+pgAFTDN1HcDHpfDgxzB7dnrRDopwjV0lrfTLLN0QAaZ85zKWU/LGGVwJYFj/m4uyB
        TKagu9iQ==;
Received: from [2601:1c0:6280:3f0::9abc] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0cKo-0008FZ-1I; Sat, 16 Jan 2021 03:33:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH] imx: select SOC_BUS to fix firmware build
Date:   Fri, 15 Jan 2021 19:32:59 -0800
Message-Id: <20210116033259.31941-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error in firmware/imx/ selecting SOC_BUS.

riscv32-linux-ld: drivers/firmware/imx/imx-scu-soc.o: in function `.L9':
imx-scu-soc.c:(.text+0x1b0): undefined reference to `soc_device_register'

Fixes: edbee095fafb ("firmware: imx: add SCU firmware driver support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210115.orig/drivers/firmware/imx/Kconfig
+++ linux-next-20210115/drivers/firmware/imx/Kconfig
@@ -13,6 +13,7 @@ config IMX_DSP
 config IMX_SCU
 	bool "IMX SCU Protocol driver"
 	depends on IMX_MBOX
+	select SOC_BUS
 	help
 	  The System Controller Firmware (SCFW) is a low-level system function
 	  which runs on a dedicated Cortex-M core to provide power, clock, and
