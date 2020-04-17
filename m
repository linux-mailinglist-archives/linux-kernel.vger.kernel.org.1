Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2161AE30C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgDQRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:01:19 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52874 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgDQRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587142848; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0ZuQmgIuvZfa1M7BhArB6Fye/2+ZxALtNBtmE1Q7Hs=;
        b=b5I/ZF8tPBEpwKFDT2WCYsNgC+wTsJKJkwRnsGVpKD6NQoio/nxoR0IjZOrDJOYHHI+7VA
        BPrJ9LhJknfBSlpJs8/yaO4AfiKqhE+JX1gmtTdZRdveWj/W9ZYxgw/i82pMwFD5PAb2uP
        RMSKWo5Cl+1RE9m60dYVZbNCxPAdQt8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 5/5] MAINTAINERS: Add myself as reviewer for Ingenic rproc driver
Date:   Fri, 17 Apr 2020 19:00:40 +0200
Message-Id: <20200417170040.174319-5-paul@crapouillou.net>
In-Reply-To: <20200417170040.174319-1-paul@crapouillou.net>
References: <20200417170040.174319-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the reviewer for the Ingenic VPU remoteproc driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v4: New patch
    v5-v6: No change

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..1677071197a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8418,6 +8418,7 @@ F:	drivers/mtd/nand/raw/ingenic/
 F:	drivers/pinctrl/pinctrl-ingenic.c
 F:	drivers/power/supply/ingenic-battery.c
 F:	drivers/pwm/pwm-jz4740.c
+F:	drivers/remoteproc/ingenic_rproc.c
 F:	drivers/rtc/rtc-jz4740.c
 F:	drivers/tty/serial/8250/8250_ingenic.c
 F:	drivers/usb/musb/jz4740.c
-- 
2.25.1

