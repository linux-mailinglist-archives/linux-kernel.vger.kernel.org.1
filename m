Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC02EA116
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhADXse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhADXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:48:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:47:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so768456wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SsZg8TcWx9vv5xiVTPlQhmX54Xge3qi3aLrtCAzMPM=;
        b=fA/yIpdjzC21bNNgvWERCJlX6ssmV3uHeCb9g/8wf9r39S5egMKHuP7iVzSOIZ5V3+
         zQfEZulL23812Dy+oiyUqsG1aDGvcTBdNR4bGfinkAHfTvKdWaqFbIdJ3/+PIWgdS9W5
         33jNcyOK+2QVHJls0B6ywmucDV3zU/ymNcR62J0E8sKOSPuS7GNXYDo7eIPZcUXg52b3
         24BJleXhy3Zc9g2Ra0alnWS+7fPUl7hBq+SfnlIsINlHPSp+YWk3tH5j0dGn2hj7tOQO
         8ighKQZKBrXzY5s05E15DaecEFveU5kB2M8pnYRbJv9Jmu5lkUGT8ehMRONHZE0q5tfv
         P34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SsZg8TcWx9vv5xiVTPlQhmX54Xge3qi3aLrtCAzMPM=;
        b=BWD7u1KvY8+KigjwmpDvzhRkmLYeMTCZB7eRJQ/w3H6O35EN8LbLeO6flhY7XZvlPr
         gjJHfRdyfVeQTlCm9cmoR98tdMfKiiKfy6DZ4+crSU0Di3ywbc0CCkKrIMzal8/KTdFb
         vmAsmjyAVF1oEXlmpHBNzLAl+pBx4n0A3Wia+WbDCdzlSlqEToTCijCx4sMnGIRb3CHI
         Wt/LuXCI+8nKLeonPV9Wvg1trgNekTY53S1zLbKFgsds/PUBA7UtXJ1xI8fqLy5hykCc
         IRDzToPgPoGbifY1f0i7qIoQ+gJ0HTVJH5FresTxnGZuOq3s5cviMpA8E3ltQMWalxDm
         h7AA==
X-Gm-Message-State: AOAM531R8YUVBV8LbVSEi8rYYPvHy+2Y+h8l7htjEWhLYbV2H0KT7k4B
        v8phVKw99cvVJtDqi7/trYvnHkKWxKmouT4z
X-Google-Smtp-Source: ABdhPJwHoFI9NU7oz8+0OG41kE9mlajUhX92DACpUIGW5y+upA+fH3tKWvqUFdZa+BY0JcaYLiWFtQ==
X-Received: by 2002:a1c:e902:: with SMTP id q2mr971770wmc.143.1609804070381;
        Mon, 04 Jan 2021 15:47:50 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id b10sm1530725wmj.5.2021.01.04.15.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:47:49 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Cc:     sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Subject: [PATCH] software_node: Add kernel-doc comments to exported symbols
Date:   Mon,  4 Jan 2021 23:47:36 +0000
Message-Id: <20210104234736.419493-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
kernel-doc comments; add those in so all exported symbols are documented.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
With a view to maybe writing some documentation once the fwnode_graph_*()
functions are also added.

 drivers/base/swnode.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a4b2008fbc2..ea52e5e9af92 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -33,6 +33,13 @@ static struct kset *swnode_kset;
 
 static const struct fwnode_operations software_node_ops;
 
+/**
+ * is_software_node() - check if given fwnode was created from a software_node
+ * @fwnode: The &struct fwnode_handle to check
+ *
+ * This function is used to check whether a given fwnode_handle was created by
+ * registering a &struct software_node or not.
+ */
 bool is_software_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
@@ -71,6 +78,14 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
+/**
+ * to_software_node() - Fetch software_node associated with a given fwnode_handle
+ * @fwnode: The pointer to a &struct fwnode_handle to parse
+ *
+ * This function attempts to fetch a pointer to the &struct software_node which
+ * was used to create a given fwnode_handle. Note that this will only work if
+ * the software_node has **not** been released.
+ */
 const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 {
 	const struct swnode *swnode = to_swnode(fwnode);
@@ -79,6 +94,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(to_software_node);
 
+/**
+ * software_node_fwnode() - Fetch fwnode_handle associated with a given software_node
+ * @node: The pointer to a &struct software_node to parse
+ *
+ * This function attempts to fetch a pointer to the &struct fwnode_handle which
+ * was created from a given software_node. Note that this will only work after
+ * the software_node has been registered.
+ */
 struct fwnode_handle *software_node_fwnode(const struct software_node *node)
 {
 	struct swnode *swnode = software_node_to_swnode(node);
@@ -800,6 +823,26 @@ void software_node_unregister(const struct software_node *node)
 }
 EXPORT_SYMBOL_GPL(software_node_unregister);
 
+/**
+ * fwnode_create_software_node() - Create and register a new software_node
+ * @properties: NULL terminated array of properties to assign to the new node
+ * @parent: Pointer to a fwnode_handle to assign as parent to the new node
+ *
+ * NOTE: The pointer passed to @parent **must** be to a fwnode_handle that was
+ * created by registering a &struct software_node, meaning is_software_node()
+ * must return true when passed that pointer.
+ *
+ * This function creates a new instance of struct software_node, assigns it a
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
@@ -832,6 +875,15 @@ fwnode_create_software_node(const struct property_entry *properties,
 }
 EXPORT_SYMBOL_GPL(fwnode_create_software_node);
 
+/**
+ * fwnode_remove_software_node() - Put a reference to a registered software_node
+ * @fwnode: The pointer to the &struct fwnode_handle you want to release
+ *
+ * Release a reference to a registered &struct software_node. This function
+ * differs from software_node_put() in that it takes no action if the
+ * fwnode_handle passed to @fwnode turns out not to have been created by
+ * registering a software_node
+ */
 void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-- 
2.25.1

