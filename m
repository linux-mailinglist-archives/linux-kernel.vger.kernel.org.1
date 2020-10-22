Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A690296174
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901155AbgJVPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901137AbgJVPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:08:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7DC0613CE;
        Thu, 22 Oct 2020 08:08:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j17so2038520ilr.2;
        Thu, 22 Oct 2020 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZC+zRDPEeyQcTByYOpRMHt2LfY8to8VrUvMmL2b8SE=;
        b=nwl1SP71gfGRw5AXLC/NApGQzKG8KmVFYwtj5XLxpSpcUNS+NPt18SdWF69CAiuwxJ
         fWS3Fs7rBtjRzFqyJ8UJCzhwC4w+C/FJ3sOBTi6ajwa2GsASVH7s2HrZkBIgJVqckfQT
         8/LDZgiqZCo2gz/VOy4kHTbPZU4+ooNa0iFfYfm6E5CtPSzxKVGmlXbSTfekU+YGRUj2
         ujqUs74D7r86lAb7a44yTOBSx5k5BUg75osswmZhZlPHxOM64vvw4JX1EBvKrhPeHjVq
         1950jaGAxTGd08uIt+9P7ekqQjWRRCRY40yCCjyi/u9pMA2MIG3+BnGc19PmnXNwfqy8
         Qp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZC+zRDPEeyQcTByYOpRMHt2LfY8to8VrUvMmL2b8SE=;
        b=JQFr8gkL9hx3JIK8FFU59UiPr4uUrHpn+NUiKac7Yil0FD/IZrrrauth91WC9V+8lf
         bZGYP3qn2mJozZNaa0uHnUwk6zK5DuVNN9FHovn6lEchG9GA/T95kgPlHtYyANusJFR4
         U95+5M0VIotLYV3odDkKg59IJ7JMfUEbZNpyHLTwxtsWx5VXKwJWH3rUV0zAIfbjrKLY
         nywKngAqmNrf2Ji18XlHTyIV+Z5ruG9WydsGnDkxOnJ89zfO11nsgb8EEVoycaLd5Yj1
         rd4wZ5DYtcrbskxZeyc+uAPK958wQfhoKWnnaUrfqhd10VQdayfaWdli8KigZBwupm0p
         zJ6w==
X-Gm-Message-State: AOAM5323T2emWljvxQQefPVtvSskDVN1qmlTElWRf5ulZKiNn1FfzYo0
        M0mitojq3nX7+t5oD3RpFmA=
X-Google-Smtp-Source: ABdhPJw81m8AsbpBvq6sOy/2eFB0vI3FDRPGeEtVPb9gACZZxhUKwh+JtnQ1ugfDKOnVB3j01qGV6Q==
X-Received: by 2002:a92:9911:: with SMTP id p17mr2183111ili.165.1603379308435;
        Thu, 22 Oct 2020 08:08:28 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id y6sm1233816ilj.59.2020.10.22.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:08:27 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: imx8mn: Add power-domain reference in USB controller
Date:   Thu, 22 Oct 2020 10:08:07 -0500
Message-Id: <20201022150808.763082-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022150808.763082-1-aford173@gmail.com>
References: <20201022150808.763082-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB OTG controller cannot be used until the power-domain is enabled
unless it was started in the bootloader.

Adding the power-domain reference to the OTG node allows the OTG
controller to operate.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 27733fbe87e9..605e6dbd2c6f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -979,6 +979,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.25.1

