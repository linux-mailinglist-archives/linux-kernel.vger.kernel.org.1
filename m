Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFECD272108
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIUK2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgIUK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C75C061755;
        Mon, 21 Sep 2020 03:27:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so12132354wrn.6;
        Mon, 21 Sep 2020 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=a4aevM37+SprF1bLM94DNefZwrVfG7PKjwoGEHWOWnCkjx1KIJclErcP52rGECmy2u
         0NEE9ml8OGLWkm/3AMJ7grlyWFa/vsQq3OsnjazTLMkSJgnLJrXOPst9Wu4m8u4HdNj/
         whepRegy+FZ3ni/+MFUwgnhQB1AFtwcMKNueTTkcEUfFOjjnRGjq+Td49w9ZwQ/ZQgbn
         WKEZ07BSLGds6GmulIw24MmMvQFUIIn1SfOHralDmXO3duE1dKrfOSTgbAiC1i3GRdK1
         agG1yrHxpyBfkg1+NfkVM2qNag6DuILrjoR2wVFUl09XeYSrbcPYovrD974+SaBj+udQ
         FOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=rX4SJZxIaH8EgAk7MVS8KjoZV1KQRw6O+a6a4e9OrFj5ORuX4cNlevsRxC1GiPpI5T
         ju8eAB/g+9CWSwc8JSEjZ+7Fq2Ajp0m9FUZ/W0vjZjjfjLddbc2KBSXJNISVousczO/h
         QsJ6sWjNPkWc68qMo4GAh8qWq2YpQyLejiPaFqyjWX9YObuXu0BBxaVAcCrvHWnoxOAH
         fBCDFiNfl8roS4B6k0W6FEaNJ5Km7NfqQ5WyIOaq0PXmyN49EU5Q0i7n4i22Rrgdd19q
         B2XYEl0FvDAMmQEDHlYxRk6XaHOki0o23mcuiLUK1a8o/lKU1jjTHC2JTLy/4ncToM1Z
         BeIA==
X-Gm-Message-State: AOAM532ZwkChfmRXKfgJ2xU3337k82lCbQ4gH2vIWcNkiud4vhvQAjru
        suz1N2f5OT+PVqLI8olzztY=
X-Google-Smtp-Source: ABdhPJxbA7uANPJzxa10IXud9ItkTWxz6vNBdSRqG1AtDH9W7d1HGj2bTsIlcisE/sk+/ZBjoTqN5Q==
X-Received: by 2002:adf:f586:: with SMTP id f6mr51529912wro.299.1600684075307;
        Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:54 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 16/22] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date:   Mon, 21 Sep 2020 12:27:25 +0200
Message-Id: <20200921102731.747736-17-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on the Beelink X2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 45a24441ff18..f9bec6935120 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -142,6 +142,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	linux,rc-map-name = "rc-tanix-tx3mini";
 	pinctrl-names = "default";
-- 
2.25.1

