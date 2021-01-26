Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF395303CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392617AbhAZMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392177AbhAZMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:21:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A2C061D73
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:21:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q7so16212455wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGay3cWIFfTGXVJgJYEz2HA9Nfskw8Lpr3d/5Y01BQU=;
        b=Kpx6+TDBpZzINbQVksCtDf0edv2+6ZBEuae37HH5PL1YKkPF3mQB7mjA4USFVymwI0
         1WGoNA9amxJB5Ky+p6RMrPsOp4azcGY8T20WkQDoZJiekOWl95IcAU6ouaPQZCv2UvoU
         O511ccJ+jt3UaTfWSfz/jU14m2zlLErH32Aki/sGSdam1WPFaFrp9tCJsInJruPHaiLI
         rUtK4G08vKSV1UP3oIp21ccrVcqap1x9XWz88akff5f1rZrI5u19eo2AinJ5Cia16Wd8
         hZtvQMdr3W1Ina2LkpIg6smf7yW6M9D1yDWSqTfS1a37OGS+cFrkiTX3imlgm6GeItvG
         IS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGay3cWIFfTGXVJgJYEz2HA9Nfskw8Lpr3d/5Y01BQU=;
        b=X9FK00frynepeZFPs9A4pkZoFq14GbiJ+EkTawm0twoXwg++tyHLNGcBki80rsMWAE
         vCRYtZsz8tLm4jwglZ/dz6zPFvrIiYcFVDFLKPKcbhVNiBEmUma5a7J4K3enA8Mc3fW/
         4AytiLDSaYaW7LJ0hI5AneYiIUO+vSYk9knc6zFJXAj4PWawLfbvXhU2w72xxo0sxac/
         qCHx/PuZYRkRR5bY9CDDJ001u/rYy8lHjotePioe2OnSZmKqRj51E2AweDAUL/hM0ITE
         UuxisA/TQ/LIx3luR8ceri9HGSv0uIMvPZpR2hrMTf+7onjSmOSUZDG4rpP/n2IIOtej
         Do3A==
X-Gm-Message-State: AOAM531Bh/hKREnIld49xjDO7sYvEVxDdMg9X+9sEWUKKlian2e4Z6AM
        yBR5C7Kur3bVpf8azFox0XAXmQ==
X-Google-Smtp-Source: ABdhPJzWuBSc18W8U//lbfGPeHuIY8wsRVGuX5eWxpbwLQ/2vTe2Y4EuBN6eZ3iPZmuNxCp5glRInw==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr5841474wrl.249.1611663659997;
        Tue, 26 Jan 2021 04:20:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o124sm3218908wmb.5.2021.01.26.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:20:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/2] ASoC: soc-component: add snd_soc_component_read/write_field()
Date:   Tue, 26 Jan 2021 12:20:19 +0000
Message-Id: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's often the case that we would write or read a particular field
in register. With the current soc_component apis, reading a particular
field in register would involve first read the register and then
perform shift operations.

Ex:
to read from a field mask of 0xf0

	val = snd_soc_component_read(component, reg);
	field = ((val & 0xf0) >> 0x4);

This is sometimes prone to errors and code become less readable!

With this new api we could just do
	field = snd_soc_component_read_field(component, reg, 0xf0);

this makes it bit simple, easy to write and less error prone!

This also applies to writing!

There are various places in kernel which provides such field interfaces
however soc_component seems to be missing this.

This patch is inspired by FIELD_GET/FIELD_PREP macros in include/linux/bitfield.h

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-component.h |  6 ++++
 sound/soc/soc-component.c     | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 0bce41fefd30..5b47768222b7 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -353,6 +353,12 @@ int snd_soc_component_test_bits(struct snd_soc_component *component,
 				unsigned int reg, unsigned int mask,
 				unsigned int value);
 
+unsigned int snd_soc_component_read_field(struct snd_soc_component *component,
+					  unsigned int reg, unsigned int mask);
+int snd_soc_component_write_field(struct snd_soc_component *component,
+				  unsigned int reg, unsigned int mask,
+				  unsigned int val);
+
 /* component wide operations */
 int snd_soc_component_set_sysclk(struct snd_soc_component *component,
 				 int clk_id, int source,
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 760523382f3c..6bdfc6f61ed6 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -12,6 +12,7 @@
 #include <linux/pm_runtime.h>
 #include <sound/soc.h>
 
+#define __soc_component_field_shift(x) (__builtin_ffs(x) - 1)
 #define soc_component_ret(dai, ret) _soc_component_ret(dai, __func__, ret)
 static inline int _soc_component_ret(struct snd_soc_component *component,
 				     const char *func, int ret)
@@ -839,6 +840,67 @@ int snd_soc_component_update_bits_async(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_update_bits_async);
 
+/**
+ * snd_soc_component_read_field() - Read register field value
+ * @component: Component to read from
+ * @reg: Register to read
+ * @mask: mask of the register field
+ *
+ * Return: read value of register field.
+ */
+unsigned int snd_soc_component_read_field(struct snd_soc_component *component,
+					  unsigned int reg, unsigned int mask)
+{
+	unsigned int val;
+
+	mutex_lock(&component->io_mutex);
+	val = soc_component_read_no_lock(component, reg);
+	if (mask)
+		val = (val & mask) >> __soc_component_field_shift(mask);
+	mutex_unlock(&component->io_mutex);
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_read_field);
+
+/**
+ * snd_soc_component_write_field() - write to register field
+ * @component: Component to write to
+ * @reg: Register to write
+ * @mask: mask of the register field to update
+ * @val: value of the field to write
+ *
+ * Return: 1 for change, otherwise 0.
+ */
+int snd_soc_component_write_field(struct snd_soc_component *component,
+				  unsigned int reg, unsigned int mask,
+				  unsigned int val)
+{
+	unsigned int old, new;
+	int ret = 0;
+	bool change;
+
+	if (!mask)
+		return false;
+
+	mutex_lock(&component->io_mutex);
+
+	old = soc_component_read_no_lock(component, reg);
+
+	val = val << __soc_component_field_shift(mask);
+
+	new = (old & ~mask) | (val & mask);
+
+	change = old != new;
+	if (change)
+		ret = soc_component_write_no_lock(component, reg, new);
+
+	mutex_unlock(&component->io_mutex);
+
+	return change;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_write_field);
+
 /**
  * snd_soc_component_async_complete() - Ensure asynchronous I/O has completed
  * @component: Component for which to wait
-- 
2.21.0

