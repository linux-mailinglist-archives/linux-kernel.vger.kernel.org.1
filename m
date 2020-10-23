Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394F529748A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbgJWQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465519AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17ED4246A0;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=O0Km0ajgV9bhoOvh/i6iVzB6gK8rP3kJd/sXq7p6oTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuQjCs93q2GcvhNIAZAYHu76jGY/Y3EndDPqidILVKBMzvHdzTzKQOctn37b/LTQe
         fXvgpI34cqU8bdBiUu3TOlaABW3Z01FnkQ32Rpw4wl3yFwmO2CmAsH96b5ssdVU1RJ
         H1sf6PnBmCZdOzPVvu0x2s0XcenT7tHoRr1zb0v4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Awi-2k; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/56] uio: fix some kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:17 +0200
Message-Id: <82ab7b68d271aeda7396e369ff8a629491b9d628.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions for (devm_)uio_register_device should be
at the header file, as the macros are there. The ones
inside uio.c refer, instead, to __(devm_)uio_register_device.

Update them and add new kernel-doc markups for the macros.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/uio/uio.c          |  4 ++--
 include/linux/uio_driver.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 6dca744e39e9..01b349c1b923 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -906,7 +906,7 @@ static void uio_device_release(struct device *dev)
 }
 
 /**
- * uio_register_device - register a new userspace IO device
+ * __uio_register_device - register a new userspace IO device
  * @owner:	module that creates the new device
  * @parent:	parent device
  * @info:	UIO device capabilities
@@ -1002,7 +1002,7 @@ static void devm_uio_unregister_device(struct device *dev, void *res)
 }
 
 /**
- * devm_uio_register_device - Resource managed uio_register_device()
+ * __devm_uio_register_device - Resource managed uio_register_device()
  * @owner:	module that creates the new device
  * @parent:	parent device
  * @info:	UIO device capabilities
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 54bf6b118401..47c5962b876b 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -117,6 +117,14 @@ extern int __must_check
 			      struct uio_info *info);
 
 /* use a define to avoid include chaining to get THIS_MODULE */
+
+/**
+ * uio_register_device - register a new userspace IO device
+ * @parent:	parent device
+ * @info:	UIO device capabilities
+ *
+ * returns zero on success or a negative error code.
+ */
 #define uio_register_device(parent, info) \
 	__uio_register_device(THIS_MODULE, parent, info)
 
@@ -129,6 +137,14 @@ extern int __must_check
 				   struct uio_info *info);
 
 /* use a define to avoid include chaining to get THIS_MODULE */
+
+/**
+ * devm_uio_register_device - Resource managed uio_register_device()
+ * @parent:	parent device
+ * @info:	UIO device capabilities
+ *
+ * returns zero on success or a negative error code.
+ */
 #define devm_uio_register_device(parent, info) \
 	__devm_uio_register_device(THIS_MODULE, parent, info)
 
-- 
2.26.2

