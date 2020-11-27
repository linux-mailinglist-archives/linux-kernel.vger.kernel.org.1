Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A662F2C6313
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgK0K2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgK0K2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:28:48 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44151C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id x22so4662736wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rC09gIrypapoCcwPdjWBhbJDLPz5B+klYBvhYObmCo=;
        b=BdOkXhzTvMgvwNx5koHf2OnRUXW9kZo7WNvQ8uyW44XluPh/WE43HN+vgbx/ZDU5rg
         0gJZWNui8kGNbMKQbNFBmCzboL80eQ8sA0Jr92Ne63JgPas7YBH6WsM434OUyX24Q+7R
         n0rqm3CcO2W9FsuKOnTtM/Q7E8tgGuCMW5orciCTQ+QolUyc3Y3/dwKfCOJ43znqlHFl
         43SVyDspiWV6dnSesdxFYJK9GZ1gPECjVFwLJGjvZTch2WPSTVcXaZsJ4GZloLUAWfAR
         BadKBCag6EJBGE8u35w3Fz+yJ5EosPiUtcTIt6U0iI18Xmwd0m81TmQyw5nLiuDI55X6
         brQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rC09gIrypapoCcwPdjWBhbJDLPz5B+klYBvhYObmCo=;
        b=GijzqlOY1KqkP6XbwxgHL5Im/VXPSS0p0pojHmeJrjsNfDxxu4eXbe8gKF19v7dCea
         WDBaBophAwMZMqJwH9LxnN95r/1QbXGlQfmoBj8U9dGVeuD4wjFsGMNhGUWlQV6wnyHL
         OtDGmr+nrv77/QUysCQ1y5q1siWYtkp4SK2W9g63/2/iOHONiqeMuPi2uQIRMP18/gSA
         XjyHUYVhCnPM4+qnYHBqGog7rrdi4U5lXsrsa/7cSKZW7B8CXJZOeMcJam4u/WK5l4bC
         koVdAwOl78kXOJSRIk9WUlBcwc/FruSQnScS5MSSosGJU+q5LPURVoOj7JrocWkff6Nf
         j5gg==
X-Gm-Message-State: AOAM532GpvLiwH6yj2b7ohTDLGRLAcuLYaeYjHKUbob0IELDW2ay0g9f
        CLwW2th83vePS99ouJbk6F6Fvw==
X-Google-Smtp-Source: ABdhPJxqaT1nXP7JezH/FJoEMYHyqZ6TiU56XwUl0cZc83fTHFn4DyFfKblJzlhDsMNoki8LqXNsVg==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr8145254wmg.21.1606472926908;
        Fri, 27 Nov 2020 02:28:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d8sm14073051wrp.44.2020.11.27.02.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:28:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] nvmem: core: Add support for keepout regions
Date:   Fri, 27 Nov 2020 10:28:34 +0000
Message-Id: <20201127102837.19366-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
References: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

Introduce support into the nvmem core for arrays of register ranges
that should not result in actual device access. For these regions a
constant byte (repeated) is returned instead on read, and writes are
quietly ignored and returned as successful.

This is useful for instance if certain efuse regions are protected
from access by Linux because they contain secret info to another part
of the system (like an integrated modem).

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 153 ++++++++++++++++++++++++++++++++-
 include/linux/nvmem-provider.h |  17 ++++
 2 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a09ff8409f60..177f5bf27c6d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -34,6 +34,8 @@ struct nvmem_device {
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
 	struct list_head	cells;
+	const struct nvmem_keepout *keepout;
+	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	struct gpio_desc	*wp_gpio;
@@ -66,8 +68,8 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
-static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
-			  void *val, size_t bytes)
+static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			    void *val, size_t bytes)
 {
 	if (nvmem->reg_read)
 		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
@@ -75,8 +77,8 @@ static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
-static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
-			   void *val, size_t bytes)
+static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			     void *val, size_t bytes)
 {
 	int ret;
 
@@ -90,6 +92,88 @@ static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
+static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
+				      unsigned int offset, void *val,
+				      size_t bytes, int write)
+{
+
+	unsigned int end = offset + bytes;
+	unsigned int kend, ksize;
+	const struct nvmem_keepout *keepout = nvmem->keepout;
+	const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
+	int rc;
+
+	/*
+	 * Skip all keepouts before the range being accessed.
+	 * Keepouts are sorted.
+	 */
+	while ((keepout < keepoutend) && (keepout->end <= offset))
+		keepout++;
+
+	while ((offset < end) && (keepout < keepoutend)) {
+		/* Access the valid portion before the keepout. */
+		if (offset < keepout->start) {
+			kend = min(end, keepout->start);
+			ksize = kend - offset;
+			if (write)
+				rc = __nvmem_reg_write(nvmem, offset, val, ksize);
+			else
+				rc = __nvmem_reg_read(nvmem, offset, val, ksize);
+
+			if (rc)
+				return rc;
+
+			offset += ksize;
+			val += ksize;
+		}
+
+		/*
+		 * Now we're aligned to the start of this keepout zone. Go
+		 * through it.
+		 */
+		kend = min(end, keepout->end);
+		ksize = kend - offset;
+		if (!write)
+			memset(val, keepout->value, ksize);
+
+		val += ksize;
+		offset += ksize;
+		keepout++;
+	}
+
+	/*
+	 * If we ran out of keepouts but there's still stuff to do, send it
+	 * down directly
+	 */
+	if (offset < end) {
+		ksize = end - offset;
+		if (write)
+			return __nvmem_reg_write(nvmem, offset, val, ksize);
+		else
+			return __nvmem_reg_read(nvmem, offset, val, ksize);
+	}
+
+	return 0;
+}
+
+static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			  void *val, size_t bytes)
+{
+	if (!nvmem->nkeepout)
+		return __nvmem_reg_read(nvmem, offset, val, bytes);
+
+	return nvmem_access_with_keepouts(nvmem, offset, val, bytes, false);
+}
+
+static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			   void *val, size_t bytes)
+{
+	if (!nvmem->nkeepout)
+		return __nvmem_reg_write(nvmem, offset, val, bytes);
+
+	return nvmem_access_with_keepouts(nvmem, offset, val, bytes, true);
+}
+
 #ifdef CONFIG_NVMEM_SYSFS
 static const char * const nvmem_type_str[] = {
 	[NVMEM_TYPE_UNKNOWN] = "Unknown",
@@ -533,6 +617,59 @@ nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
 	return cell;
 }
 
+static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
+{
+	unsigned int cur = 0;
+	const struct nvmem_keepout *keepout = nvmem->keepout;
+	const struct nvmem_keepout *keepoutend = keepout + nvmem->nkeepout;
+
+	while (keepout < keepoutend) {
+		/* Ensure keepouts are sorted and don't overlap. */
+		if (keepout->start < cur) {
+			dev_err(&nvmem->dev,
+				"Keepout regions aren't sorted or overlap.\n");
+
+			return -ERANGE;
+		}
+
+		if (keepout->end < keepout->start) {
+			dev_err(&nvmem->dev,
+				"Invalid keepout region.\n");
+
+			return -EINVAL;
+		}
+
+		/*
+		 * Validate keepouts (and holes between) don't violate
+		 * word_size constraints.
+		 */
+		if ((keepout->end - keepout->start < nvmem->word_size) ||
+		    ((keepout->start != cur) &&
+		     (keepout->start - cur < nvmem->word_size))) {
+
+			dev_err(&nvmem->dev,
+				"Keepout regions violate word_size constraints.\n");
+
+			return -ERANGE;
+		}
+
+		/* Validate keepouts don't violate stride (alignment). */
+		if (!IS_ALIGNED(keepout->start, nvmem->stride) ||
+		    !IS_ALIGNED(keepout->end, nvmem->stride)) {
+
+			dev_err(&nvmem->dev,
+				"Keepout regions violate stride.\n");
+
+			return -EINVAL;
+		}
+
+		cur = keepout->end;
+		keepout++;
+	}
+
+	return 0;
+}
+
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
 	struct device_node *parent, *child;
@@ -647,6 +784,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->keepout = config->keepout;
+	nvmem->nkeepout = config->nkeepout;
 	if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
@@ -671,6 +810,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->dev.groups = nvmem_dev_groups;
 #endif
 
+	if (nvmem->nkeepout) {
+		rval = nvmem_validate_keepouts(nvmem);
+		if (rval)
+			goto err_put_device;
+	}
+
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_register(&nvmem->dev);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 06409a6c40bc..e162b757b6d5 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -30,6 +30,19 @@ enum nvmem_type {
 #define NVMEM_DEVID_NONE	(-1)
 #define NVMEM_DEVID_AUTO	(-2)
 
+/**
+ * struct nvmem_keepout - NVMEM register keepout range.
+ *
+ * @start:	The first byte offset to avoid.
+ * @end:	One beyond the last byte offset to avoid.
+ * @value:	The byte to fill reads with for this region.
+ */
+struct nvmem_keepout {
+	unsigned int start;
+	unsigned int end;
+	unsigned char value;
+};
+
 /**
  * struct nvmem_config - NVMEM device configuration
  *
@@ -39,6 +52,8 @@ enum nvmem_type {
  * @owner:	Pointer to exporter module. Used for refcounting.
  * @cells:	Optional array of pre-defined NVMEM cells.
  * @ncells:	Number of elements in cells.
+ * @keepout:	Optional array of keepout ranges (sorted ascending by start).
+ * @nkeepout:	Number of elements in the keepout array.
  * @type:	Type of the nvmem storage
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
@@ -66,6 +81,8 @@ struct nvmem_config {
 	struct gpio_desc	*wp_gpio;
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
+	const struct nvmem_keepout *keepout;
+	unsigned int		nkeepout;
 	enum nvmem_type		type;
 	bool			read_only;
 	bool			root_only;
-- 
2.21.0

