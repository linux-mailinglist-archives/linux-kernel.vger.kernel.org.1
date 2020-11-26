Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DD2C5D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391724AbgKZVHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391556AbgKZVGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:54 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48649C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:53 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o4so306219pgj.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9VIidoVcdPT6TG8AcEB1S8vzNlv34NcmaK246Tinnw=;
        b=ih87xMcIyK/CenH6KwgVXhbvvw8tPezLD0ZG78w3yD9cCn0wMR9rCfgslaLTF9Ulq/
         tYVJG/TSS+V1TuxLocTHO8Vh8OAKEkV57y626AR0S2f98gKiWROj5QlKe88du0JyXGrE
         3CcwCYNDqO+LdcgUR6QwSPgDyrZqQmmFtzydYY1GEuXeE5tYiijDI4x3bu4nAmdsaTTt
         FqSdF+lzXabkuDga5u45z9XBw9N39Nz65+7zuEsOExr3IrkC3Seod8e2cg/epPbPaQN8
         SZXCv49SrMGqa+5xI7Qazg+ajGsOaFUBFi/kWoIPsnvGVGDJWACK/iiWli7UmaWOzRMD
         nM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9VIidoVcdPT6TG8AcEB1S8vzNlv34NcmaK246Tinnw=;
        b=njGRouEsvRAzSdszzg8TPeLlOWJBhzzjXyT08I5MtlxzsZZRiyCAucVL/2a+fAOkc/
         nbrNyCDqDKw0fUpVF2TRQrQKDJbOU55y+aCnZDZsg5wx5ZJiuxnf0vv6r95AccfuVp2g
         vKYu4n6080wTZcJVDl5mBCoj/wZUf5IgY4TST4O8XUIqK0lA7S5hETqrjTr3mybVYm7l
         yW70pBjO2uYa/eJd1d3/r4svSQdL3TO7k3uSpDdXoPbuHJcfwLQl+BZxiN9k/r+kAkfW
         IC2bsSJoZh2KW6cxQ7wExzVDWfeGZUfW0HdDt4e0WIl3jOO8NzHXMKZ12EgetUd15VRo
         yi9g==
X-Gm-Message-State: AOAM532RAuZVM1b5DztLA2NjjEQndqEJeobSStVKgwTNbVzBmnqxj1jW
        4IgQTFd5c21yVMdVY2FtvZdiHw==
X-Google-Smtp-Source: ABdhPJxjsck9xcTSumLUyPKiMxiLRjKVGzc1w5XgLDB6QXfXHxvTau2XHTPeZAWZIS5cf9Se1VNi3w==
X-Received: by 2002:aa7:954e:0:b029:198:1a04:36a7 with SMTP id w14-20020aa7954e0000b02901981a0436a7mr4198372pfq.10.1606424812850;
        Thu, 26 Nov 2020 13:06:52 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 09/15] remoteproc: Introduce function rproc_detach()
Date:   Thu, 26 Nov 2020 14:06:36 -0700
Message-Id: <20201126210642.897302-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function rproc_detach() to enable the remoteproc
core to release the resources associated with a remote processor
without stopping its operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_core.c | 65 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  1 +
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 928b3f975798..f5adf05762e9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1667,7 +1667,7 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 /*
  * __rproc_detach(): Does the opposite of rproc_attach()
  */
-static int __maybe_unused __rproc_detach(struct rproc *rproc)
+static int __rproc_detach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1910,6 +1910,69 @@ void rproc_shutdown(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+/**
+ * rproc_detach() - Detach the remote processor from the
+ * remoteproc core
+ *
+ * @rproc: the remote processor
+ *
+ * Detach a remote processor (previously attached to with rproc_actuate()).
+ *
+ * In case @rproc is still being used by an additional user(s), then
+ * this function will just decrement the power refcount and exit,
+ * without disconnecting the device.
+ *
+ * Function rproc_detach() calls __rproc_detach() in order to let a remote
+ * processor know that services provided by the application processor are
+ * no longer available.  From there it should be possible to remove the
+ * platform driver and even power cycle the application processor (if the HW
+ * supports it) without needing to switch off the remote processor.
+ */
+int rproc_detach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret) {
+		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
+		return ret;
+	}
+
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* if the remote proc is still needed, bail out */
+	if (!atomic_dec_and_test(&rproc->power)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = __rproc_detach(rproc);
+	if (ret) {
+		atomic_inc(&rproc->power);
+		goto out;
+	}
+
+	/* clean up all acquired resources */
+	rproc_resource_cleanup(rproc);
+
+	rproc_disable_iommu(rproc);
+
+	/*
+	 * Set the remote processor's table pointer to NULL.  Since mapping
+	 * of the resource table to a virtual address is done in the platform
+	 * driver, unmapping should also be done there.
+	 */
+	rproc->table_ptr = NULL;
+out:
+	mutex_unlock(&rproc->lock);
+	return ret;
+}
+EXPORT_SYMBOL(rproc_detach);
+
 /**
  * rproc_get_by_phandle() - find a remote processor by phandle
  * @phandle: phandle to the rproc
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index da15b77583d3..329c1c071dcf 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -656,6 +656,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
 
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
+int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
-- 
2.25.1

