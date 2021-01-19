Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F172FBDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbhASRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391397AbhASQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:12:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 675122313A;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=hnqLjlmHjAxUUcednMhZwa9NC57nL6CEIvOqH+CzQA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFmTTUjT2Ujn8kwxYYsrcVc3V+5Fuz/t91NtJ5dc38LxZlAB1/nOPHlY0cCWnumkd
         Fgqwhak90YPxtj8qHlCfZAs3VEXybk56L7SepHQPo30x6uFmalKPcVhs8Evi3SdrJq
         XmqyPXYjfaKU226L7N8BYmEjyT7CNCn4D7tSdPxbfcNWgIn28aT4cJjCu/6MEVp7DZ
         tDeAjNoOeAw2gtdrHHwNzvdeUfR+bnikJjdR9qSybXwo3aFc7HYY04/lbLp9RuMilA
         FOqOrj3Xud3q816nKUXXg2vd3JGRXy5KzriOMZFndn8c4ucD1u+7mXB1xyNtKdCqsg
         ephiHhOa7Jw6g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012c6-8v; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/21] staging: hikey9xx: hi6421-spmi-pmic: update copyright
Date:   Tue, 19 Jan 2021 17:10:41 +0100
Message-Id: <33dd9012a0ce07d8adbf6b455ba6e0657bcfe2b3.1611072387.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611072387.git.mchehab+huawei@kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the GPL boilerplate, as SPDX tag already points to the
license terms and add a new copyright for Huawei.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 24 ++++++---------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index de6da2779084..9310a9d699bc 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -1,21 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Device driver for regulators in HISI PMIC IC
- *
- * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2011 Hisilicon.
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
+//
+// Device driver for regulators in HISI PMIC IC
+//
+// Copyright (c) 2013 Linaro Ltd.
+// Copyright (c) 2011 Hisilicon.
+//
+// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
 
 #include <linux/delay.h>
 #include <linux/device.h>
-- 
2.29.2

