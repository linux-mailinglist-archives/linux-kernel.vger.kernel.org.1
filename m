Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623F32C5D55
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391755AbgKZVHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391691AbgKZVG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:59 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C32C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so2639958pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZKEoNhgpUCxk0BJFPhN8SyKdDsMxIN4bfJcnaCrMrQ=;
        b=pBsQ3pXncC41Q83qq1u3ofxVdrDRk/6O4wPSti+nnYcmiF/ZOJ+H5vqGvPmxtPWizc
         8y3XwipOESsOriEGeSxOxbflSMQm4o+Zmj2Tk14XtK/OJ7+4S3LV6hNbruVNDcsVejL0
         3I5CJZZVpoIcl5kia7yH3D5fKKpBOVfAHD5gSGFglaYzgTr6wT+ol0kdNyBvyKzWULPA
         1zRpvcdUbIxHbgCWet60vwfVRlsnB0mCIl9fX6QZcSxbDEg2EytQI9J75p2Sg4/y79NQ
         fmRGRnv6MkGS1+KhY6nNhQJVg5BiNov4S0XYjDOjoH/haen8AIlWClVRPfxi/mft/PB+
         GKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZKEoNhgpUCxk0BJFPhN8SyKdDsMxIN4bfJcnaCrMrQ=;
        b=Cv5vhlVLQXdzKBaO0HDPv9ryaGGMd6WXzacd63eyR4pNSmJx0kRvk6GUOYUC7DlH0h
         vIq/hN86DJ9jnfc3+jQ5xeBuB3JVOpMn7L2jQbrX80tRhYKoDFX9AvNNg5cRmkYJrDSd
         2xK76pvNrR3q0JaUz/9bfQVfkiA8iVQ3HqqaKZBh5rc/SdWgiyR0r2HHfpLExgRLA24d
         eUn1pylzCN1PpB0ssRKQQ2H+nKvrg5YgLUM7VShs3XTcPT0AZFLZamecNpgjlt7kl4uU
         eXmTNOeYmoulxEx9QdWpg5GCWcBzGSF6Vc1rdfsLCAIITZoULKZCaKaaYlVQ1spRUIfg
         sXQQ==
X-Gm-Message-State: AOAM530FS0e6GYHyHixNJhCxtNt/tnol14g2ejtdZGhZQ5CNXJ+qgBVO
        29oP352y/fRXABrK/b/RZ8B1Iw==
X-Google-Smtp-Source: ABdhPJx3to5KO+RDOFbdZsmC8iWcc6Tc9rvKooHi7wvnqs33TJvUOiEWWcUokQuvgrRVA0RKL78vtA==
X-Received: by 2002:a62:fc4a:0:b029:19a:ad58:b015 with SMTP id e71-20020a62fc4a0000b029019aad58b015mr1116046pfh.77.1606424818052;
        Thu, 26 Nov 2020 13:06:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:57 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 14/15] remoteproc: Properly deal with detach request
Date:   Thu, 26 Nov 2020 14:06:41 -0700
Message-Id: <20201126210642.897302-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached to or booted by the remoteproc core.  For
that to happen a rproc::ops::detach() operation need to be
available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 6 ++++++
 drivers/remoteproc/remoteproc_sysfs.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 61541bc7d26c..f7645f289563 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -43,6 +43,12 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (!strncmp(cmd, "detach", len)) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 7d281cfe3e03..5a239df5877e 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -207,6 +207,12 @@ static ssize_t state_store(struct device *dev,
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (sysfs_streq(buf, "detach")) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

