Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA32EB1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbhAERpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbhAERp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:45:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A6A820449;
        Tue,  5 Jan 2021 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609868689;
        bh=TjjlwPMS6rylNBKyHvGAxREpk7KDsSRvPjUyiApN9c4=;
        h=From:To:Cc:Subject:Date:From;
        b=JcQTb9V2t7KutYYl0TuGwdhXkuwLOOm4JQHCGbOjBVobZDyJpChtLwFgiIRs0TU+G
         VUx51LQhg4u6iaVTqM+hBDvpLblH4T7EmvPum4XqWvQ1+RCSMKaE1OCEMSMRZtmBaE
         ogwxOJab3WIewonz0RYTyI8TblKdRVuuVBv1JJgMXbpDj2DFHJedv1Snrd8JTsk02P
         VWyXtpzb7nP+MJvkB9eymWhxUHBYWFIJdT15XbXwhEf7fG+h8eITXAvSe7wl9MeBpl
         IGaszDrjqBpDG3J7eiEnA6XSoKzXOeTTPiKl7VOlc/nbjMGu1o/5vJ8dEYeFIZxS7S
         M9qP2gWV1uMbA==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: samsung: exynos-chipid: correct helpers __init annotation
Date:   Tue,  5 Jan 2021 18:44:40 +0100
Message-Id: <20210105174440.120041-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After converting to builtin driver, the probe function should not call
__init functions anymore:

  >> WARNING: modpost: vmlinux.o(.text+0x8884d4):
    Section mismatch in reference from the function exynos_chipid_probe() to the function .init.text:product_id_to_soc_id()

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 352bfbb3e023 ("soc: samsung: exynos-chipid: convert to driver and merge exynos-asv")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/samsung/exynos-chipid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index fa6a9b9f6d70..5c1d0f97f766 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -44,7 +44,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOS7420", 0xE7420000 },
 };
 
-static const char * __init product_id_to_soc_id(unsigned int product_id)
+static const char *product_id_to_soc_id(unsigned int product_id)
 {
 	int i;
 
-- 
2.25.1

