Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C762FE3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbhAUHWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbhAUHT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:19:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A05C239E4;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=ocmCpgwDao2iTuPR1N+l2pLHx6KXPjh5Kl2bcWLyNNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcw+5DyoQZMrS0umyKse1494ffXucPLf0BqoBwVFcWL0P6h5UhYHAOZft0akGmuxP
         eWLyjpop3oKyf2b9dGTvsuSi7eAGn2B0xoEO5bRWYZhtWS8qHrDP/2AJ9XZE2mcxGE
         px04VvBaaLlnxao8Dbe6LwsEA/P42+blbirWIiXEQBwCV3qni9vFxf9+/w/pU2nzJx
         5vZYIDvw2AzZVLRBbPSLj66s9FwPV2iCiUk5C/mZTn3UKebrpH9DBR/OYwo8ggmxWY
         7d8GU4yjaIOy37emsUrIDD2dTaRgeuE2xaV7zrKrxQRZ6QGlAutSs5LeC4J2g11aer
         11L3QpeJnLpiQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsS-No; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/21] staging: hikey9xx: hi6421-spmi-pmic: simplify includes
Date:   Thu, 21 Jan 2021 08:18:18 +0100
Message-Id: <50087bb41fc262d6930aeda0583546cf9d597b87.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several uneeded includes. Remove them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 9310a9d699bc..99c4f3359f71 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -7,20 +7,12 @@
 //
 // Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
 
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_gpio.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spmi.h>
-- 
2.29.2

