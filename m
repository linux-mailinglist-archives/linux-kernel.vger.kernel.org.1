Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E042DD616
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgLQR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:26:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D8C0617B0;
        Thu, 17 Dec 2020 09:25:49 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i18so28263988ioa.1;
        Thu, 17 Dec 2020 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhn/RV2TNq2pg9BVCcuwvP67rLi2EpvQNTMsRmLOIbc=;
        b=H/dou17lM55b31VpburbDV3aLpG72qBiNpDV6Nv7ofT9m88U0YWyy5ehV5LfOTcWj7
         ic9kS0P8NZTOloynwlIEEtOoUqiA1ibI6LeVgx0hGyCuEI022j/gAsGQfVzIVc3/nQAR
         UJnLzLZI634SIYSU+9BAVrVHYMZ3lNwJPgpQQXo/YudkZcuQ3iQjDpnenHaEynROFcEL
         s72efu/SSmmPj+IXpzDz2f7N2+Dc3K32Xeq50UvkEnl8Sy3X6tPcGau1NY1KdrDEaR+E
         yWewRQ3gB+UEqTmM96h6vLoKa1Pp6jda9cwNBao4BS3+VaLIOXU63QcUwYbQ4dh8aVD3
         EAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhn/RV2TNq2pg9BVCcuwvP67rLi2EpvQNTMsRmLOIbc=;
        b=rMzLezaT4kpmwKJOWskCKUbQk04b7PfTozgl8cQSQbnn4NUleg/pO0qLYS+44VG90w
         Nnlsv2lNbAlnBcPDFjeb2iPpeBPw+xFUk5ZGY0DzVMTGnoIZthTy18AcA3QG9rBuIJYK
         RJzdXVBvHdO0dzt6IvGz13NjZ7d5UhmbsEVwZnrdF2+SPej7rneKvVeDa5+z9JU7fh58
         rVrlWwDglyHBFZl+cZRuz4u70K1s+HTBhGRLyZy9a0ynm2AVSuW1+7X07fO6qCbUHBMQ
         CsAhbUA08guNkUcoE3I+0blrksxW5E57OHTV9y9Eh+eZr6if4xFbCU71y9d8oSJculxm
         OIBQ==
X-Gm-Message-State: AOAM533LBBJPxCFy+JrODfQdjHIvUmFlzfuxuaiWPDJT8PBEOXGdI6D0
        BiDLCobPCEsy1eKFxMrLfl0ZqCa3HasUJQ==
X-Google-Smtp-Source: ABdhPJxdvyecgXLlkdspOQ7FSChyza/CUk2j9O+MbZzSE/ihnfpKmjuVicsJvIUUNfaOCpXSU4gjKA==
X-Received: by 2002:a6b:441a:: with SMTP id r26mr104570ioa.105.1608225948577;
        Thu, 17 Dec 2020 09:25:48 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id c15sm3447028ils.87.2020.12.17.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 09:25:47 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: imx8mm-beacon: Drop unused clock-names reference
Date:   Thu, 17 Dec 2020 11:25:29 -0600
Message-Id: <20201217172530.1459503-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217172530.1459503-1-aford173@gmail.com>
References: <20201217172530.1459503-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wlf,wm8962 driver does not use the clock-names property.
Drop it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index d6b9dedd168f..6f5e63696ec0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -102,7 +102,6 @@ wm8962: audio-codec@1a {
 		compatible = "wlf,wm8962";
 		reg = <0x1a>;
 		clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
-		clock-names = "xclk";
 		DCVDD-supply = <&reg_audio>;
 		DBVDD-supply = <&reg_audio>;
 		AVDD-supply = <&reg_audio>;
-- 
2.25.1

