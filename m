Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFF2710B1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgISVov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 17:44:51 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:16166 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgISVou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 17:44:50 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Bv3j54v4Gz8k;
        Sat, 19 Sep 2020 23:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1600550906; bh=q+k1hemm6USzF63AZgiW7ah+SVEFoulnSPKIIOiLkgg=;
        h=Date:From:Subject:To:Cc:In-Reply-To:From;
        b=pVMS5DPb91VJY7Lch9kli5vIcaswXIZzG+1b7H2lmwftibefFZuMFlERVjGFonfHf
         8IelheTxhQdiy1KZYOhTkjycEVt/Omtp8BpIh00YRnxc2BC3Z9lpnnINd6CjwS5kUL
         7o+VEbpnXR32rD97Z5GNwWmJCnhg2TOQfi93vlfE11b1fgeYDoRGSvQHNfuA0f4ZzY
         laWwSqNcAZt27VrWqLn93ZxZZHuAHV2S8tny9Uyya+NxE1zE6u8CatADsvO51IDMaa
         cz79lWIH/Y1N4Jl+qP9E4Z9XkiHevQCVnx0tkgzpxAKCaPkrfg77wLc6WO0iXSs0QV
         8BHJ7uVe5Fn6Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 19 Sep 2020 23:28:25 +0200
Message-Id: <d3381aabd2632aff5e7b839d55868bec6e85c811.1600550732.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] regulator: unexport regulator_lock/unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200916103652.GA6374@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_lock/unlock() was used only to guard
regulator_notifier_call_chain(). As no users remain, make the functions
internal.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c         | 6 ++----
 include/linux/regulator/driver.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)
---
 v2: rebased on current regulator/for-linus

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7ff507ec875a..8da37e0d1100 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -190,11 +190,10 @@ static inline int regulator_lock_nested(struct regulator_dev *rdev,
  * than the one, which initially locked the mutex, it will
  * wait on mutex.
  */
-void regulator_lock(struct regulator_dev *rdev)
+static void regulator_lock(struct regulator_dev *rdev)
 {
 	regulator_lock_nested(rdev, NULL);
 }
-EXPORT_SYMBOL_GPL(regulator_lock);
 
 /**
  * regulator_unlock - unlock a single regulator
@@ -203,7 +202,7 @@ EXPORT_SYMBOL_GPL(regulator_lock);
  * This function unlocks the mutex when the
  * reference counter reaches 0.
  */
-void regulator_unlock(struct regulator_dev *rdev)
+static void regulator_unlock(struct regulator_dev *rdev)
 {
 	mutex_lock(&regulator_nesting_mutex);
 
@@ -216,7 +215,6 @@ void regulator_unlock(struct regulator_dev *rdev)
 
 	mutex_unlock(&regulator_nesting_mutex);
 }
-EXPORT_SYMBOL_GPL(regulator_unlock);
 
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 8539f34ae42b..11cade73726c 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -533,9 +533,6 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 
-void regulator_lock(struct regulator_dev *rdev);
-void regulator_unlock(struct regulator_dev *rdev);
-
 /*
  * Helper functions intended to be used by regulator drivers prior registering
  * their regulators.
-- 
2.20.1

