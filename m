Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C0E2FB73E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbhASKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389830AbhASKRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:17:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 129E623134;
        Tue, 19 Jan 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611051267;
        bh=6pdYl50Rh1vVd3jFSES864oB8V22rYFZulSbbjLLick=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QngWENRf+0x5NbLXFpzgZy6wLAsc31eiiBPSjjcA/k3S9+EO3UbNj+GflcFsqLlGB
         OWqpEpmVjoIearigqojEY+m5xdgHE40yma0/iyHQOQ9A6ht3sqXgc/tyN76fd41yzI
         88sWy1VNnvluU62Bk2QnhBZs1VIiayVShqQ59+1hx9nhTt4+nT0OH2CVbPZ/FJxGJw
         kTKAa9R3wWcf5xUFSB0njj0m1aSgCdJYQOQ3mF5MjFSClYyR4AldWAYBvkxCnrDtnd
         P2pCXzfEXYWbfd0N962K6O+pzmMgXMffoyBPQMAncKLMjuI/z2218sE84at1g+I5Au
         RYt+MADf+o8ow==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1o1o-000tOv-Qe; Tue, 19 Jan 2021 11:14:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/18] staging: hikey9xx: hi6421v600-regulator: update copyright
Date:   Tue, 19 Jan 2021 11:14:14 +0100
Message-Id: <e3a3dfb27f89438e135ef972cdb2ded4f62b7bd6.1611048785.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611048785.git.mchehab+huawei@kernel.org>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
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
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 1593256e9057..35a72ea1bd14 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -4,17 +4,9 @@
 //
 // Copyright (c) 2013 Linaro Ltd.
 // Copyright (c) 2011 Hisilicon.
+// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
 //
 // Guodong Xu <guodong.xu@linaro.org>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License version 2 as
-// published by the Free Software Foundation.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include <linux/delay.h>
 #include <linux/mfd/hi6421-spmi-pmic.h>
-- 
2.29.2

