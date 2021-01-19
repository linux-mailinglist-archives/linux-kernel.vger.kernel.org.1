Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C932FBC41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbhASQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391813AbhASQNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:13:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C3042313F;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=ocmCpgwDao2iTuPR1N+l2pLHx6KXPjh5Kl2bcWLyNNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWfHdMKxN7Wrhxsd1SvImW01qbT5pAHf6k63CMkv38z5SWPqGxX/hyNx7YBW0DkdB
         jdvlEeTDqQsIFnfQuQqETpAvyAOOVzpTc0bgfXFVhBTKjcUITvIOuMCekU+cueKXWK
         AQUDsllHRJ6/9AfhSqSHa4JT1k33L1KMyQELlaH/kT9o9r16jWVJJjB7KMO69cPYFh
         zdcAWXtYHZmwEzKqkaLk8ESSLAhBcNqsRbTK3yIGfi++oa5uJVLAy4ajYeXU8SBlXO
         FyDtWnwCMaKgz4vO0OKbA2o4gQRXbwfNVARi985S5xBNq/CNLRxKRdeT2iIi/w1Xwn
         +hH+1RhgYD1RQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012c8-Al; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/21] staging: hikey9xx: simplify includes
Date:   Tue, 19 Jan 2021 17:10:42 +0100
Message-Id: <069d2e3eaf8c2cb7a37e773278f7bc489f2f3cc5.1611072387.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611072387.git.mchehab+huawei@kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
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

