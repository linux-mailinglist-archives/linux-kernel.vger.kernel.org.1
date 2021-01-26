Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB472304E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbhA0Aau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390249AbhAZRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:18:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21CC0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:17:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c127so3420134wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5oZwAs5jCwM5rUFoGrWthIvQJwNmDYK0KvJ2Ndn+HsM=;
        b=Cp91oKUP1tX+yAlvX9OrtyrtPje0Wobzs4UtSdUeNxDmEB9Ex9kKbG5v+lVbzUhmqI
         Nu47q1PRX5EQW1VKSsk2C3jHPAhSNGxn1CF/ahi9dGS2V2/m8DQ6vJ8jbL3elSfnFmvH
         TFeuoGf+jOcpaK2WUWXBXLijUWchUmqJKPSFxiu7V+Q/XHR6afbTooh+yOjRgUkIN9hB
         MgtcDR9UfKN4O7aVi1elNxLKY4ZKe1VsVs4mJgzaGP6TbG81tuSsWBggeHR/2haUyTLu
         eQb7J56zv+kY8D52EZYOyiDDgElfZ40wXkGSETJ6FDxktUb8QTPxWQ4oRrGtZZ+jesFq
         6uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5oZwAs5jCwM5rUFoGrWthIvQJwNmDYK0KvJ2Ndn+HsM=;
        b=crNQxFrCiKKFibZHtLE+SuWZICa/BFLwwcCqjAX4U+SkvbzrgNWFVNYadENeXn1AbR
         DG1uXbwZDBGZC919mLhGqnWm0p2/ebKXSUikxLFTBC/waTF+Ib0q1nt9ItFRN2ZNL+dR
         K46TgYXJKG32aupy+XAjHHHF03O16HLxJG64AihxltY0cizFzEtgDxdbTb9piFuTKcAS
         bd/SDFDmCX3/zCSTQLPFjSlNFAWwKnNBHJS1dzX3Oq/as492WcqwrSrnI6RhT1i1bZUr
         c5vAFF0hNNACuAReLt9nSFi3zu5VyhHEIjn/8jRl9+KGGR8legptkfHyM4hCpdEglHqb
         YtmA==
X-Gm-Message-State: AOAM533pRN9WGO2G8JrHepO0sMW+jS6x6AXeTMe6b3jAr2SqspPDmraN
        /7rgHLMcLKtRHXXQz3ccqj52ySwB1kNBCw==
X-Google-Smtp-Source: ABdhPJxjzhd4m765kvrf9puMDcTM4rkJyWs9c9NmoD0a9K9WDqvgpZ7n0ROVbkrEXHlC0OppmlqlPQ==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr695835wml.62.1611681473362;
        Tue, 26 Jan 2021 09:17:53 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d85sm5059157wmd.2.2021.01.26.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 09:17:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] ASoC: soc-component: add snd_soc_component_read/write_field()
Date:   Tue, 26 Jan 2021 17:17:48 +0000
Message-Id: <20210126171749.1863-1-srinivas.kandagatla@linaro.org>
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

Changes since v1:
	- removed open coding and call read and update_bits
	- made soc_component_field_shift an inline function

 include/sound/soc-component.h |  6 ++++
 sound/soc/soc-component.c     | 53 +++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

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
index 760523382f3c..361a79d655e3 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -34,6 +34,18 @@ static inline int _soc_component_ret(struct snd_soc_component *component,
 	return ret;
 }
 
+static inline int soc_component_field_shift(struct snd_soc_component *component,
+					    unsigned int mask)
+{
+	if (!mask) {
+		dev_err(component->dev,	"ASoC: error field mask is zero for %s\n",
+			component->name);
+		return 0;
+	}
+
+	return (__builtin_ffs(mask) - 1);
+}
+
 /*
  * We might want to check substream by using list.
  * In such case, we can update these macros.
@@ -839,6 +851,47 @@ int snd_soc_component_update_bits_async(struct snd_soc_component *component,
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
+	val = snd_soc_component_read(component, reg);
+
+	val = (val & mask) >> soc_component_field_shift(component, mask);
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
+
+	val = (val << soc_component_field_shift(component, mask)) & mask;
+
+	return snd_soc_component_update_bits(component, reg, mask, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_write_field);
+
 /**
  * snd_soc_component_async_complete() - Ensure asynchronous I/O has completed
  * @component: Component for which to wait
-- 
2.21.0

