Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B692CA42C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391163AbgLANpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391135AbgLANpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:45:02 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD34C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:52 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v21so1136901plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DwCQ27nNXwfD9t5ZQW62DZJZaYrd0rxE1o52EO0bsI=;
        b=Mg4In0e76C/nyOIQGBgSdZl64D3A5Tu74H2xv0kJ901QHWVsL5TL8tVTtZg/sH4otm
         h08twifw/lCN9tVt0w9xD2MFXAh+K1zUtSH8GfB1vti2Dx9NcjBDFZSKfHYscKwxCRye
         JrTYcYc5xcZ1au/5IwyjW9PTMsc+zVXnNnUwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DwCQ27nNXwfD9t5ZQW62DZJZaYrd0rxE1o52EO0bsI=;
        b=bSOxCeAWXpigtrPRYE8vizLTAtkeakb0RjicIgOzJWnhZEd89Fy3yHpSB8tTZ+VR9+
         mMmzoYr9/C9P50P1+qAVfVuB+xhSzKg7yUun19xAL96O/Q8YPrdla7hLMWgxKwVrtjtV
         2imgp0ajjG3ZcIVPIg4yjc4BJeoNn3GCJG6mrKmL/UX33Q1rFaaBFpvMO9pVNIaFImkI
         P+4tJYLNeAd97xn23kWT1MQ2KBTFm48fKGhXoWmhkMf9k+6uOY63PKTFeLqZh64Wfj3i
         lEbPx0QrVNkJuv3meA9oXZdPNyH0yOe0u+EpyZqd99nVPoBmaWZdqPM13nowqcJIR8gr
         MWHA==
X-Gm-Message-State: AOAM530Tj5z+Pm5bZHUF1009NmJqubahv0ZTrqY/Afe6qrnUs2FRzLa1
        XbwXs7A4UgVyIsn7QQ0WtU/bjw==
X-Google-Smtp-Source: ABdhPJxpaiILhXu389YSGSADviATIWQrbxVZK/JiCYSOrTtXFyfERdUSo5vjfna+xlbCHCirxfOyNw==
X-Received: by 2002:a17:90a:ee8c:: with SMTP id i12mr2774956pjz.33.1606830231857;
        Tue, 01 Dec 2020 05:43:51 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:51 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 05/10] ARM: mstar: Add common dtsi for SSD201/SSD202D
Date:   Tue,  1 Dec 2020 22:43:25 +0900
Message-Id: <20201201134330.3037007-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSD201 and SSD202D are basically the same chip with a different DDR die
packaged (64MB DDR2 or 128MB DDR3).

This patch adds a shared dtsi for the common parts of these chips like
gpio, pinctrl etc.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
new file mode 100644
index 000000000000..0811220f0a79
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mstar-infinity2m.dtsi"
-- 
2.29.2

