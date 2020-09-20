Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206DE2716C2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgITSI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgITSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B2C0613D4;
        Sun, 20 Sep 2020 11:08:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so10450954wrr.4;
        Sun, 20 Sep 2020 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=ci0BaInx4i0YAj07xhRBAGBgHj11UknO8IdNfJXLb0LyAVQ1/pyz8f2RtTmRLtQ5Ec
         bOpPp88FsBEagAOovQlTLt1Cs1NVN1jrnNYE8+Qek/cqqaYrTBeF+9xoP1hhI/pJNYeE
         BdX6yx6gjsPg8f+loFV7se4PzTmTFlXtY5OHXuJtqnY2/+Unpq07c6HGN1TPveZ9lmHl
         T6YFuek6A+aMeJNVwKmcyewsDmrxxW11dsSywzXfHX6atUeka5SPBvLtVEPtPI7y/KrB
         hWgVQLCdXya+Usz+kVLoq7oWmwU1NuzttR71+NS6yKC43TLXwlpoNLitP1JLGZNYLvse
         7dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=s91CNVLJ0ndqmTRoGojAuikE3xUQ1QmWa5Oslm344MAMtVdJfL2UeETzfmFBwh9KhL
         vVn8dddRxFSF0eC8J24ZOc3LCAP+OM7DHtO/xdYx8qTXQanzLgick9XHPcP45vjD8tMA
         4A7Z1ckxySrfc712QThO1tch9f8mXLHwWSE3N/m1xJqY++cJHcx8IB6aQDLOGpvCMHx1
         6LFEBZ7MjV+H5jHgPFdl/UUGMgLtFyjNN3qAwW6jb0x013HEjME1IMlrqGeAy/jyb8Pm
         KVK0Jj7yaxCDYYpKd9Og/IQuU02yQGy06uwFSf2VHDotRvMiQM21M/InF+TcIT/RGNMV
         6iew==
X-Gm-Message-State: AOAM533A/YvC3K+9EEyIC0/WJVcJ4f28RCed3iLQcAqsEdFuowMWWRam
        WGeqUfB223D1LsbOoUW6o3g=
X-Google-Smtp-Source: ABdhPJzxcgu7TWf5cYHeTfhFnuc/qvk2kIvyK8lXjRxHnrRoPIonBO0Sjr7s1mE7mgOJ/X6RyVy4Ew==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr51770353wrp.217.1600625313922;
        Sun, 20 Sep 2020 11:08:33 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:33 -0700 (PDT)
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
Subject: [PATCH v3 18/19] arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio
Date:   Sun, 20 Sep 2020 20:07:57 +0200
Message-Id: <20200920180758.592217-19-peron.clem@gmail.com>
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

