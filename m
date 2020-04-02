Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3B19C9AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbgDBTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 15:15:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:15:35 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MMY9X-1jaNm746x5-00JbXk for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 21:15:33 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id B0B22650ABC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 19:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1EtFsO8tfmKN for <linux-kernel@vger.kernel.org>;
        Thu,  2 Apr 2020 21:15:32 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 49C4D64E13E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 21:15:32 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.12) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 21:14:24 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 34C0C80505; Thu,  2 Apr 2020 20:35:06 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:35:06 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v5 8/9] dt-bindings: adv748x: add information about serial
 audio interface (I2S/TDM)
Message-ID: <337b689519806178458ab77385c8ac6f510cb0da.1585852001.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1585852001.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585852001.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.12]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6C7266
X-Provags-ID: V03:K1:ASp/WQ4zZ9JtiAH1QSffzJoWPWN31FwwaYAYnmm+3jywy4UBN2k
 r5OTJtnGmzMWahzRyv2qwP5VXNI7js+Yiz7MXkJJIFMPvNMyiGUZdEGOHWKClpY3GVE8iWV
 dxmM+3IYa93fZth60nh37oVdA7Gh/BJVGHlrAs2jCo06WOWnvnrJSGOeoqjW13BvbYgv8CE
 VuFepbUZgyaTP/f8LMexA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:74Zyjf8pC34=:+rZltLK+SAQ5kb7qXOx0ce
 k9reRyzShX7iVvJTp0JlBU+DQbs0SMkRc/xnueaLdNxBn1Cbr0E+ZHK1batlUxjT05dN3SBof
 fI08oAuCP9lPR12+EI0RaPIuV3DJtBtY1iGJeDwryrxPijL9qtfaaNgho14LmHSGBkqNUyszE
 k1YKfkV29hVMBsHDXWQQZFS8xo3nBlUCr7/N0ZohcKX7/I1FSe9OV8Kgj3AtOAERJcFk0JXHK
 e2qRQ76tRP773k6IiOB6cnKvby5EA9n5tmLLAeglMhiCFltuU7iFzdrij2vIrL+TBcgCdJgNQ
 NGLyWUTuRATLM9kgMlbfUca65VuIWIMU6NPoqZ95yfPZEHjMgGP4jyM2JxDDfcLx39+tBzRKJ
 jMioJ+mTdsTTibn5PxBY0WajzVQ++uIZzW8a1rNBLGfswQ5D9kUA0PQSYecBLEbitH4zSaB67
 s7TJkpsX+Tf9naX5NmG3INkVmiZ2qFkRQXiHU7W7mgh33XqS3ddL3r1YxTEbLsLdVST49mtTc
 vWb47WiaDDu7WZ3BM8EvQOcBXp1WDQ+cXBN/XbccDam+PU4Fd209ufGd0cybEhRnFg1qRMzzE
 MXJo7Rkv8+WkBxHEGMqud38l9zW3fObfKsch1+Opf6WyoRA3OG28D1pf8Q7itPDVt+PVPaaK1
 wWpfOOssDPTbhP2mx2cr6YY6Bnp7LvuXCxkxbC1oig4SYKwKqnHyg8nEdGP3q8U+JanaWjQAc
 nwag9232bN67H8vFHOTl+s1OuNZWcwYjjeDUZj8mCtb9FCBWR9XcBkItW5IZ9vek//saEmegj
 bwX4Xcvz3rhKyYtTvdGpfhGcNy9Ga4jLgbmQ/CeuhvToXoYMfv2xI+jJarNuZwITVsfoGdK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the driver has some support for the audio interface of the device,
the bindings file should mention it.

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--

v3: remove optionality off MCLK clock cell to ensure the description
    matches the hardware no matter if the line is connected.
    Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../devicetree/bindings/media/i2c/adv748x.txt    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
index 4f91686e54a6..50a753189b81 100644
--- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
+++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
@@ -2,7 +2,9 @@
 
 The ADV7481 and ADV7482 are multi format video decoders with an integrated
 HDMI receiver. They can output CSI-2 on two independent outputs TXA and TXB
-from three input sources HDMI, analog and TTL.
+from three input sources HDMI, analog and TTL. There is also support for an
+I2S-compatible interface connected to the audio processor of the HDMI decoder.
+The interface has TDM capability (8 slots, 32 bits, left or right justified).
 
 Required Properties:
 
@@ -16,6 +18,8 @@ Required Properties:
     slave device on the I2C bus. The main address is mandatory, others are
     optional and remain at default values if not specified.
 
+  - #clock-cells: must be <0>
+
 Optional Properties:
 
   - interrupt-names: Should specify the interrupts as "intrq1", "intrq2" and/or
@@ -47,6 +51,7 @@ are numbered as follows.
 	  TTL		sink		9
 	  TXA		source		10
 	  TXB		source		11
+	  I2S		source		12
 
 The digital output port nodes, when present, shall contain at least one
 endpoint. Each of those endpoints shall contain the data-lanes property as
@@ -72,6 +77,7 @@ Example:
 
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#clock-cells = <0>;
 
 		interrupt-parent = <&gpio6>;
 		interrupt-names = "intrq1", "intrq2";
@@ -113,4 +119,12 @@ Example:
 				remote-endpoint = <&csi20_in>;
 			};
 		};
+
+		port@c {
+			reg = <12>;
+
+			adv7482_i2s: endpoint {
+				remote-endpoint = <&i2s_in>;
+			};
+		};
 	};
-- 
2.25.1.25.g9ecbe7eb18


