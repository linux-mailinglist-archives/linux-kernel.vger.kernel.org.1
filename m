Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7B2AA5A2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKGOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgKGOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:00:40 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D79C0613CF;
        Sat,  7 Nov 2020 06:00:38 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id k1so3951146ilc.10;
        Sat, 07 Nov 2020 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1njg3utV2p9bKgyMsTbOyoewTBP9kZE4ktjwTOypoMs=;
        b=HCCsnnm5jsPnDtM8EZrqh1x63Pj0F7mAgqtsSZz5LaNsKwmEQkP/07oj5yjd/aZC2U
         ezmEep9qXcrHJ21hTrEMNbUu/Br7XRQPdh8aM+q4HcWT6HTczvaA1s6XSP08UVbRMqRW
         MfP5JirqfkRQZeKpEAeK6N3kgEUHA8s/kilEHJJkasWnTeSuVP4Ghv+vsFEz3E8GSj+Z
         ZSL4DcJYoupmE7LVEEdk6MEpXifXVYIjzEQsLd49IinQmUcv2MGcKOe8OMF0ZzhEiPKe
         sEYADnCV74lrWKhX2vPh6hMO4njJqnKLiHwynKkreBkA8DS9j66MnB9nCiFcDaRkUJfV
         MoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1njg3utV2p9bKgyMsTbOyoewTBP9kZE4ktjwTOypoMs=;
        b=FXK2t0nPmVQtdsMR3CajdWkKsfCn3nw2xly23VLx6h3V4USvn/f0qaA3kuWIC5fmA9
         AVn2FzkNpElun80+bBMxW4ENfnnX6JEcEhhd63bTSPvAZ0Sp4T5FWrE94rhICyvJQ/PS
         rbpagDWgnuEeu12UDy885Cp5q5kZThDxjkYYy8/uRpJ05aFiQAqrOgPdThFAGPxQMBOZ
         fIHJ0PKAx1HjrPrFgFz/d8mkhlxk0dD2QOH1Lg4/IJxaBC4Gvmg7Z26Ib85bKx7NGPSd
         rUr83mc/pKM8mZMy9Vh6Iv48Scwj1IfMkekFfh4VoLa4l3pp1ozFxwX688hq9RHCHxAK
         +ZMw==
X-Gm-Message-State: AOAM532Ka49fTzlhPBE5/OyOQAdeNPVFjqsHoijADUhnNBbyXcUPAre9
        0mMD7zNMCICN7w1SuVAbuOM=
X-Google-Smtp-Source: ABdhPJxEBa5IIb1Nl3e/dQrAG6mf6nNEuWRyGHjqoRAEOE9Cz6XTHJtNWCNt8Ty5Dx0F7G/hX8isog==
X-Received: by 2002:a92:6706:: with SMTP id b6mr4950593ilc.42.1604757638029;
        Sat, 07 Nov 2020 06:00:38 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id g5sm3030257ilq.33.2020.11.07.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:00:37 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] arm64: dts: imx8mn: Add power-domain reference in USB controller
Date:   Sat,  7 Nov 2020 08:00:24 -0600
Message-Id: <20201107140026.1974312-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107140026.1974312-1-aford173@gmail.com>
References: <20201107140026.1974312-1-aford173@gmail.com>
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
---
V2:  No change

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index c37dee13057a..5e4b6934de40 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -968,6 +968,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.25.1

