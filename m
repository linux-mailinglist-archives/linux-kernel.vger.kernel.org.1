Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267472B9EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgKSX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgKSX4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:20 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE6EC0613CF;
        Thu, 19 Nov 2020 15:56:20 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q16so7680513edv.10;
        Thu, 19 Nov 2020 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oebRCSnpEr283H8Z9J3USGdRiyDuawlvIV/duYzf00I=;
        b=JJgQS4SJpoVZLy9zf/WDnGg/KwUCgZsPc5C+m1XHj0bBga9ArPPn3sYwnUjL3AUnhT
         vniW9eEN3SMuBh7K3vqqu0GhzQSGTCY5MTVotTJCXYOY7f6Ja6CKwN06C6cuAda5UZew
         /ZGP3K93MbnFUNxE46NWMVsUT9S9xccY1dCVbWdwLEJGQ2+CGn2hG0575h2h3FlHD0Yd
         uoay/htWqngpoKTH83ISbhoGsuEL4lLpCuFR+DBI74bwwhDFLLiSMrzC4MHQklZuQ3it
         Eb4i3Z4tYDXZrmKEPqj59QKVdQPtVNTFT53tsBpBaflSNZVChZmAct8BbhSvZcrDSaLO
         oEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oebRCSnpEr283H8Z9J3USGdRiyDuawlvIV/duYzf00I=;
        b=tBZ6jjn+xJ+5uF0+3SKHoBCNdaKGBKMGJQqBk7wl7OJ28JUTFlwpWCCHpgxe5IopqG
         LOt8DpvlSVevskuB7mTC3ieR+QMRDV1byV8rFMyRAHkK5YKf1oNM+Sj1apUfIH9Z9OCu
         8Kl7ZC0DWPoE5Bn+ON4YICEShsE6f1PzHG92N+VUGZefhZjEJg9c7UyZXENNpL6Rev0S
         zMp98SE27nyHulCknrmU1CgkOaGUyyudgIvJQXoQCxU/95oOJUK+UJh15pkepW+Ryftm
         DGTGbvtc1IwrtqdQCHN692wFT3CiioRnG6xYC20Bd3QdoX0DPg9SxwKxW42C/ow8gcyY
         7uMA==
X-Gm-Message-State: AOAM531daorZq592wVyxMgmtDKB2IZbnkBjncY/RPsNmECgrpYDKRFcI
        1X4ihPVkwrA2QqBvjtH0kIM=
X-Google-Smtp-Source: ABdhPJxlNSUEFYhn0X8HnWBe/VjKtEA9sFKrkt4XbO25lsEkcOoQpw3SkM/hDYIeC7tdo3L+ZfQiEQ==
X-Received: by 2002:a05:6402:1acb:: with SMTP id ba11mr32097292edb.48.1605830178947;
        Thu, 19 Nov 2020 15:56:18 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:18 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/18] arm: dts: owl-s500: Add Reset controller
Date:   Fri, 20 Nov 2020 01:55:57 +0200
Message-Id: <29caef019fc29a62e77e59f537f6caa03597cac8.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S500 SoC DTS.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index ac3d04c75dd5..a57ce7d6d745 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 / {
 	compatible = "actions,s500";
@@ -188,6 +189,7 @@ cmu: clock-controller@b0160000 {
 			reg = <0xb0160000 0x8000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		timer: timer@b0168000 {
-- 
2.29.2

