Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6440129744A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376049AbgJWQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460729AbgJWQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:47 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF876208C3;
        Fri, 23 Oct 2020 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=jqnFAPsIfCGcK4EmZia0M9yZrQtemKpIJgvWitRa3Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hA1AFJoVKGlISkeveViqf6CWXGyJh0elExzT2kuY+N5RE+wZt6QdJ9h8nzQ4WgSB2
         Rh+J7XFhJwqBGteqo1wOQ2wae/PaDbDgIrjqPguDx70QnLjeMTaC3XDJY5vcbl4qBB
         D/6W+kTO/uyI6yykN6BG0Oc/grQ3g1MvCvy5gxOA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002Avf-Ur; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/56] drivers: base: fix some kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:56 +0200
Message-Id: <2fb6efd6a1f90d69ff73bf579566079cbb051e15.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

class_create is actually defined at the header. Fix the
markup there and add a new one at the right place.

While here, also fix some markups for functions that have
different names between their prototypes and kernel-doc
comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/base/class.c                    |  2 +-
 drivers/base/devres.c                   |  2 +-
 drivers/base/firmware_loader/fallback.c |  2 +-
 include/linux/device/class.h            | 14 ++++++++++++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index c3451481194e..7476f393df97 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -210,7 +210,7 @@ static void class_create_release(struct class *cls)
 }
 
 /**
- * class_create - create a struct class structure
+ * __class_create - create a struct class structure
  * @owner: pointer to the module that is to "own" this struct class
  * @name: pointer to a string for the name of this class.
  * @key: the lock_class_key for this class; used by mutex lock debugging
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 586e9a75c840..fb9d5289a620 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -149,7 +149,7 @@ void * __devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid
 EXPORT_SYMBOL_GPL(__devres_alloc_node);
 #else
 /**
- * devres_alloc - Allocate device resource data
+ * devres_alloc_node - Allocate device resource data
  * @release: Release function devres will be associated with
  * @size: Allocation size
  * @gfp: Allocation flags
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 4dec4b79ae06..91899d185e31 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -128,7 +128,7 @@ static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
 }
 
 /**
- * firmware_timeout_store() - set number of seconds to wait for firmware
+ * timeout_store() - set number of seconds to wait for firmware
  * @class: device class pointer
  * @attr: device attribute pointer
  * @buf: buffer to scan for timeout value
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index e8d470c457d1..e61ec5502019 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -256,6 +256,20 @@ extern void class_destroy(struct class *cls);
 
 /* This is a #define to keep the compiler from merging different
  * instances of the __key variable */
+
+/**
+ * class_create - create a struct class structure
+ * @owner: pointer to the module that is to "own" this struct class
+ * @name: pointer to a string for the name of this class.
+ *
+ * This is used to create a struct class pointer that can then be used
+ * in calls to device_create().
+ *
+ * Returns &struct class pointer on success, or ERR_PTR() on error.
+ *
+ * Note, the pointer created here is to be destroyed when finished by
+ * making a call to class_destroy().
+ */
 #define class_create(owner, name)		\
 ({						\
 	static struct lock_class_key __key;	\
-- 
2.26.2

