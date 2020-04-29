Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127561BD8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgD2Jp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2Jp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:45:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC0C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:45:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x2so843100pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ohhcV++S296MTGeRuhLGIvJtdPeXzd9ZSIW5CqAT66c=;
        b=r3FhSM5Jq6IGn5eX6PX8chZEibpKYSlKY4WEB3a3Y3I2D7etvrIh2/chQ1VPHStEx2
         2kPbiuS1U1bvPZBp1gyD/xOIOQjYEVWpDfOtLfByE4gjhbimwWK0gLFpPC2t34X5SWXY
         Nj9SZSZS4nKCbT4O0Z3Fuq6c7JhcCLhXE/FvNcKuGKBgiM5dDMQKJwfqXlzDISN/0u+p
         XoQK5YCsTzQ6ObrQz0ogSUdOfhxD65jCoTv4MgPItjvhhvDzkwI2leBAUSZuepMLAzf9
         tQjJonKSrEEUshOovDgy9li/METHkeEshx0miQ0WrlkGex2Zz2ueXezv1NQ2ZjOgA9iA
         500Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ohhcV++S296MTGeRuhLGIvJtdPeXzd9ZSIW5CqAT66c=;
        b=Yw/f0QSJPe0RQnBHCMQDWNXpU/VA+mM8+efNVAB/z8AdQI3qy7L95UxlUgi5aOe4D2
         F5uFQlc1duAHd+vj5+cQFWDnlKMr8CQjrdTwWF5jDM2wiT/GOAVR0jCj3pz4+N32SCGv
         0Iqp/a/pA2Z75lmmWtaD1kimw5lFPBBKMoz5uxsHe6itjrb1IQgWoMfoUt3t1qEWA1Ia
         sXtYIQMqQJ9mb8ono4LGxjqQEXUOF2tgC332WDIYRr59NhEb9rHoOBsfHErIQ4krUi3a
         HwS+/R2QRGBmzg/EzuDsLc2PsdiNMnX2iXRHNPXV0ebFiFqbLvQloBpnmbjGQHFJ7JYE
         PkEg==
X-Gm-Message-State: AGi0PuZL+8nJUIAlFfoJqESTT59yDL2CRy/w4fQvz+ah1y8jH01yk8fd
        enT/0vI0IIAcKqQheAZQNF7DOp5hh8c=
X-Google-Smtp-Source: APiQypLZBo08uLNAV/oOS/jZyyyFWI73jIcpFLt+eUImEfrpoREuu9dMgQo60MIf6PiAUsXGBX3seQ==
X-Received: by 2002:a62:2b82:: with SMTP id r124mr1353326pfr.242.1588153556928;
        Wed, 29 Apr 2020 02:45:56 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.15])
        by smtp.gmail.com with ESMTPSA id g79sm727873pfb.60.2020.04.29.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:45:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sprd: Remove unnecessary spi_bus_type setting
Date:   Wed, 29 Apr 2020 17:45:37 +0800
Message-Id: <88f48e38c4f3e2130de0f58564562453d7ee57f2.1588153213.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi_register_driver() will set the spi_bus_type for the spi_driver,
thus remove the redundant setting in this driver.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index ebdf2f11ae28..33336cde4724 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -284,7 +284,6 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
 static struct spi_driver sprd_pmic_driver = {
 	.driver = {
 		.name = "sc27xx-pmic",
-		.bus = &spi_bus_type,
 		.of_match_table = sprd_pmic_match,
 	},
 	.probe = sprd_pmic_probe,
-- 
2.17.1

