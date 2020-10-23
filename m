Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECDC29749D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbgJWQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbgJWQdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A855F2468B;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=qr1Bdzxu66hg12cVA1OzgoArW19xtMHTbFo6QeDuuRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USsA8KUhim9AG5ih7fqD4h+zUCU3gsUMjm0mF9FGizpIdPcdY1oTVyv1+mRMbAvxB
         HO636PBqTfDMFq1atO4dDvBkQPDHKR9qbCztWuDbfGwvTE1hLViArQ3zRXV2ZiF7ct
         SjBA1Zo69J0PuKKETwd8lP17KygObCzn2WPem1Tw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002AwH-LI; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/56] parport: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:09 +0200
Message-Id: <7d7bc15bf755561c230ba95b4fc083fa1026a942.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc markup inside share.c is actually for
__parport_register_driver. The actual goal seems to be
to document parport_register_driver().

So, fix the existing markup and add a new one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/parport/share.c |  2 +-
 include/linux/parport.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 7fec4fefe151..62f8407923d4 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -243,7 +243,7 @@ static int port_detect(struct device *dev, void *dev_drv)
 }
 
 /**
- *	parport_register_driver - register a parallel port device driver
+ *	__parport_register_driver - register a parallel port device driver
  *	@drv: structure describing the driver
  *	@owner: owner module of drv
  *	@mod_name: module name string
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 1fb508c19e83..f981f794c850 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -297,6 +297,37 @@ int __must_check __parport_register_driver(struct parport_driver *,
  * parport_register_driver must be a macro so that KBUILD_MODNAME can
  * be expanded
  */
+
+/**
+ *	parport_register_driver - register a parallel port device driver
+ *	@driver: structure describing the driver
+ *
+ *	This can be called by a parallel port device driver in order
+ *	to receive notifications about ports being found in the
+ *	system, as well as ports no longer available.
+ *
+ *	If devmodel is true then the new device model is used
+ *	for registration.
+ *
+ *	The @driver structure is allocated by the caller and must not be
+ *	deallocated until after calling parport_unregister_driver().
+ *
+ *	If using the non device model:
+ *	The driver's attach() function may block.  The port that
+ *	attach() is given will be valid for the duration of the
+ *	callback, but if the driver wants to take a copy of the
+ *	pointer it must call parport_get_port() to do so.  Calling
+ *	parport_register_device() on that port will do this for you.
+ *
+ *	The driver's detach() function may block.  The port that
+ *	detach() is given will be valid for the duration of the
+ *	callback, but if the driver wants to take a copy of the
+ *	pointer it must call parport_get_port() to do so.
+ *
+ *
+ *	Returns 0 on success. The non device model will always succeeds.
+ *	but the new device model can fail and will return the error code.
+ **/
 #define parport_register_driver(driver)             \
 	__parport_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 
-- 
2.26.2

