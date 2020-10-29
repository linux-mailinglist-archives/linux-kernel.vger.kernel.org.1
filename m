Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072A529DC69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbgJ2AaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgJ2A2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:28:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19126C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so456237pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9P3LYRnQCwSsA8ipP3wI9rmuLwMziJAr5rY0KzvUCw=;
        b=fv0MGkizxYhctYpf834e4HGandZn5BwqxNoyRzwZuNUoMkS9Rb8+Sm7v6ynTu2i89w
         Ny+fU4GOn12nSgkEhqEDZJ/iEKouLEkeDW0Vy5ULqI+1azkMCRukyEM5EXhnXUv36ZH9
         FgTNqIhDQNyeoBiNIEivk/lnUbV+/nESOdPVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9P3LYRnQCwSsA8ipP3wI9rmuLwMziJAr5rY0KzvUCw=;
        b=AC6bFcbFbMPbxaHZpLWcvLXpJR7JsNEVvqbOsHn/yQJdxsrTe69gtLvdq1IrWE4Ku7
         jPRFEEVhYj05C8joI7/z75qD1wsdZ5Hj3uFRF9SNYj9lswvrpnHATMPKxyu3BAU7Swfa
         vGNi5LRt/caNlppWoZe12i2Sd/6l+JU7mvj9Z/tTPWVpAbtnQ4DAkN1l10IHUJwaHPIo
         YoHMycX1IsgmVAst/iWgbbMv2pdPgAoyEXr79ti8SoNI0ZlBlIOePWk/7YQXe3i2UBJN
         fTYcSmEyMZ/BnU6/l7hx+XZuCbPi8O4RsD7JNY0o9CN8B032ugYTOLm44G96S+5/e/nF
         FtJQ==
X-Gm-Message-State: AOAM533FsrCLpA9VvAX5UnVJiCFJSJDGwF8kIG803/PZ0GSRFProp3Zl
        WolK6hqCw1QMQTITcr9IwDZlsg==
X-Google-Smtp-Source: ABdhPJy9JOXsjTs8WQNSiIiwi4pm99+8iXtsNnS8m4HESwD1hcddM5UwQtqFVjMfzY8ekna7APJnUA==
X-Received: by 2002:a17:902:8341:b029:d4:e3fa:e464 with SMTP id z1-20020a1709028341b02900d4e3fae464mr1549964pln.66.1603931328587;
        Wed, 28 Oct 2020 17:28:48 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id u13sm743625pfl.162.2020.10.28.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Oct 2020 17:28:48 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] nvmem: core: Add support for keepout regions
Date:   Wed, 28 Oct 2020 17:28:26 -0700
Message-Id: <20201028172737.v3.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029002827.1729915-1-evgreen@chromium.org>
References: <20201029002827.1729915-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support into the nvmem core for arrays of register ranges
that should not result in actual device access. For these regions a
constant byte (repeated) is returned instead on read, and writes are
quietly ignored and returned as successful.

This is useful for instance if certain efuse regions are protected
from access by Linux because they contain secret info to another part
of the system (like an integrated modem).

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Use min()/max() macros instead of defining my own (Doug)
 - Comment changes to indicate sorting (Doug)
 - Add function to validate keepouts are proper (Doug)

Changes in v2:
 - Introduced keepout regions into the core (Srini)

 drivers/nvmem/core.c           | 153 ++++++++++++++++++++++++++++++++-
 include/linux/nvmem-provider.h |  17 ++++
 2 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a09ff8409f600..177f5bf27c6d5 100644
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
index 06409a6c40bcb..e162b757b6d54 100644
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
2.26.2

