Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505DF2720FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgIUK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgIUK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:28:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666B5C0613D3;
        Mon, 21 Sep 2020 03:28:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so11581782wmd.5;
        Mon, 21 Sep 2020 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=h6xYtTsM8vUSYrUZdzsJfHb3nX/o/s/ZsfIgvfy4W64xlB8Y8//XzMw6rs+DL3QRDd
         Y7fQKVv1O8f0qYcpfQhmsXiTH0IjZdTHWpNhNeBNucv+qo4uDFd+NoNOCxlGiwzJFwbH
         lvjl1I0WT7ojz9WlHuBhp2aGEo/oYLW5d0d6vE2elnKxWcZMI/lSXsJxjj6Xd3kucZvb
         rkJfHRFTmD8LjoEgawcqQ0+smQ4kCObAGAmqy/LWxlJJ4SXsMmCShvcqO//Tm4fjC3eM
         rIhe4JaH78ISzJUWmbSjq6WD31xhUP3DDiJixxChh1BMOmc1enQZEnT58EBsoxNkYiQl
         fKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=QFb9o83GL7k6b89WTkjCnPoHYDoapYivAUIq3bGw9GUpbeXg19OGLm8vGvvj451koq
         PPugPIWMPvmtgvv9F3lwVKGx6/z8AoS0WCXkbJ3G3LRWDEltPUh6bWKR585Hls5JlE6F
         u/G0hD3ikRkj2cEp2bm6TF1k0gRJBgbbOrCPxK1cKwhdT8VS18WTesnHQs5163JJLf2s
         b8LAvpUjJeeyoPdkRJnXBC2HeFFYT+LcfopsvPVe1KMW3/uwt/NxCOU8y3hNsSjMjqff
         QLVkpQwE9PlftZUE3GNej7+sB54TiCZg0kLqGu7bY3ReCE5gvPwEzaOnmdrbvOKO1X+w
         uygw==
X-Gm-Message-State: AOAM530FWlnrsfWY5rvYadNonn1dgo6s42E1ZVV8tTj5lj9WAvyGyHH6
        K4YlsuSPY+h/G90AT5rh5Oc=
X-Google-Smtp-Source: ABdhPJyAeyQp9GMNSy+S2cHGsEUh2xBRCZQgRuvb1YXpdy5goNbZMxbQXjnbAtL/QLWaBrI9K3UR7A==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr29150191wmc.142.1600684079969;
        Mon, 21 Sep 2020 03:27:59 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:59 -0700 (PDT)
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
        linux-sunxi@googlegroups.com, Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 20/22] arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio
Date:   Mon, 21 Sep 2020 12:27:29 +0200
Message-Id: <20200921102731.747736-21-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 15c9dd8c4479..193587e78031 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -128,6 +128,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.25.1

