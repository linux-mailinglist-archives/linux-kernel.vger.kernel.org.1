Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7832E2D0D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLGJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLGJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:55:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23003C061A51
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:54:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id z7so12130002wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+T69uWds35TQLG/jLTGEQSVL+H6ceRPvadepLDcX3dc=;
        b=2TL8+pWXVEUg1MlfV8WS+SppmrUsLz5DcTpIod+2sSBnsmaqSPH6DoQYpKypocIQeg
         frvq52OvsBQwjoqlWw+4UzZAYQMNYkVM2xkUTK1BBmouoscTddjAE/VxQV+ih9iIFHJo
         KGVNsRs2GakXwlhCWVWA9T7PaSw5wRxkpvUQFLusMJ5I5DZGf9g/8ntUsPNr5kaV52b/
         YSja3k+Cnxp/ol89eOWSwS6zSDLOV+g9Y+cPABNH164994EN36hPLKues5Ofb701ZGNs
         OOGG0uCy0hcWJeydOB1FqJB3vol0Pq4SoowKEDEk7RoRHoMmM9SDHbPF+p0jIOBl30bp
         0r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+T69uWds35TQLG/jLTGEQSVL+H6ceRPvadepLDcX3dc=;
        b=SmB4vmWuEYBlZq0+d+oPV5UFONrNHlHZQ0EygplCD0nf8DDFjvfJSde3vUvC+w0UEc
         mMGVVXaFGS1Zkck0uL9ws8g4zHDe73gBXLCMs1SROodGyTUNwL417JXrPhcm4Uy8anI/
         BSdb6/QUeP7tRTQcKi0qU3MMsK9LQpnFSGJETKVN12507rMivLoUl72Yln5Nv3BcyK5Q
         oK2w1YImymYSNpGbPAHU1bEMDPUgVP/UZq070YRPtCDaD06fV85FOs4f0HHGx9vqZJA8
         IqA9278DK/wx5WLWesEvO9YdkSWtlKpsjpJa/mtVEKKxTCimIYdNzwcQ5dCnpiG8r7m5
         DL5g==
X-Gm-Message-State: AOAM532xAbj1ObORlO2wjePBRoRaL8l6n4Z5uVJEqUGy44oKwzRF4Y6Z
        finD9oCr7lnCycDt1/i/rbO7qw==
X-Google-Smtp-Source: ABdhPJxDM4KNSH7f7/lDh1sIIdNLPg+kejrnj9WeGMYgaamDmfxL+LwJfinrmm+rbDfBMTWg3b1qiQ==
X-Received: by 2002:a5d:65c8:: with SMTP id e8mr19661606wrw.338.1607334840868;
        Mon, 07 Dec 2020 01:54:00 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id t188sm13558066wmf.9.2020.12.07.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:54:00 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: vim3: enable hdmi audio loopback
Date:   Mon,  7 Dec 2020 10:53:46 +0100
Message-Id: <20201207095346.26297-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201207095346.26297-1-jbrunet@baylibre.com>
References: <20201207095346.26297-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable audio capture frontends and a tdm decoder.
This makes it possible to loopback the audio played on the hdmi codec,
which is the only output interface at the moment.

Of course, one TODDR device would be enough to do that but since
the 3 FRDDRs are enabled on the playback side, let's do the same on the
capture side.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 12465c4becc7..4cf2c193d168 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -166,11 +166,16 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "G12B-KHADAS-VIM3";
-		audio-aux-devs = <&tdmout_a>;
+		audio-aux-devs = <&tdmin_a>, <&tdmout_a>;
 		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
 				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
 				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
-				"TDM_A Playback", "TDMOUT_A OUT";
+				"TDM_A Playback", "TDMOUT_A OUT",
+				"TDMIN_A IN 1", "TDM_A Capture",
+				"TDMIN_A IN 3", "TDM_A Loopback",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -193,8 +198,20 @@ dai-link-2 {
 			sound-dai = <&frddr_c>;
 		};
 
-		/* 8ch hdmi interface */
 		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-6 {
 			sound-dai = <&tdmif_a>;
 			dai-format = "i2s";
 			dai-tdm-slot-tx-mask-0 = <1 1>;
@@ -209,7 +226,7 @@ codec {
 		};
 
 		/* hdmi glue */
-		dai-link-4 {
+		dai-link-7 {
 			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
 
 			codec {
@@ -449,10 +466,26 @@ &tdmif_a {
 	status = "okay";
 };
 
+&tdmin_a {
+	status = "okay";
+};
+
 &tdmout_a {
 	status = "okay";
 };
 
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
+
 &tohdmitx {
 	status = "okay";
 };
-- 
2.28.0

