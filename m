Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235792DD614
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgLQR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:26:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E4C0617A7;
        Thu, 17 Dec 2020 09:25:47 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z5so28242907iob.11;
        Thu, 17 Dec 2020 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krTHnXR6iIykJ5sXv4kLG6gH+GfxhHZQ9SdSfjbfxks=;
        b=gexgyPyLr2RPKCxqRyyvqKBOJ8ukeF6TNc2pZxDiwDvoOxLO5rrtB1rkeXP/J6oJ6+
         TrmEutXxkDwtBfmFIbBmsW/BNwDhC3RblruiLoQx1zXq52qDzhdCIPrPyq/3jkYGTdjB
         KDmFztAwavClrdBXriRcWgyfuNozOl29uyPxKklcf4dDIwnGirZdl0IdyBBy0Z3cWyy0
         zYLrnbUS+0PeSuTIEG1s2ENzvfdZscRijOxlH4wTX+fs6o0BH+j0XtWgwPuuB+3PiIKK
         QUmho8AbR5aOlMQ60IhOEsO04iC09AuowW5oUP05SdS7VN5V++gAQR/8+HPinvRHk28d
         DLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krTHnXR6iIykJ5sXv4kLG6gH+GfxhHZQ9SdSfjbfxks=;
        b=FbIlaX/wUEtv0JOXVuPpT66u7dtc6154SY5zcUdysApfkk9TUCWl9OoUUpYt5kGIAh
         tzrGTheY/ZhdyikSuhqxTG69vdHoITvKRTeJkwEqrZG8TscMyDReecNCCakgGOCW92He
         1JR4X8tSvRlDCWvOntxWpDUy6yuO3kVz1mFVoxA0c0mBu0gIbkfJlkSsL9Co460pD+mI
         gW+71HSc6jhX1Z53glJW7kalWyRyBufG5wCnzYTdWxWWB32e0iuSnyPkTyrlZ24DjKKq
         vRaYt+1nKjqW0gLNEYWLzBImVtMxn+N6xd2ukolal5L01pNkpx2JY4PT/ALraMwNkhSz
         FmDQ==
X-Gm-Message-State: AOAM533NlWMBNXVMJLtEDvE9cG3Iw7PAMWtupf4IAFEsSs4nAeibjMuf
        UWQfc9b9QvkhHyWXW4IYUiyT3wIaXFToWA==
X-Google-Smtp-Source: ABdhPJxdjkorQ5pT7rlmmZOyhBdBqw+V6jPKlXWJFW9I8l21dso5Nquu21l7t9TWdAxJZxY4ydqqWQ==
X-Received: by 2002:a05:6602:387:: with SMTP id f7mr86169iov.209.1608225946916;
        Thu, 17 Dec 2020 09:25:46 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id c15sm3447028ils.87.2020.12.17.09.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 09:25:45 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6q-logicpd: Drop unused clock-names reference
Date:   Thu, 17 Dec 2020 11:25:28 -0600
Message-Id: <20201217172530.1459503-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wlf,wm8962 driver does not use the clock-names property.
Drop it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
index 665d63765cdc..d9de9b4f0c52 100644
--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -238,7 +238,6 @@ wm8962: audio-codec@1a {
 		compatible = "wlf,wm8962";
 		reg = <0x1a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
-		clock-names = "xclk";
 		DCVDD-supply = <&reg_audio>;
 		DBVDD-supply = <&reg_audio>;
 		AVDD-supply = <&reg_audio>;
-- 
2.25.1

