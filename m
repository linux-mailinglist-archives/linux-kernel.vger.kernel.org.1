Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA22F5C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbhANIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbhANIGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC4FC23A5C;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611501;
        bh=a0ruAOkURcxqf2cnrjaNfUo/uSsvM0xN/YXaNx+qrxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejHD3cHRNzxG/8ISJyZJh80HrJaYCK4HaumrrcNaacs6SRbcLL4zss79d4QeXwVws
         OyYH9UvRl5PpGrBsn1dXndiE3421jomppDFd60UgtbV5r2Zn0dNL2spUBvhZHrU8H7
         5lTq7PjdIoGH8b+uYpbB3nZJA4TEfJfvFsZ1CaJFqwPKa9dKgrR0nQUckPFkyleNkV
         R3lMKUF+S94QGGE1DxJI8lTzt5VVToZbuh+f5AqBZOyjl+3kgHjD2o9XuWUspQ/fne
         7zUqQoVPdzydt26LD7PbBftXZvr2JqHoI3Jax+7OA9P6oK/ZnVvqACpbJTDiPv3/Y2
         jwH+4Uv8i/B7A==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxcn-00EQ6P-M6; Thu, 14 Jan 2021 09:04:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/16] parport: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:37 +0100
Message-Id: <dc0778af8c466cc667409ead05876a5cfd3cbece.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
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
2.29.2

