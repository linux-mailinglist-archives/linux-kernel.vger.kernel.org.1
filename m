Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42482FE3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbhAUHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbhAUHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:20:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 462E5239D0;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=x28SiU6l6j7WY3/WuLOb8FaTKIg2knDGi8jFvYYTrbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGaDM58hfJN9YE84ayR73e9cGjciWAu/pxtNF113RFQahEnMaag+vc+ZXhtjuzQPt
         o/VFU/XI3ZGKdp8ySYW9Ez+Lcecv49QkTkaeZn7bCKs/FqReozcJ0Y1b1lI4VI9E2S
         4EQSCBuR/idN6sZxl/nL61I5tgYd0K2KQYpXai9hSwoqlDoYSpm4zyr40xugcykgLk
         4YPBn1rQAtD5BH6zMaD37XFKRSBfjq+oyUcH65xmsyqpqLSdiaCH4A74OOtXNAhtt0
         JsJ2kWStqvGMGy45m+Yxy3BFhWPcll8jjhHAgNPgxtu/XqL57VJpGmRkPduy7YjKtN
         cOo7VH4azm+6Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsK-KG; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/21] staging: hikey9xx: hi6421v600-regulator: fix get_optimum_mode
Date:   Thu, 21 Jan 2021 08:18:14 +0100
Message-Id: <f087981eb695eaab8c301c42977a4aa884affbbf.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
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
index 9f096d4e46db..382a0b21643e 100644
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

