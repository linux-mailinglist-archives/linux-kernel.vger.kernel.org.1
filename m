Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D260272109
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIUK2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgIUK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454DBC0613D0;
        Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so12147705wrm.9;
        Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=k/Xa4p+SoiUfT5X/VXAMV+xAsc1Hr2ImHs8MB/Z+C82JHo35tHgnrpuszHeaXCNzlS
         WuIsy6ejmTU1M/NYjSa6Cs60JpHurVeIvzz2PBDOiTOO6XveuudlxZeMHHT6S8v8psBP
         v2ALL+Czs6/cSfpbtJeETASnBIzgeINCsgEavfLhHX+cnDky3RSMxd4WAOfoi+vFcXar
         NOO+aVfZZlRRhXBTr/dJmrW7EnSj8sC7LtEEJ4ydCBRrUGKJtZ/HJi/VRvYkaj3QGWi1
         qJ57DHKVSo1GrI/wjzG6etScyejdKlGNElcgy3MjqbqVnC/vT01suZ+TWCcidgqK6ae/
         OZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=GonkzQj4lM5o/eVuA3JDU2KnNd6BaVHOHGsNePNeEFwMRG+tQIeccWv8FMi/b9tYGL
         chdhpdscZ+PXf7ad4sgqQlDdzYXaIflekAUnSaFAGQeeQwt3nJlOW2a4R2O2wqwAJBOU
         DjbfTUHT7Y9V1gtqbeYpAGGLxWg7TKQGOCr4QE+6uEXDgLpHy4gPX/RT3qBmPoVEbpxW
         kXrel3UPYH6Y2p6+X0JC4JcmW9z9QIaB+utpCwcHt6oyoW8K2mMgjTqL+yGOQOhl8qYL
         eIKhnx/m78tKOYLlTKBVwdvSvLCEBCctwrAFt+4xVhkDCRdCZVaJfbybYeu3GjXSsa49
         TqMw==
X-Gm-Message-State: AOAM531G8+feWpQPFMx0fQQoT3nSfmVk7hsUW6Komu9HZawNT1SpX9q2
        /Pp5/mgre1Y7HV7Qm3RPnBk=
X-Google-Smtp-Source: ABdhPJx8Qo1RygVdBAmbHQewn4Q9oZkh/TL4S1CIJ6mrwHEIScVsMQIFKEvAZswsM/ZdHm/HjeU7PQ==
X-Received: by 2002:adf:e952:: with SMTP id m18mr50809719wrn.171.1600684073929;
        Mon, 21 Sep 2020 03:27:53 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:52 -0700 (PDT)
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
Subject: [PATCH v4 15/22] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date:   Mon, 21 Sep 2020 12:27:24 +0200
Message-Id: <20200921102731.747736-16-peron.clem@gmail.com>
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

Enable HDMI audio on the Orange Pi 2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 597c425d08ec..64e8e2829f27 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
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
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

