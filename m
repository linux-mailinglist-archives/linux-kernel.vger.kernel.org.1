Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA072584E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 02:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgIAAfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIAAfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:35:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:35:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f2so5417602qkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1h+Z4m7wDNO0C3YgQOk9ULf7HqqBVP3DARz2vlWcqM=;
        b=0YgfD29KFW61aSUj03zT3rqIuzjSwn2XOBZ1dmV1pogKfTpds/qLyxwjGE9+oq++WR
         fcSrnLAgNOL3yVIw52uMfN1U9ofohgkfVdOIMPtC/kgkXfZm4ZnvBQuLWU3kifQUcKPu
         MdBnHdibUg+/Gn9IzNvEHFVnjZ8tgkOLsoF67ZLwOLah2qHkgrTQqBcCrQThfD6ROUtR
         ZC56KqRtJw0sZiz/aFRpZjeNHYKjMbTZrJ2j+m7EUh/Zqny7XjkNxUMlLyfyh1QoFwJK
         o5dUPof0R31BnyEvroneXQz/CWnwvXVgeEj4YNb1C4lucR8gMMjWZzENoEiaTEt0BZ01
         2MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1h+Z4m7wDNO0C3YgQOk9ULf7HqqBVP3DARz2vlWcqM=;
        b=mrCcuiKD6k+g6VHMBR9L+l8OM4uUlqsLUFXNxlF2JMeoTdnda+ScjxBeOEU9Fblz4r
         7pWkYCw5byjUVKBv8qX9T4zp+0rxWy1iaqjJ7W27dFH3M5L+51Q2qZxyJ1+UDL9VZmcY
         QsfSGhsYM08ktoqiINfTOvRQZqINDVX38AbIH8UQiKqO/IpmfRAXVRp8zpqTqIj+6oJt
         RKbga2PUl4O7oM5Z9z0EV17drVqf3EZiIAhaqeTGiD++72jiNi0rLuzxmtpUN6y5htny
         4NLRgcFg7aQ5Nnkrddeev2WYD3SFcpVqKMRL2ysYcq1CERXaSdwXfhLrJS8BxOglZR1O
         aecQ==
X-Gm-Message-State: AOAM531T1qIcfhxXd0sKv7BKwL//ffQhFdJ2qkuqcInjrDgiBSQ4D5pM
        qe9q8Jm8xWhwBm94Uv0x/Zc0EQ==
X-Google-Smtp-Source: ABdhPJzkk38aCbZ8lDflnNZZa3DrorTjRhUVl4b8Gm3wfJppKByyt10onThah9H/JwFhC+CC8K4kXg==
X-Received: by 2002:a05:620a:16b8:: with SMTP id s24mr4057084qkj.67.1598920506032;
        Mon, 31 Aug 2020 17:35:06 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q185sm11438597qke.25.2020.08.31.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:35:05 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: add sm8250 fastrpc nodes
Date:   Mon, 31 Aug 2020 20:33:46 -0400
Message-Id: <20200901003346.12210-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fastrpc nodes for sDSP, cDSP, and aDSP.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 115 ++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 345934fbc251..6d13e60ee6a9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1500,8 +1500,35 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				mboxes = <&ipcc IPCC_CLIENT_SLPI
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 
-				label = "lpass";
+				label = "slpi";
 				qcom,remote-pid = <3>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "dsps";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x0541 0x0>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x0542 0x0>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x0543 0x0>;
+						/* note: shared-cb = <4> in downstream */
+					};
+				};
 			};
 		};
 
@@ -1538,8 +1565,66 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				mboxes = <&ipcc IPCC_CLIENT_CDSP
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 
-				label = "lpass";
+				label = "cdsp";
 				qcom,remote-pid = <5>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x1001 0x0460>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x1002 0x0460>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1003 0x0460>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1004 0x0460>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1005 0x0460>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x1006 0x0460>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x1007 0x0460>;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x1008 0x0460>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
 			};
 		};
 
@@ -3112,6 +3197,32 @@ q6routing: routing {
 						};
 					};
 				};
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1803 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1804 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1805 0x0>;
+					};
+				};
 			};
 		};
 
-- 
2.26.1

