Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9E2DE834
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgLRRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732868AbgLRRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:34:28 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12531C061A4E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c22so1726754pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vutdwpz2dUDTweVlb30ERc0HCxLnN2+/Hjzz5Y0E1bI=;
        b=BKXSrxbXnh6d2zRd2aZGKoJTdugQUWnvySJCEm8scXWnxe9+TXu4/81oD7MQ7cAa17
         gBO+juB3m0O1fJjMKmtwbmlZgSx+e0JTk0c0HSQxxX0PtJqu1sIPMrzlHOrooOtCcSlV
         jBWWe3U8wAgF2HAAPUjjDl3dn+tkcgA2TspNkWMz0iMrwWGEqpVYwi9SA/2ycdhEX7EB
         ZroR/ixb5Fa5kmAWWEgaoiZgosqZ7gUGLmayhcP9HTnP7Q9Xz3hklPJzJNnEk/sy635S
         mZImmX9q2aaGbnoKtTFr/Lu2XDsdDRBFlAnGqEILryiXq7xAUF5u33LS7NVbe1lAjHJ7
         TgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vutdwpz2dUDTweVlb30ERc0HCxLnN2+/Hjzz5Y0E1bI=;
        b=nyxPCF9+6WY741O/mblQsHsJqNxK9Waw9+iz3uzDju/8Ry6FOgM2ISGZJrxJRBFPkI
         ThvPoJAodFfPFfikSqETlfed3tQ+HwC/NEwGmZfC25Q1zuTKp80jeDjL3wUE/4p6fu0G
         +dCxSAjGUGNXx/778/S2sESe43euCP0e5Z5L9UmCAGbT7zcbnxWemrR7fQ7VbkgVtICL
         ZhEMuXV3JcuVLUdaODOnucVXv1SHXAogi5J/gF+tvw5NodMp1SZJePzSsZzB/j7DOm8h
         8fX0Gxez+7QW51cvcFdmd+tD38t50fzij7wu7Rqgw6q/CqgN96fEDler7S5iJirC4vjI
         RxZQ==
X-Gm-Message-State: AOAM532aipLQidTl2+Pg4HV4ikHQwYtyuOYw3vfqGUHOv34elHQuzZqJ
        O/pL242FhXJKNctlVNvHHYQwug==
X-Google-Smtp-Source: ABdhPJyoSPdQNxv0nHKlET++OnaWfTpvXjLCfYQZndPk5Wlb1V3YDItJACWOCJnUBVrQbDsT25+Nuw==
X-Received: by 2002:a65:4c4b:: with SMTP id l11mr1097792pgr.177.1608312767705;
        Fri, 18 Dec 2020 09:32:47 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:46 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/17] remoteproc: Properly deal with a start request when attached
Date:   Fri, 18 Dec 2020 10:32:26 -0700
Message-Id: <20201218173228.2277032-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch takes into account scenarios where a remote processor
has been attached to when receiving a "start" command from sysfs.

As with the "running" case, the command can't be carried out if the
remote processor is already in operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 3 ++-
 drivers/remoteproc/remoteproc_sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index d06f8d4919c7..61541bc7d26c 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -32,7 +32,8 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 		return -EFAULT;
 
 	if (!strncmp(cmd, "start", len)) {
-		if (rproc->state == RPROC_RUNNING)
+		if (rproc->state == RPROC_RUNNING ||
+		    rproc->state == RPROC_ATTACHED)
 			return -EBUSY;
 
 		ret = rproc_boot(rproc);
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 96751c087585..298052c9d068 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -223,7 +223,8 @@ static ssize_t state_store(struct device *dev,
 	int ret = 0;
 
 	if (sysfs_streq(buf, "start")) {
-		if (rproc->state == RPROC_RUNNING)
+		if (rproc->state == RPROC_RUNNING ||
+		    rproc->state == RPROC_ATTACHED)
 			return -EBUSY;
 
 		ret = rproc_boot(rproc);
-- 
2.25.1

