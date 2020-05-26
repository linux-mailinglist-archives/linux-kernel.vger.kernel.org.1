Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30E1A3CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDIXCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 19:02:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42127 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDIXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:02:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id v2so40844plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIJZPEFSJM6M841dNh5jrpNBXHFJZg4bAqyw0T0WdHE=;
        b=ANBR9gXiPJlUP4KqtSzKrzX1Ak8sTYrUghswcXNY9U8cscQY4540c0VsZEA6K/8ao3
         jPhjSCQ21IAtwFhO3NkSGdBcojwh3c38e4NEWBxrnSlI7RvQ5BhZcNdbISrJjwEYOqj0
         ujTCKq1g/xKEcJcziaTGi4v9yBbZSwRIn4DkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIJZPEFSJM6M841dNh5jrpNBXHFJZg4bAqyw0T0WdHE=;
        b=LWtSf/6UVGKRvePQ40M6mQYSxRKehgO/iOwROvYIB3d/7nJ/9g8I7d1aVrdCyPgAVh
         kCYHE5f762XY58MkDN35DHYRofRxu7IRTcINwQtVlPf20/zPvWOpKBfbCJGjtqVvoUDe
         QLr8JxaLAu4u1OlfzpzR5K39lYE5koZRqYYhDb31VYA+tIZejMjGCR1wmVVWvwIhn/fE
         FPeoaQvlG01GdP6C7Os4CuF03tFjMySnEQQNE1tB+HYMUULBXRRnoQ4fTwKGN5rYASdP
         4R+HjwPnu583Z3StQlih0uNBJno+urKq2MdGT/UnwWHTzYzjX164ZdLIex/RLE8mkBrw
         wwRA==
X-Gm-Message-State: AGi0PubiTDAEqEoxw8eKWV4r0Hup9cGV/wnJx4HoGb+w0fR92I1Bzo/Y
        sr2GsYT/ib2Y1z0NiNoaPsZDzQ==
X-Google-Smtp-Source: APiQypJimvMon4Q5xA3ushKRx69V1ZLH9Zjeu2mLaa2PHnrgD0D5csP5QZfQPbyVxlVj+rBz/B3XcA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr1894090plb.121.1586473335201;
        Thu, 09 Apr 2020 16:02:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x68sm164227pfb.5.2020.04.09.16.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 16:02:14 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        devicetree@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Atul Dhudase <adhudase@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Add interconnect paths for the video codec
Date:   Thu,  9 Apr 2020 16:02:08 -0700
Message-Id: <20200409160206.1.Icf877f5cd50ef5e56d14ee014ca196d76242cb89@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interconnect path configuration for the venus video codec of
the SC7180.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
The interconnect paths were originally part of the patch "arm64: dts:
sc7180: Add Venus video codec DT node" (https://patchwork.kernel.org/patch/11332131/),
they were removed because the ICC provider nodes hadn't landed yet.

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 998f101ad623b7..2e11d4ce995778 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1475,6 +1475,9 @@ venus: video-codec@aa00000 {
 				      "vcodec0_core", "vcodec0_bus";
 			iommus = <&apps_smmu 0x0c00 0x60>;
 			memory-region = <&venus_mem>;
+			interconnects = <&mmss_noc MASTER_VIDEO_P0 &mc_virt SLAVE_EBI1>,
+					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_VENUS_CFG>;
+			interconnect-names = "video-mem", "cpu-cfg";
 
 			video-decoder {
 				compatible = "venus-decoder";
-- 
2.26.0.110.g2183baf09c-goog

