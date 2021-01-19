Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931D92FBDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbhASRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390725AbhASQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:12:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6572B23139;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=x28SiU6l6j7WY3/WuLOb8FaTKIg2knDGi8jFvYYTrbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvDWFm8exPgkzziXSZzcKX0jqVDhhLDVSXMhsT0RphUQMbckgYsrGNflBj9PuL5Df
         YAs6l0sAdrdIrUrrug6LVmdIQprmjuJ0u/ZTQdh/I8LKiGmb0ogvrZWMH29AtvRN2+
         nlXv0APDb3txnYjMcm9doIJe5D1xJfBcm6K7dmAgSYX+jZeLaBZKdQTZHstTqCsMuH
         juQsBgFgYMWv/qM02idUXR+z92VOyiKGnb1h78hhhjT9qvhbBVVctyDzjSAhkFml5V
         23rvoZ4NlPoqD0toKAEDXQQctMgXD4iJ1P1pS5Woch8FXkFYQPQw6QFrmQOnRIthVQ
         sqJY9iuN0HakA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012bv-5N; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/21] staging: hikey9xx: hi6421v600-regulator: fix get_optimum_mode
Date:   Tue, 19 Jan 2021 17:10:38 +0100
Message-Id: <b2841fe918ba783611552c9e7c63f58fd78a8f20.1611072387.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611072387.git.mchehab+huawei@kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
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

