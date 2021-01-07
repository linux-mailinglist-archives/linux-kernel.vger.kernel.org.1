Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1E2ECE2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbhAGKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbhAGKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:50:50 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72AC0612FD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:49:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q7so2670775pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFfCx+LuozwWLtVN8azhQEZlQYaFV/Z/K3Si+kVMmvA=;
        b=M2C8UJWYctlfBsoEloYIC8eHhdbSZatpZnoZ48cwQVMpzTLaeLX2J6QfMH7VrNlV1j
         q+sleU6zxAaLR6FJR+cCZZHLfHAVoP7Nn9dy5wTxrQ596Je1cm8z3bwFrOcYvO8wQm5b
         +mFu4N+xuQ01jyqhnhWNajpW3YvQP156W/Oiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFfCx+LuozwWLtVN8azhQEZlQYaFV/Z/K3Si+kVMmvA=;
        b=I1Tu2RQ4mQhmPGv8+9Py/EjcpbtL6NvdQ/+ctcLsVXeu39EiRRFRPU2qbo+rBO5MGG
         YjKJlqqNlgJNRSPhU9jOKSGMBGqsLjfKr/qTd5IaMmLVpqkd6iM/G+SEBDskUXTJnO65
         NM5p+gnR14wcN3bwDMWDrHPG0RA56EBAXVcPdTqBwWYHx/3Un7G2ttO9v7+NhDbtC1LA
         TGLMK5RmySlbKBJ8qQqK4qwRfrIrrpPDRFeYywR7YOkwRFcS7/zOp0lfYjvcHBjmDSJQ
         cWFwufTFfAfAtjMxxwiqOzbzrt499mW12MaE989eajAK7PVzE8xKfoanWjmvIFDSbilo
         RZzA==
X-Gm-Message-State: AOAM531q09BufQL9q5DwlCdk6JVT0gOhgOFqxCU3bp1PDx/lugH1EJop
        pZTtF72rJ6heGqC3UNufBpnCGg==
X-Google-Smtp-Source: ABdhPJzK0f3Ap54aR5l3MHRTWPZFN5C44dJQBKmXlnRYhT+kskc6pRlqcYllRbLIUaLiuXN+ZxPS2g==
X-Received: by 2002:a05:6a00:134d:b029:1ad:b17:dbc4 with SMTP id k13-20020a056a00134db02901ad0b17dbc4mr1639504pfu.53.1610016577313;
        Thu, 07 Jan 2021 02:49:37 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id n10sm5381974pfu.176.2021.01.07.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:49:36 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8183: Add domain supply for mfg
Date:   Thu,  7 Jan 2021 18:49:16 +0800
Message-Id: <20210107104915.2888408-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107104915.2888408-1-hsinyi@chromium.org>
References: <20210107104915.2888408-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add domain supply for mfg node.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf2ad1294dd30..ebd53755d538a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -709,6 +709,10 @@ cros_ec {
 	};
 };
 
+&mfg {
+	domain-supply = <&mt6358_vgpu_reg>;
+};
+
 &soc_data {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5b782a4769e7e..bda283fa92452 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -360,7 +360,7 @@ power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
-					power-domain@MT8183_POWER_DOMAIN_MFG {
+					mfg: power-domain@MT8183_POWER_DOMAIN_MFG {
 						reg = <MT8183_POWER_DOMAIN_MFG>;
 						#address-cells = <1>;
 						#size-cells = <0>;
-- 
2.29.2.729.g45daf8777d-goog

