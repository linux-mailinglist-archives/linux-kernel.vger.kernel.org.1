Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7B272107
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgIUK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgIUK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8831C0613CF;
        Mon, 21 Sep 2020 03:27:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so12148307wrx.7;
        Mon, 21 Sep 2020 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
        b=XZLznLo2jfFPdSaxiKZTg7MtS6c3Vq8nSL0BrXqnKhEmEMj4nAXUDkYUKfDZmXkbIG
         Ol7gVNHrY9BHzdGcAN0ZpVljHSGsxU/wYkJOnShoPQNaYW9TZ88kjtkMPtOFBYdqMMPi
         9oWrNASrcn3o9Wjqayz4RqD45Ktso9UkJ3DauPOsjLXD9pBhX9SOvkAJq7MMxkmarkeI
         Baid58BWRKF02WoGgVfD9ozZTDDNpqScPaC9rIhEe3z/VXDAa/iWTqY7bWxhaybT3SLx
         PQLaNaEVBVDG79n0sivqEmY6FDZkajwG2Xs4+sEsWzcShq1INT9d7NNtNNhhqMXnemIi
         7Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
        b=AjplQY78J2Wh8MB10KLNRPZBb5Xk0IaMb7u5aaeu+ly3OGQFtjtuLpMkjyegqlXFAM
         rs+xwIZDp8NUBQAPmv8Et74clMCFmqR09DbVzlRzyY7RA1wTQ/ajBYTl9OIFMEhlS1Jn
         9SUYaYXeaX/f7onEnrhKtmwfRTlS9fuKZlECTfq0TdXlASpNEwKPKCQBvWe+ly5QagmM
         8rbdldtZvIbYqoukJwhp3lJrv8jze9UDARgYWyJzNuSrBRWMoYkPbtqxNF2anaWMCugU
         SHgLyRtkqGjutUlOcNfdQpgQXd4yMqyt2SCcOR8wP1UN6jnl3Ak+Eb2UNIcauJ8VHzyd
         b1wA==
X-Gm-Message-State: AOAM530TtKZ0cko5AoBS0uPaGqKSBqDszxhxOeiJzUCc0SmFMHD6mf4s
        hmtW11Igeuox90ezmF6lN3E=
X-Google-Smtp-Source: ABdhPJziKBu3aDQ3wWp2KsJ3eALaG5McqT6UYk+W9KKgrwPnZdByOHcVDimcFNCrrUtfKy+Sxchang==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr49418820wru.232.1600684076477;
        Mon, 21 Sep 2020 03:27:56 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
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
Subject: [PATCH v4 17/22] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date:   Mon, 21 Sep 2020 12:27:26 +0200
Message-Id: <20200921102731.747736-18-peron.clem@gmail.com>
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

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 329cf276561e..b54b02e59085 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@ &i2c1_pins {
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

