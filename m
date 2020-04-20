Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F11B0C19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgDTNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729819AbgDTNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C7C061A0C;
        Mon, 20 Apr 2020 06:00:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so12045434wrp.5;
        Mon, 20 Apr 2020 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvYBwY55hequdKKDkallbXJKwj0FSX4Wpx+56e8/UBw=;
        b=GnXkTyDbvZRKI8WVoNn4do0UB6uQi+ZtA94YaGKj9Z/hY5pSM4ES1lXadFriyRw2Lx
         wIKOLwoshEWRDKtqPSK20K+hCLHyZzGxns74voSg+Puxt9Su+vNTS9XbPthBG1dAXMLQ
         kAeKaCnpy8nql22EJ6UYL4flzQSdYemUPBEKjbQrvru/x/Wx4MnBpSpI6S9KdsnCsIa8
         NYt3HG48Sj43gn1+JEAm1qQyEeceT/cvknLniANReReC4SO9K3CK80isBKHbVtQM1vpZ
         qZhGphZWuLD6Vls9vULGh6oOYmMhfisBbuUWWL9bHSJIhEKh1urWzq9zokVwjGAJOea2
         5QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvYBwY55hequdKKDkallbXJKwj0FSX4Wpx+56e8/UBw=;
        b=PUewHGMrSEP2JgRin1Tt6CzwBtsT04WDcsWUbQ4KyST6TzfnFk2k6bZf7SLZXLPEUf
         o8iXMquGyzsWhpVOEoy50qB1h1gSc/XmTN6Z4Mkavg+Xmt47xF4w5M6YVaXeZDxMJrGV
         x/kDAzX3ywYyrFyjzhNcYmb/5EbDBlsiqJ0EArDNg2ZNgtsVISvoJ0S6eYNFUsXrTZf3
         mlTxQlYmDvzHImwDggOy9Rcp9Xwo2iebNvJDN4RNAF4/+mcnchuD6B2rZksQZDxN2KwK
         I+k3H5oVRvXjXZqvoGD+a29mUSesom4STpRpyZiPH49VSrTmthqqfnB9u5DKvbF6/ssK
         jDLw==
X-Gm-Message-State: AGi0PuZTN0urbGIFJFn2WezkgwVWvtdsqy4pNWAISBxRmcVhFYb9Y3/m
        Bxz2sZBmmeb6y/vz/m0bIcg=
X-Google-Smtp-Source: APiQypJ5ZUEms1wCuIanJt/09BahkVB30m2MeRUZLi5l35DB2zDFZG50WibZ+69q77JuebIRo2jEdw==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr19898775wru.326.1587387633625;
        Mon, 20 Apr 2020 06:00:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 8/9] arm64: dts: allwinner: Sort Pine H64 device-tree nodes
Date:   Mon, 20 Apr 2020 15:00:20 +0200
Message-Id: <20200420130021.3841-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pine H64 device-tree have some nodes not properly sorted.

Fix this.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index b0642d841933..63a785b534e1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -80,6 +80,18 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ext_rgmii_pins>;
@@ -91,17 +103,6 @@
 	status = "okay";
 };
 
-&mdio {
-	ext_rgmii_phy: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
-};
-
-&de {
-	status = "okay";
-};
-
 &gpu {
 	mali-supply = <&reg_dcdcc>;
 	status = "okay";
@@ -117,12 +118,11 @@
 	};
 };
 
-&ehci0 {
-	status = "okay";
-};
-
-&ehci3 {
-	status = "okay";
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
 };
 
 &mmc0 {
-- 
2.20.1

