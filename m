Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D254C2716BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgITSIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgITSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CCC0613D2;
        Sun, 20 Sep 2020 11:08:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so10446044wrs.5;
        Sun, 20 Sep 2020 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=aLnfPiVPPCpnSxT7gRCrGZWlE1gaPfcOhdXuh1FLsjOB/5uEOhAZcgUcmfxnZpCY3V
         KlLcr/9ebOgMu3s9PGK450XFUEt9Wy0E45iG568EGKbVtgf0Qbi1FGc9M0Dwvtuc3X2k
         D6OdKOws170TD1DaX/o1QP1YWEWbO3wKMa1suDymqum1gCZlEsWr/zqZ07CX9om9rG62
         kO07ng8XqbRAtnYqyrzNz235LmnripbZyg1ji6Zpzbno83MQu9XR3bG0xhszjzMSxU/Z
         yxxx9VZnTCKxTOTruAS0RMzqo+Vbophk6fApYCAb0N0kq19efrAimdLoSeassHsCqaTC
         f9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=JAjtNry6GqpApxaf46nP/vqPiwGYw5EGm0gKHpGmW+is4/qwjXQHsspCZJ1jn9WLs+
         pyv4ffdgFZZoqtvNKmNPlPlWdjwibawJ5M7AMxnt2Dxb4wbH56tMZKYY2UQpAm58QWef
         b9axIapBKcdB9A2nIgyHCw1W0UNAB5JPZdoRo7OUkgEWhB9YuwaP5E4yipAW7/4tHOfd
         D6JPsP5yLzcI9EtvQug2a+oVjiL5Z8Zd/JjXfjpJThlmyOxSLezOGe8UFhWfttlRByYK
         hvs2LIqZQuwLa6QRjDOiz1npwKRqkxG7tHDyfVgQHjXXx5W3jwuKSfZp1+5Rw9JsgiBY
         Wp3w==
X-Gm-Message-State: AOAM533WFukTmqRApVKxnEnDzi0LfdROUllsyGL8NgY7Uu1P6+VL5cFw
        Bx+PaM2kvZlgz0zTXP5BOa4=
X-Google-Smtp-Source: ABdhPJw6H9m7msd8uoPY0ml6YAsigr5VvkOU7rlw7A+Gej+eUC90V/VlWpcMOXv3NryjNNqindPSCA==
X-Received: by 2002:adf:f585:: with SMTP id f5mr50500018wro.64.1600625311328;
        Sun, 20 Sep 2020 11:08:31 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:30 -0700 (PDT)
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
Subject: [PATCH v3 16/19] arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
Date:   Sun, 20 Sep 2020 20:07:55 +0200
Message-Id: <20200920180758.592217-17-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 7d7aad18f078..e6ed8774a17f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
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

