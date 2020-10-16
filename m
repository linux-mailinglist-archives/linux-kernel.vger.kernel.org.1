Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5E290C42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393119AbgJPT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393112AbgJPT1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:27:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2EC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so2012308pgt.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cY/v3p9J10f7KUjoM4f0gEPttA6+zenkC9rxUhPyGg=;
        b=I7aH50sE6ddlSDFgaj6HZM7ZgXO8zSXrsKcFgoFk1NGSgNvf8xMd6cwvwnUZ8VMBpV
         hYjmQMvaUqsuNqHibh1DcKjLeuW8LWPJT0wFqIofwxoeusUTDUP4zKAHhu24htSp4qiG
         ce3h0tLb95s/0Z7vkgiXXxui+FzDqMTHURfq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cY/v3p9J10f7KUjoM4f0gEPttA6+zenkC9rxUhPyGg=;
        b=AYZdt7XgsV/YDh3VpFpASUyTuNojWeaEs+edc5elJ1I3cve9K9z2gqy3XXcJgVShp7
         ufhOgR/zF/cpSujrwH/WjUgZ/qQ2d52nSt2p/CxoFxPkNKazMVZ+G6mJhonStpNhy6My
         eOxXm0ZqLUSDRl3IqpNiSO17ntvtHe99ItAv7CluiFp4wtEk3Gqe3rAM5uh6R5NtpuZD
         OSb2I3I+u+juGxE3Yd2Qj0gqPE99yjfFgKKiX08PRkfIIGBwAMUDt0ZZTbw1B+m0m4c/
         /oeF68ESaZhOs53P8eJrvCKaJGahv963+JaWM0RHR2IabmsAxRZNTxTFNUi/TTgzE5uu
         hJ6A==
X-Gm-Message-State: AOAM530n9TvmXmA2MpnoUITFGRQB4GXj41ac9iGs/UcK5XwMdxe01tEJ
        p8DUMEiRRawZou6Z/13regC3Hc1GEPcZkg==
X-Google-Smtp-Source: ABdhPJz8wWmYP3E2rOItnIy9NRf7aQW4x938a7FeRWKfOQPDiO7TmRx/m6pWKlSQnG96yx68LA+IgA==
X-Received: by 2002:a63:de56:: with SMTP id y22mr4525046pgi.166.1602876453946;
        Fri, 16 Oct 2020 12:27:33 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id lb13sm3566622pjb.5.2020.10.16.12.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Oct 2020 12:27:33 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] nvmem: core: Add support for keepout regions
Date:   Fri, 16 Oct 2020 12:26:53 -0700
Message-Id: <20201016122559.v2.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016192654.32610-1-evgreen@chromium.org>
References: <20201016192654.32610-1-evgreen@chromium.org>
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

Changes in v2:
 - Introduced keepout regions into the core (Srini)

 drivers/nvmem/core.c           | 95 ++++++++++++++++++++++++++++++++--
 include/linux/nvmem-provider.h | 17 ++++++
 2 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a09ff8409f600..f7819c57f8828 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -19,6 +19,9 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
 struct nvmem_device {
 	struct module		*owner;
 	struct device		dev;
@@ -34,6 +37,8 @@ struct nvmem_device {
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
 	struct list_head	cells;
+	const struct nvmem_keepout *keepout;
+	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	struct gpio_desc	*wp_gpio;
@@ -66,8 +71,8 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
-static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
-			  void *val, size_t bytes)
+static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			    void *val, size_t bytes)
 {
 	if (nvmem->reg_read)
 		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
@@ -75,8 +80,8 @@ static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
-static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
-			   void *val, size_t bytes)
+static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			     void *val, size_t bytes)
 {
 	int ret;
 
@@ -90,6 +95,86 @@ static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
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
+	/* Skip everything before the range being accessed */
+	while ((keepout < keepoutend) && (keepout->end <= offset))
+		keepout++;
+
+	while ((offset < end) && (keepout < keepoutend)) {
+
+		/* Access the valid portion before the keepout. */
+		if (offset < keepout->start) {
+			kend = MIN(end, keepout->start);
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
+		kend = MIN(end, keepout->end);
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
@@ -647,6 +732,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->keepout = config->keepout;
+	nvmem->nkeepout = config->nkeepout;
 	if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
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

