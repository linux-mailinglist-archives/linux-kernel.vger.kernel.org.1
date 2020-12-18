Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3DF2DE83E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgLRReo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbgLRRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:34:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96538C0610F9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x126so1937412pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkR5KGw6lOHFw7kU5pTdY0IIWw0NKqkih0SELdkxmb8=;
        b=DBREPFrFapCRqxKi8Q28381Uyq/Fj1Onz03ghAXR2urPxaEBt9myvb9C0ocMNAy/Rc
         nGenVzOCiuo6H9D+eFvdspI79dNwAvFPo437qhVdXkd7mP0qKfvJsUgMFWnCpl8B5TV6
         jfSFuc3ZZ3Byz3Big60B/+a/8g3e0LAexUoBy0AZ1IOWevGhUOeP6a/9caskPtCraAvU
         rW5zgUZv6uO6A7RZy9ozBboq3SM3T64QBy7b6OOKkEVgKvPEq/VrCmMZgFLD9q3hj3RI
         T/6L+qXNepkj2Ey9qDGc4hZ7OPnywF9yBAWw6u/bUHbzHJdtouLJh8ctqSK+sqaleKpw
         4/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkR5KGw6lOHFw7kU5pTdY0IIWw0NKqkih0SELdkxmb8=;
        b=bypu5l48CAZl6KAuRUeD5TqwO3L+TGPwz1oYnp7yqc2sSUYQxemzd3LJ2RyxdwSqfY
         XXKi3F+L2y9QlrnrtovOZBBi+coIt/VLDh4JmDbi0DKbjsc9XtgrETNTBH2T9Wq/0JM0
         bImTm6ObfdHMQRg48fpB2W4zIA1u/+uu2zPx1v7iYoUXM45cXYByCINYuo32VsJFq9yF
         JDMeivSac4/mzz7yASte2To2opdZPrapmBihUHjtVi8Psi1lnU4DL2zRMUiGyxlLlsVY
         c3vU3MhtP/6LD8HA62zR2tCFFvINteCUqXThkoJYbu/HyCPZzATCTIxcVpM8Q+yV92cM
         R6pg==
X-Gm-Message-State: AOAM5316bmVugw2KcjQQdGaduYsYM3TURQymc15NhHwyr036W/e+G4NI
        UF+7+hx5bjDzE3nGe1c4GT08nw==
X-Google-Smtp-Source: ABdhPJzIytOMrzVGGTOYToBrRlAebpcJAELAOgjt83DUeLFExl4B62ekoRHfgjde+hMzahmrkmqfPw==
X-Received: by 2002:a63:fb49:: with SMTP id w9mr4988534pgj.403.1608312770144;
        Fri, 18 Dec 2020 09:32:50 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:49 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/17] remoteproc: Refactor rproc delete and cdev release path
Date:   Fri, 18 Dec 2020 10:32:28 -0700
Message-Id: <20201218173228.2277032-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_del() and rproc_cdev_release() to take
into account the policy specified in the device tree.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_cdev.c | 18 +++++++++++---
 drivers/remoteproc/remoteproc_core.c | 36 ++++++++++++++++++++++++----
 include/linux/remoteproc.h           |  4 ++++
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index f7645f289563..9b2fb6fbf8e7 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -87,11 +87,23 @@ static long rproc_device_ioctl(struct file *filp, unsigned int ioctl, unsigned l
 static int rproc_cdev_release(struct inode *inode, struct file *filp)
 {
 	struct rproc *rproc = container_of(inode->i_cdev, struct rproc, cdev);
+	int ret;
 
-	if (rproc->cdev_put_on_release && rproc->state == RPROC_RUNNING)
-		rproc_shutdown(rproc);
+	if (!rproc->cdev_put_on_release)
+		return 0;
 
-	return 0;
+	/*
+	 * The application has crashed or is releasing its file handle.  Detach
+	 * or shutdown the remote processor based on the policy specified in the
+	 * DT.  No need to check rproc->state right away, it will be done
+	 * in either rproc_detach() or rproc_shutdown().
+	 */
+	if (rproc->autonomous_on_core_shutdown)
+		ret = rproc_detach(rproc);
+	else
+		ret = rproc_shutdown(rproc);
+
+	return ret;
 }
 
 static const struct file_operations rproc_fops = {
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 2fe42ac7ca89..9f47a4ec0ec6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2254,6 +2254,22 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
 	return 0;
 }
 
+static void rproc_set_automation_flags(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct device_node *np = dev->of_node;
+	bool core_shutdown;
+
+	/*
+	 * When function rproc_cdev_release() or rproc_del() are called and
+	 * the remote processor has been attached to, it will be detached from
+	 * (rather than turned off) if "autonomous-on-core-shutdown is specified
+	 * in the DT.
+	 */
+	core_shutdown = of_property_read_bool(np, "autonomous-on-core-shutdown");
+	rproc->autonomous_on_core_shutdown = core_shutdown;
+}
+
 /**
  * rproc_alloc() - allocate a remote processor handle
  * @dev: the underlying device
@@ -2312,6 +2328,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (rproc_alloc_ops(rproc, ops))
 		goto put_device;
 
+	rproc_set_automation_flags(rproc);
+
 	/* Assign a unique device index and name */
 	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
 	if (rproc->index < 0) {
@@ -2388,15 +2406,25 @@ EXPORT_SYMBOL(rproc_put);
  * of the outstanding reference created by rproc_alloc. To decrement that
  * one last refcount, one still needs to call rproc_free().
  *
- * Returns 0 on success and -EINVAL if @rproc isn't valid.
+ * Returns 0 on success and a negative error code on failure.
  */
 int rproc_del(struct rproc *rproc)
 {
+	int ret;
+
 	if (!rproc)
 		return -EINVAL;
 
-	/* TODO: make sure this works with rproc->power > 1 */
-	rproc_shutdown(rproc);
+	/*
+	 * TODO: make sure this works with rproc->power > 1
+	 *
+	 * No need to check rproc->state right away, it will be done in either
+	 * rproc_detach() or rproc_shutdown().
+	 */
+	if (rproc->autonomous_on_core_shutdown)
+		ret = rproc_detach(rproc);
+	else
+		ret = rproc_shutdown(rproc);
 
 	mutex_lock(&rproc->lock);
 	rproc->state = RPROC_DELETED;
@@ -2415,7 +2443,7 @@ int rproc_del(struct rproc *rproc)
 
 	device_del(&rproc->dev);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(rproc_del);
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index aa5bceb72015..012bebbd324b 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -519,6 +519,9 @@ struct rproc_dump_segment {
  * @nb_vdev: number of vdev currently handled by rproc
  * @char_dev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @autonomous_on_core_shutdown: true if the remote processor should be detached
+ *				 from (rather than turned off) when the remoteproc
+ *				 core goes away.
  */
 struct rproc {
 	struct list_head node;
@@ -557,6 +560,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	bool autonomous_on_core_shutdown;
 };
 
 /**
-- 
2.25.1

