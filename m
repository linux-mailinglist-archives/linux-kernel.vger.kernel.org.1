Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260AA26AFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgIOVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgIOVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:46:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD3C061797
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:45:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so930456wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KMVC1YG0Zgl+FYlCNkjyM0mDusyj+CBKlA/V00wdpg=;
        b=Xb7UczPakAqjh0s7AzauUIfKdNEFZ0A8228lXc8AQsdh0Kmwgk5lkpS+1EIwII0dXu
         CIt/VcnjGSZnKr7dAV5DkDLY1s7Gq0NV6PFLJXD1PpTVUFIAYwiC2/97S5XAEWMrXErs
         hKJd0JZ1yFJRuLER8PxCsexh05g/HlAvFn3HozjVa503kS1sZ59CL+E+51w47YvCDi+F
         /1Pcg3HMmAbbxJ4GyeZ8LShbSB7ia87HAp48UYUOeiCzSoSG5v2WR1pamdXFRFjQj3RN
         3++WXdntatcFiy56ghIk6GgXYYYXH/vYAsDUISCeFwz62KMhrKEtOIdyFLejxoUxWCP0
         Dtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KMVC1YG0Zgl+FYlCNkjyM0mDusyj+CBKlA/V00wdpg=;
        b=F612V4SsaiZY2XsqjGTwHoLHDZzqKwGNyK+7BzQZuXRierrrojNDKuriFS9qzMpNgD
         zyjvE8/G93XMI/lh/BQS+R60EIwn3dgSy+SLafRqQGXALsH5GZfCOeZ61bba1ocFCJc5
         vxcD3wfj8LIglTn9OhviHq7EB5o9bgg1m35msw+PqZR72tnJtZm2E8GOnDe92SoYnvKf
         bj82kZJJmnbrNR+Xgnzu2gPd3gFFMTaeNeDDpEm3kJC0sse7kQx1bqQZUTIVX1kDt9Nf
         hCMViguQcmaZDeVBTlSY1v8pFoob8LmoHDDvo6v2cO38X7m/KDwvkVEaYj+yVXBp0EyL
         ixAg==
X-Gm-Message-State: AOAM533LeMbQPA35++iqjB5Z+s9/33iuuwEOmrvpDXJ5u4jg0JYrJ97N
        ew7kjYK0/vCgjcxEzcpXBq0zLw==
X-Google-Smtp-Source: ABdhPJymR6Ry5JFvKnoD5Xxv9aObqndWEzvNlMxWJ9h6FbBqRTfoX1UHM+GtvIxRLfqeaRTG9SEQMg==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr1412838wmm.38.1600206313133;
        Tue, 15 Sep 2020 14:45:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i6sm31643363wra.1.2020.09.15.14.45.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:45:12 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, robdclark@gmail.com, amit.pundir@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Add interconnects property for display
Date:   Wed, 16 Sep 2020 00:45:11 +0300
Message-Id: <20200915214511.786-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interconnect paths that are used by the display (MDSS). This
will allow the driver to request the needed bandwidth and prevent
display flickering.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
This patch depends on:
https://lore.kernel.org/r/20200903133134.17201-6-georgi.djakov@linaro.org/

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 86457d9bc229..f8f09ab3442f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3813,6 +3813,10 @@ mdss: mdss@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
+			interconnects = <&mmss_noc MASTER_MDP0 0 &mem_noc SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_MDP1 0 &mem_noc SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+
 			iommus = <&apps_smmu 0x880 0x8>,
 			         <&apps_smmu 0xc80 0x8>;
 
