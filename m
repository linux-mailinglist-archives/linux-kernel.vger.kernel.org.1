Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7D7285FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgJGNCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgJGNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:02:51 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5CC061755;
        Wed,  7 Oct 2020 06:02:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c5so2155774ilr.9;
        Wed, 07 Oct 2020 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xgra9s8aJ1g9hZznlmShgFGid1qDvqpduTjQ63z9Ai4=;
        b=txDSCDnGVOvBmCLpVuBmy9IwJHZMw5/f4HStsCW+a8uQ7KWFidpfrCed0boKAYPdf0
         m9m57hMEGQJvsAFppDA44N//SLhO8o8hmLybVJEVm08MQ8NDl0bAy6hLRPDejWPB91RX
         ytVP/dxuCa7IhDhfJbL6TLJsjPlIdWiiiWoIez1gZF7MJno9VmRVAPE9yuluvWPiS3r/
         C76xBU9YpL+XL3SoGiw1TApJcJYf/vUoh/jYNwViuQ14P6TgiTxQoyE07SDDzJbINIGk
         EfYyobyL8GDPNsmhyjk/PhF9PVucyaEQEkR7MeJTcGjJvyTS1MCz4bW6BPfokTHg0NOz
         dHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xgra9s8aJ1g9hZznlmShgFGid1qDvqpduTjQ63z9Ai4=;
        b=YiTs+3yR7rCYVW7k4IRajdyZGlTPiouQM/hTc+IhFdPQAkN02OolFGB0zES1+Di7Sq
         2qijQc9cmHmqsaiSS6LNfWlcdMd7C9LWpRJDW+kGIacJnytSTQnD81YIkh36ED9X9wfG
         tIFrLWnzZxxa3mIQJg7qVORNHXat/2tBn5uJ/Dt1ofL3KKC4Ad5eGjn6VJ6SvY/ba+5L
         bsU2IZFH7Vmu2nmRrmWREMRmIbQwqyWfdpWr3+5HhIS6e54VFk3PQqadq3eWxXMGYKnh
         B+knY34EhrhjQXOzffQXNpMmVjy020QsX0PaoQs2fym6slZ7NJfNHPWnCdDRRIPycRGO
         wprA==
X-Gm-Message-State: AOAM531iW+imi3Bm904gMDEotdarGdno5TqhwKZTb4UyDucKd1MqH9U0
        BLNAevzxj1AdLYVN0NCeAqU=
X-Google-Smtp-Source: ABdhPJyCcgAY00Z2svC4bvm0PN2VeHh0tvFzCAmFibdex1iaqZRd6Iwj3EXya/oA9U7bGCAolg8SRA==
X-Received: by 2002:a92:dc03:: with SMTP id t3mr2541087iln.245.1602075770162;
        Wed, 07 Oct 2020 06:02:50 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id w14sm1000038ilm.88.2020.10.07.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:02:49 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: imx8mm-beacon-som: Fix Choppy BT audio
Date:   Wed,  7 Oct 2020 08:02:37 -0500
Message-Id: <20201007130237.230613-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming bluetooth audio, the sound is choppy due to the
fact that the default baud rate of the HCI interface is too slow
to handle 16-bit stereo at 48KHz.

The Bluetooth chip is capable of up to 4M baud on the serial port,
so this patch sets the max-speed to 4000000 in order to properly
stream audio over the Bluetooth.

Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 55b36bddd513..b88c3c99b007 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -211,6 +211,7 @@ bluetooth {
 		host-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 		device-wakeup-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
 		clocks = <&osc_32k>;
+		max-speed = <4000000>;
 		clock-names = "extclk";
 	};
 };
-- 
2.25.1

