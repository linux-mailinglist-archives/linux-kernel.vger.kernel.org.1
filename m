Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077E72FE3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbhAUHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbhAUHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:20:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 481E5239D3;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=hnqLjlmHjAxUUcednMhZwa9NC57nL6CEIvOqH+CzQA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIpyVk5TD+e2uhoPXxdOFTNTzYbPQkmidHteKhYHqZf1pud+vPVm5ztMYGhMYAx8H
         ey6t2rkVpJVV8UtG8hqovCew66335uceTM8Vfe/ixrovd8BQkLUS6621dDH+0Mw5jx
         UfcDXFrPlwF5OnUsjk09F4zGhtiJBUbURtWCk+OHNMM4psbh6MjgrAPabhokbLUDsi
         APa5EGgrj3ipndmaElwwVzp3AF5tWR+kjQe3xdbOJ90dP8Fv9gRTf7hAJSncvdmxUJ
         WqmjUtz4RmMnbY92+ieFMDfYmhlDYo5Oxf8pMZTowptpJNWH6UbEi5hInecsodZ/ty
         J3Q+okXWphjyQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsQ-N3; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/21] staging: hikey9xx: hi6421-spmi-pmic: update copyright
Date:   Thu, 21 Jan 2021 08:18:17 +0100
Message-Id: <18b36d01c04519d84912140b6c40c1bd1f75a3a8.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
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

