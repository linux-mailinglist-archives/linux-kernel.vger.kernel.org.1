Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF42FC552
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbhATAFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbhATAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:04:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0832C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 16:03:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m187so1332652wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOCm0MAtYag3cO6vapR257IFIv+ZAiAozEsFVUS3vwI=;
        b=vGAxg6vGjCsnkbxEBux8Macd+hB+WDTQhuoY4E0QVtFNn1RI4JU1y0Uo1hfaJH5jYX
         3Ki/Oiw2KeLB/leVkeLBrbOBQIqeurG3MnDFMGUuGxdTJOKI5u7vor6IQnfPU6vHJ4DC
         RovQ8asv3QwM+af5FxCqizfZfoR2dPkobp9fW6O4GKHlD51rDR0epOQp1qbyIqmuSZwg
         5PDoKeoDFwhI8ZXwwnoZ5+UAOdnl+lAr9DVodxjSL9wUMC3Iel01nVRjld3TU4We61LF
         U70HLOyXykW/ep+og96IwGG/0loe/wYaFQUF5khWEueaIt+CKbZgxX7yjVTZZCssfOvh
         2ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOCm0MAtYag3cO6vapR257IFIv+ZAiAozEsFVUS3vwI=;
        b=GuDuzoRG8TQPjn5C8U9UsHlP71LYEzm0p4ZFc0ovuhiLxYGt3Y+5zi49gL7ubb0E4L
         Suazin/b8bgfXnuT75D+Ix/8Ex2YLnIRTxVCDfYNNm+wlLG6EFvJpF4KdeiI5WPl3nSh
         GuX0EtRGl6b2VinYcCd07IfOi7n5Q5IjctPvODdR1Qvm3lYR7ChwsrB+2cqo3Z9yX/Va
         3U1w4AsVhhqs4wfxEib0ZP4JXgYZ6CQU/tqljOv4+Zy2Mq2fOw1JIIRN2DanFbLV/yeU
         4htdSddGakPEb6eAV/lrnCK/8WvU5TxnXaEGoGE0ZJWxtmz/FhMBeQX4Az5yX50pnP9q
         plFQ==
X-Gm-Message-State: AOAM5332og51g3CArBAAml7ZLUEryVRfsOqby7XX3dbTFJB1U9TOv2+M
        6Vv6UWCiZLoMlf8jAIMtlps=
X-Google-Smtp-Source: ABdhPJxBwVeB8AYRoJliUGtlfSsJ/9iE+ODuyzwclc3PA5vyYtfOoCp0xFEU8BQPKBGpP2osiWA4gA==
X-Received: by 2002:a1c:6208:: with SMTP id w8mr1820430wmb.24.1611101027713;
        Tue, 19 Jan 2021 16:03:47 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id p8sm501734wru.50.2021.01.19.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:03:46 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org
Subject: [PATCH v3] software_node: Add kernel-doc comments to exported symbols
Date:   Wed, 20 Jan 2021 00:03:39 +0000
Message-Id: <20210120000339.471117-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
kernel-doc comments; add those in so all exported symbols are documented.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changelog for v3:

	- s/passed to @parent/passed as @parent
	- Wrapped a long summary line - TIL that you can do that, thanks
	  Sakari

 drivers/base/swnode.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a4b2008fbc2..39fbb653c58a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -33,6 +33,13 @@ static struct kset *swnode_kset;
 
 static const struct fwnode_operations software_node_ops;
 
+/**
+ * is_software_node() - check if given fwnode was created from a software_node
+ * @fwnode: The &struct fwnode_handle to check
+ *
+ * This function is used to check whether a given firmware node handle was
+ * created by registering a &struct software_node or not.
+ */
 bool is_software_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
@@ -71,6 +78,15 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
+/**
+ * to_software_node() - Fetch the software node used to create a firmware
+ *			node handle
+ * @fwnode: The pointer to a &struct fwnode_handle to parse
+ *
+ * This function attempts to fetch a pointer to the &struct software_node which
+ * was used to create the given @fwnode. Note that this will only work if the
+ * software node has **not** been released.
+ */
 const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 {
 	const struct swnode *swnode = to_swnode(fwnode);
@@ -79,6 +95,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(to_software_node);
 
+/**
+ * software_node_fwnode() - Fetch firmware node associated with a given software node
+ * @node: The pointer to a &struct software_node to parse
+ *
+ * This function attempts to fetch a pointer to the &struct fwnode_handle which
+ * was created from the given @node. Note that this will only work after the
+ * software node has been registered.
+ */
 struct fwnode_handle *software_node_fwnode(const struct software_node *node)
 {
 	struct swnode *swnode = software_node_to_swnode(node);
@@ -800,6 +824,27 @@ void software_node_unregister(const struct software_node *node)
 }
 EXPORT_SYMBOL_GPL(software_node_unregister);
 
+/**
+ * fwnode_create_software_node() - Create and register a new software_node
+ * @properties: NULL terminated array of properties to assign to the new node
+ * @parent: Pointer to a &struct fwnode_handle to assign as parent to the new
+ *	    node
+ *
+ * NOTE: The pointer passed as @parent **must** be to a firmware node handle
+ * that was created by registering a software node, meaning is_software_node()
+ * must return true when passed that pointer.
+ *
+ * This function creates a new instance of &struct software_node, assigns it a
+ * copy of the given array of properties and registers it as a new fwnode_handle.
+ * Freeing of the allocated memory when the fwnode_handle is no longer needed is
+ * handled via software_node_release() and does not need to be done separately.
+ *
+ * Returns:
+ * * fwnode_handle *	- On success
+ * * -EINVAL		- When @parent is not associated with a software_node
+ * * -ENOMEM		- When memory allocation fails
+ * * -Other		- Propagated errors from sub-functions
+ */
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent)
@@ -832,6 +877,15 @@ fwnode_create_software_node(const struct property_entry *properties,
 }
 EXPORT_SYMBOL_GPL(fwnode_create_software_node);
 
+/**
+ * fwnode_remove_software_node() - Put a reference to a registered software_node
+ * @fwnode: The pointer to the &struct fwnode_handle you want to release
+ *
+ * Release a reference to a registered &struct software_node. This function
+ * differs from software_node_put() in that it takes no action if the
+ * firmware node handle passed to @fwnode turns out not to have been created by
+ * registering a software_node.
+ */
 void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-- 
2.25.1

