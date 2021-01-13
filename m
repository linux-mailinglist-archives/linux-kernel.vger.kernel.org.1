Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5352F40A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393604AbhAMAnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392141AbhAMADC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:03:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF89C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:02:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k10so11868wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0+3ejHD3NuIeLjJtpGcKRQHmuMdhFptU0OyF3oj24o=;
        b=nmp8vHHFqcTim728WOa/l61IOZJFBzAZxv7o3C+dlc7QXSZQrCEejQXWhFdJduBW3S
         DZCOYscC83ntVgp5/WNgtPcm+jq8Zz7M6SKnQHe5Oe87zoi+VxAuhYr14OIL51zgtnGb
         ARydBRuL82YZmlAJCvk/vp6/iRGtr3UIXFT6MBkUjzkG9jUQle9MHUDRWi0oLzrhW+sN
         1EMlplHncwSYyr1rCwAHpSzrmCl6cg/ANuvi2UtS0KykN+iv7bBtnqBGzW0Kp+zeqXIB
         PM2vka0v4Vdlgut7Im2Z6yiJVHYM31KpC8jHcCssWBSGX5+kYlud3jZaEQ8u9gG7do24
         SLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0+3ejHD3NuIeLjJtpGcKRQHmuMdhFptU0OyF3oj24o=;
        b=ct0KGRGEWr4+x1dOBhPrQngN9GYclY5xIoIqoKBBoJzLgukOcHlypT8mP92YRCilg6
         qYiOHOW+DJGpXadFTmpXR4Ku3ByV2jsEJtJFfDLBjQWN2WNANo5Uy9U2ceSg+51APQC8
         u+IyyYcnh7vgWTJZAiIka2tHceytmP8rMOtJd1JOwkyMNa3txiSMwjxV8LfHOkROXNVa
         yH6s5Vis79PpFmVbT4X7xaFpoGUh2s1EWf2efk8pfjyPfgRjtOSybk5sNCLepbB6+/t0
         baBNkO4wTRCJww80elDyL6MY4vpHhEh+GmQpTWPZ8iwVZqsKjGING5CKpbe9HHlVPDUL
         5ILg==
X-Gm-Message-State: AOAM5324evl1nB/aXhKYG1YmldXRAb8C7p74lDOBqjpu78eG28/WYCvy
        GEAGrvB1n91dRpyvI96BPX1iiGyVY0o=
X-Google-Smtp-Source: ABdhPJw8WUXo/fAiR9ZDJt1s/BY7FtYb0C5Aurx14tBz9fIZK2HbyaFPsmrpvjRkowKp92kps6rgQw==
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr118775wmg.33.1610496140443;
        Tue, 12 Jan 2021 16:02:20 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id m14sm76269wrh.94.2021.01.12.16.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 16:02:19 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Subject: [PATCH v2] software_node: Add kernel-doc comments to exported symbols
Date:   Wed, 13 Jan 2021 00:02:09 +0000
Message-Id: <20210113000209.322218-1-djrscally@gmail.com>
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
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in version 2:
	- Replaced "fwnode_handle" with either @fwnode or natural language
	reference to a firmware node handle as appropriate.

 drivers/base/swnode.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a4b2008fbc2..e98018aa8b2f 100644
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
@@ -71,6 +78,14 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
+/**
+ * to_software_node() - Fetch software node associated with a firmware node handle
+ * @fwnode: The pointer to a &struct fwnode_handle to parse
+ *
+ * This function attempts to fetch a pointer to the &struct software_node which
+ * was used to create the given @fwnode. Note that this will only work if the
+ * software node has **not** been released.
+ */
 const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 {
 	const struct swnode *swnode = to_swnode(fwnode);
@@ -79,6 +94,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
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
@@ -800,6 +823,27 @@ void software_node_unregister(const struct software_node *node)
 }
 EXPORT_SYMBOL_GPL(software_node_unregister);
 
+/**
+ * fwnode_create_software_node() - Create and register a new software_node
+ * @properties: NULL terminated array of properties to assign to the new node
+ * @parent: Pointer to a &struct fwnode_handle to assign as parent to the new
+ *	    node
+ *
+ * NOTE: The pointer passed to @parent **must** be to a firmware node handle
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
@@ -832,6 +876,15 @@ fwnode_create_software_node(const struct property_entry *properties,
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

