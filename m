Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9052FB741
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbhASKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389835AbhASKRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:17:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14BBF23135;
        Tue, 19 Jan 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611051267;
        bh=f70VrjUazjIsj4geHIDw8iQGbGJuOPNIJZNEMBLszRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPojx9r5LoGRC1ee4hZVw2igy9mmbVvGuf6QgUNEoYQx4JFPmoC9B4btEsnavSJYa
         mjB08TRcgde9QMn17z1iR7yP+9jApxQfKKRIqYEInrmyp0I2lAuvVAFaPzDL9DIPnE
         pjJ9lUEV6hDTNN4xhu6D/Zq66OHEBDRnCkZbMJjblJQD8tw7QxpNeOKkgigokxGQ1J
         ZXFUbpOvmHkAR6+STCtIapkWYgqQt1A6BD7IY1TGrzZDS6YWWB02jI3NfTYNVL+3sx
         2ev14SHq5npr0NofCqVDLMFmIAXchsyOxPF/ueVWsZz5EOhm7vs/2YWocvrPvpMTwx
         lg2At/rptwb9g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1o1o-000tP2-T6; Tue, 19 Jan 2021 11:14:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/18] staging: hikey9xx: hi6421v600-regulator: fix get_optimum_mode
Date:   Tue, 19 Jan 2021 11:14:17 +0100
Message-Id: <7b981bc43760502e3ad3553ca9480cf861346457.1611048785.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611048785.git.mchehab+huawei@kernel.org>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the driver refactor, a regression broke the logic inside
hi6421_spmi_regulator_get_optimum_mode(). Basically, if a LDO
has eco_uA == 0, it doesn't support economic mode. So, it should
return REGULATOR_MODE_NORMAL.

If economic mode is supported, it can return either
REGULATOR_MODE_IDLE or REGULATOR_MODE_NORMAL, depending on the
load current.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 72dd779d85e6..5fe77b490166 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -206,7 +206,7 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 
-	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA))
+	if (!sreg->eco_uA || ((unsigned int)load_uA > sreg->eco_uA))
 		return REGULATOR_MODE_NORMAL;
 
 	return REGULATOR_MODE_IDLE;
-- 
2.29.2

