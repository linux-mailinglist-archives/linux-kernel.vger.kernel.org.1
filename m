Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7326332B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgIIQ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730676AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A636822249;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=YznwoAMP11ute83m7OlNbCadCCFTa7nZRYUzZoy7TCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xtDo9Ro3Ps9MJFixX5H2KfNEYv9BCBtYbJb6zx9yY9OXHm4CGET2NCoejwQQPKTQz
         Cttv8p+5iCB26t/VigupJZ8c/dF7hvpcRTpXJHvY8KI4yj6Np5RfoX0BYl0C7OUAix
         nWfmn1LEKgBUX7MJRv80qS6C2rK6aC7tb3/kN1Ik=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXj-PI; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] iio: iio.h: fix a warning at the kernel-doc markup
Date:   Wed,  9 Sep 2020 16:10:57 +0200
Message-Id: <d8f2275c438c459ede4e6fba03ce719cc6ad898b.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a warning at iio.h kernel-doc markup:

	./include/linux/iio/iio.h:644: WARNING: Unknown target name: "devm".

Because it is using {devm_}foo notation. Well, this is not
a valid kernel-doc notation. Also, it prevents creating hyperlinks
to other documentation functions.

So, replace it to a better notation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e2df67a3b9ab..f1daaba9e706 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -641,7 +641,7 @@ static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
  *
  * This utility must be called between IIO device allocation
  * (via devm_iio_device_alloc()) & IIO device registration
- * (via {devm_}iio_device_register()).
+ * (via iio_device_register() and devm_iio_device_register())).
  * By default, the device allocation will also assign a parent device to
  * the IIO device object. In cases where devm_iio_device_alloc() is used,
  * sometimes the parent device must be different than the device used to
-- 
2.26.2

