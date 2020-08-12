Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1C242CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHLP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgHLP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0388522E02;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=/Uzg2tuykg7lC6MMvx9CJYJZWVruD3HfqHqckUtCNp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFp/DN2DR22gySSJv+EgsJkzNvmHkz5xJ4ms7GTEzmLklC3qq34iJOYE2lZKM+6Is
         14Wtn3DrWjePn8j5l7Uv2Dowjl7hfYIzrTQinvEG56tCAX3ifW61/JnO015vuB20Fu
         Ja0ApwjBaZ0HR2zITWAAZZC4cXlWE6E7Dd3n7YeQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7A-40; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 34/44] staging: regulator: hi6421v600-regulator: don't use usleep_range for off_on_delay
Date:   Wed, 12 Aug 2020 17:56:44 +0200
Message-Id: <799fc8e9098c04c4bbdcaffc32334ca0763fc424.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator's core already handles it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index abd1f43dd5ec..31b8ff19fd31 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -73,9 +73,6 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
-	/* keep a distance of off_on_delay from last time disabled */
-	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 1000);
-
 	dev_dbg(&rdev->dev, "%s: off_on_delay=%d us\n",
 		__func__, rdev->desc->off_on_delay);
 
-- 
2.26.2

