Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95492F5C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbhANIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbhANIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E8B323A50;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=00mBMzyRTOVxMhGgyj2bmNtXZmJA9BKao9o6P+DjHaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3wmnVwLQPsHyvAj4sAJzEank3AB2Jlych6H+vzXZ8f9USDPXFavb/8RXGVLHwioU
         YR+4H3A5kJIMPbJ6KXAXnTQMK5oDB9KWHCFQ1GPSEjYXpzlswiXfml4y7lOpkcvu3u
         /fWQQXb/+oxk3RJaYdxSDD1B40QPOB3yiHpsDA9XK2ckYU0FF8cDm/lXAYpJwNlQCr
         81ZE0WvGSxD0BQkrwdMUMb6MVgj19xkcGjJgKXHhI7kuRwJcO5yoTUqI/rwPIGE1To
         RUV2lOdeyaS5U+r6/6G/J9ojUkg2LX6ffNRodIVjNw9LGnNnoYSP79H5AGnJqFuD52
         t8E/RvtKTYMLg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ6y-EO; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/16] reset: core: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:50 +0100
Message-Id: <8defd442bce0cf5524cf1cfbbd028eede90358a7.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup:

	../drivers/reset/core.c:888: warning: expecting prototype for device_reset(). Prototype was for __device_reset() instead

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/reset/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 34e89aa0fb5e..dbf881b586d9 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -875,8 +875,8 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 EXPORT_SYMBOL_GPL(__devm_reset_control_get);
 
 /**
- * device_reset - find reset controller associated with the device
- *                and perform reset
+ * __device_reset - find reset controller associated with the device
+ *                  and perform reset
  * @dev: device to be reset by the controller
  * @optional: whether it is optional to reset the device
  *
-- 
2.29.2

