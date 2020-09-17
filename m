Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACC26E2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIQRxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgIQRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3DDC061756;
        Thu, 17 Sep 2020 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pGkfsVyYFjM6wbe1xMrt8vihG2zoZEqiWnoR3qBkdNg=; b=r1gCnVlt4vYnAWkwa/wKKHMJuk
        M/9XNRpTvcWG3orOH+ly4yA0waoICNPUIB8xPwcWuzjCwOcnuaQflyDAv3bWha/HZIlu2hJ9rYp7/
        vBwOUbsqVgH25sQUBzoq8h4dtoOuJuBOaZOYfKeM+H4Zcz9TdsFrUCZD92r/vQB4a3GU0RqTtrKT/
        5ZIPRaea0rJX2hDHoMgvV05m9G9kP6074oWk69zq50N0nEy3pyREIw0IDGlHCwFjr/lYYiTMFFQP8
        iqeZDh8hjsXnyLnyu+08E82E/UHusDjQvRWfv2358r1N7bk9j/zBG2llkrdY+Sjx3u3lv20rkxE2a
        fcG506Vg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIy4U-00046d-Gx; Thu, 17 Sep 2020 17:51:51 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Cc:     Li Yin <yin1.li@intel.com>,
        Vadivel Murugan R <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] phy: fix USB_LGM_PHY warning & build errors
Message-ID: <d1dd0ddd-3143-5777-1c63-195e1a32f237@infradead.org>
Date:   Thu, 17 Sep 2020 10:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a Kconfig warning that is causing lots of build errors
when USB_SUPPORT is not set.

USB_PHY depends on USB_SUPPORT but "select" doesn't care about
dependencies, so this driver should also depend on USB_SUPPORT.
It should not select USB_SUPPORT.

WARNING: unmet direct dependencies detected for USB_PHY
  Depends on [n]: USB_SUPPORT [=n]
  Selected by [m]:
  - USB_LGM_PHY [=m]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yin <yin1.li@intel.com>
Cc: Vadivel Murugan R <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200917.orig/drivers/phy/Kconfig
+++ linux-next-20200917/drivers/phy/Kconfig
@@ -51,6 +51,7 @@ config PHY_XGENE
 
 config USB_LGM_PHY
 	tristate "INTEL Lightning Mountain USB PHY Driver"
+	depends on USB_SUPPORT
 	select USB_PHY
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE

