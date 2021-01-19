Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9457D2FBDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbhASRcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390628AbhASQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:12:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40FCC23121;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=HuED0fleILW116DXWL4/LVOkOe1VH+LKgrg9V6adeZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHEQ9B3bEXQcsbYrj8BVPXJnRZYQMFCjxdZ6+pl+6D+2A1BQUG49xlMyT3fLs6y89
         uNWBFomqnsUbF8ljFTi7M0ExLgJ6sb1CcKRF4gbOgtWVUvUSZyrR8IGjWoZxoim4U9
         BWOga9qgK6x1hOQl0z/0E57EaNaqvqQee6ib6icGaQX9vQESAzptB6k0uAX7IW6rfR
         3Nf0CbUd4YCQvdK/K46mc55+Ummo0XaBXOvNUgVaOxOXToZVrHj6gLDypjyI3u+n4W
         cH3YB8R8iXK+hBPlfGSJfyb4fmXW+42Gu4eeRR6QVgGvoGadsFCNhYyEyfSuf0uxvm
         RIgmL9Du1KDnA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012bn-2q; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/21] staging: hikey9xx: hi6421v600-regulator: update copyright
Date:   Tue, 19 Jan 2021 17:10:35 +0100
Message-Id: <8c0c517fe7c4a5afa7290f2a412d11562cd1ae75.1611072387.git.mchehab+huawei@kernel.org>
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
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 564d86f0e4dc..5e78eebfc1f3 100644
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

