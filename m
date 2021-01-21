Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3C2FE3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbhAUHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbhAUHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:19:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2332B2396F;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=HuED0fleILW116DXWL4/LVOkOe1VH+LKgrg9V6adeZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqbUi4OQGjQ8L/jLJhzj6BUB4ad/cMnhnEayPo3uLRq5DrCTdJ81LoC2/FGIQg/iI
         QesvzTYU10W18GfnqFa65Q3f8AtBYnnBlGNPwVbjOiMjuXdfjMmnGJEbN99hPw+RqQ
         LgbS5hXJti0bAbjJPUpgemHZm//g0CUpd7S7qeImoL7OkWQo3csVUntuP+hHTL2ueE
         0IhChpsqtpOshLT/rYFkr1H5v//hb4K3o4yZ5zPPmQ7dtgQruROLR3v/05LWK9yf37
         NSHzqQqUonEhjlydiH+xd4JYReHeVR16ZmQy0wnpPHmcM01sCHdihwR4ET3AjPXjNC
         b0CgsEoohBJaA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsC-Hm; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/21] staging: hikey9xx: hi6421v600-regulator: update copyright
Date:   Thu, 21 Jan 2021 08:18:11 +0100
Message-Id: <80d2d21c3d327e3acc89d016b20bd2d93e9c6f65.1611212783.git.mchehab+huawei@kernel.org>
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

